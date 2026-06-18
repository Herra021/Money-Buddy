import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/onboarding/onboarding_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/dashboard/dashboard_screen.dart';
import '../../screens/expense/add_expense_screen.dart';
import '../../screens/income/add_income_screen.dart';
import '../../screens/transactions/transaction_history_screen.dart';
import '../../screens/borrow_lend/borrow_lend_screen.dart';
import '../../screens/borrow_lend/add_borrow_lend_screen.dart';
import '../../screens/reminders/reminders_screen.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/shell/main_shell.dart';

class AppRoutes {
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const addExpense = '/add-expense';
  static const addIncome = '/add-income';
  static const transactions = '/transactions';
  static const borrowLend = '/borrow-lend';
  static const addBorrowLend = '/add-borrow-lend';
  static const reminders = '/reminders';
  static const settings = '/settings';
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((dynamic _) => notifyListeners());
  }
  late final StreamSubscription<dynamic> _subscription;
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.onboarding,
    refreshListenable: GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final onboardingDone = prefs.getBool('onboarding_done') ?? false;
      final loggedIn = FirebaseAuth.instance.currentUser != null;

      if (!onboardingDone && state.matchedLocation != AppRoutes.onboarding) {
        return AppRoutes.onboarding;
      }
      if (onboardingDone && !loggedIn && state.matchedLocation != AppRoutes.login) {
        return AppRoutes.login;
      }
      if (loggedIn && (state.matchedLocation == AppRoutes.login || state.matchedLocation == AppRoutes.onboarding)) {
        return AppRoutes.dashboard;
      }
      return null;
    },
    routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.dashboard,
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: AppRoutes.transactions,
          builder: (context, state) => const TransactionHistoryScreen(),
        ),
        GoRoute(
          path: AppRoutes.borrowLend,
          builder: (context, state) => const BorrowLendScreen(),
        ),
        GoRoute(
          path: AppRoutes.reminders,
          builder: (context, state) => const RemindersScreen(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.addExpense,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return AddExpenseScreen(prefilled: extra);
      },
    ),
    GoRoute(
      path: AppRoutes.addIncome,
      builder: (context, state) => const AddIncomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.addBorrowLend,
      builder: (context, state) => const AddBorrowLendScreen(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
});
