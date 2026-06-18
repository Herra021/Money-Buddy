import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/database/database_helper.dart';
import '../models/borrow_lend_model.dart';
import 'transaction_provider.dart';

class BorrowLendNotifier extends StateNotifier<AsyncValue<List<BorrowLendModel>>> {
  final DatabaseHelper _db;

  BorrowLendNotifier(this._db) : super(const AsyncValue.loading()) {
    _load();
  }

  Future<void> _load({String? type}) async {
    state = const AsyncValue.loading();
    try {
      final maps = await _db.getBorrowLend(type: type);
      state = AsyncValue.data(maps.map(BorrowLendModel.fromMap).toList());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> add(BorrowLendModel item) async {
    await _db.insertBorrowLend(item.toMap());
    await _load();
  }

  Future<void> markAsPaid(int id) async {
    await _db.updateBorrowLend(id, {'is_paid': 1});
    await _load();
  }

  Future<void> delete(int id) async {
    await _db.deleteBorrowLend(id);
    await _load();
  }

  void refresh() => _load();
}

final borrowLendProvider = StateNotifierProvider<BorrowLendNotifier, AsyncValue<List<BorrowLendModel>>>(
  (ref) => BorrowLendNotifier(ref.read(dbProvider)),
);

// Separate providers for lend and borrow filtered views
final lendListProvider = Provider<List<BorrowLendModel>>((ref) {
  final all = ref.watch(borrowLendProvider);
  return all.maybeWhen(
    data: (list) => list.where((e) => e.isLend).toList(),
    orElse: () => [],
  );
});

final borrowListProvider = Provider<List<BorrowLendModel>>((ref) {
  final all = ref.watch(borrowLendProvider);
  return all.maybeWhen(
    data: (list) => list.where((e) => e.isBorrow).toList(),
    orElse: () => [],
  );
});
