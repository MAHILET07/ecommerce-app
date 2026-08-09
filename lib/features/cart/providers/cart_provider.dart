import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_item.dart';
import '../../../data/models/product_model.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    return [];
  }

  void addToCart(ProductModel product) {
    final index = state.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      final updatedCart = [...state];

      updatedCart[index] = CartItem(
        product: product,
        quantity: updatedCart[index].quantity + 1,
      );

      state = updatedCart;
    } else {
      state = [
        ...state,
        CartItem(
          product: product,
        ),
      ];
    }
  }

  void removeFromCart(int productId) {
    state = state
        .where(
          (item) => item.product.id != productId,
        )
        .toList();
  }

  void increaseQuantity(int productId) {
    final updatedCart = [...state];

    final index = updatedCart.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index != -1) {
      updatedCart[index] = CartItem(
        product: updatedCart[index].product,
        quantity: updatedCart[index].quantity + 1,
      );

      state = updatedCart;
    }
  }

  void decreaseQuantity(int productId) {
    final updatedCart = [...state];

    final index = updatedCart.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index != -1) {
      if (updatedCart[index].quantity > 1) {
        updatedCart[index] = CartItem(
          product: updatedCart[index].product,
          quantity: updatedCart[index].quantity - 1,
        );
      } else {
        updatedCart.removeAt(index);
      }

      state = updatedCart;
    }
  }

  void clearCart() {
    state = [];
  }

  double get totalAmount {
    return state.fold(
      0,
      (sum, item) => sum + item.totalPrice,
    );
  }
}

final cartProvider =
    NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);