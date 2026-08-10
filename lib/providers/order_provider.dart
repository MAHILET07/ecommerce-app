import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/order_model.dart';

class OrderNotifier extends Notifier<List<OrderModel>> {
  @override
  List<OrderModel> build() {
    return [];
  }

  void addOrder(OrderModel order) {
    state = [
      order,
      ...state,
    ];
  }

  void clearOrders() {
    state = [];
  }
}

final orderProvider =
    NotifierProvider<OrderNotifier, List<OrderModel>>(
  OrderNotifier.new,
);
