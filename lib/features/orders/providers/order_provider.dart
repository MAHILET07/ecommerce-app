import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/storage_service.dart';
import '../../../providers/storage_provider.dart';
import '../models/order_model.dart';

class OrderNotifier extends Notifier<List<OrderModel>> {
  late final StorageService _storage;

  @override
  List<OrderModel> build() {
    _storage = ref.read(storageProvider);

    _loadOrders();

    return [];
  }

  Future<void> _loadOrders() async {
    final savedOrders = await _storage.getOrders();

    state = savedOrders
        .map(
          (json) => OrderModel.fromJson(json),
        )
        .toList();
  }

  Future<void> addOrder(OrderModel order) async {
    state = [
      order,
      ...state,
    ];

    await _saveOrders();
  }

  Future<void> _saveOrders() async {
    final ordersJson = state
        .map(
          (order) => order.toJson(),
        )
        .toList();

    await _storage.saveOrders(
      ordersJson,
    );
  }

  Future<void> clearOrders() async {
    state = [];

    await _storage.clearOrders();
  }
}

final orderProvider =
    NotifierProvider<OrderNotifier, List<OrderModel>>(
  OrderNotifier.new,
);