import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/database/database_helper.dart';
import '../core/notifications/notification_service.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: '969305779854-9sq0l5udep0d7bi4vdocg3lp9uaigie5.apps.googleusercontent.com',
  );

  AuthNotifier(this._auth) : super(const AsyncData(null));

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        state = const AsyncData(null);
        return; // User canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    state = const AsyncLoading();
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteAccount() async {
    state = const AsyncLoading();
    try {
      // 1. Wipe local database tables
      await DatabaseHelper().clearAllData();

      // 2. Clear scheduled local notifications
      await NotificationService().cancelAll();

      // 3. Clear all shared preferences (returns app to clean factory settings)
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // 4. Perform auth deletion
      final user = _auth.currentUser;
      if (user != null) {
        await user.delete();
        await _googleSignIn.signOut();
      }
      state = const AsyncData(null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        state = AsyncError(
            'Security requirement: Please sign out and sign back in before deleting your account.',
            StackTrace.current);
      } else {
        state = AsyncError(e, StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<void>>((ref) {
  return AuthNotifier(ref.watch(firebaseAuthProvider));
});
