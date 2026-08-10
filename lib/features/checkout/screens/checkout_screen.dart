import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cart/providers/cart_provider.dart';
import '../../orders/models/order_model.dart';
import '../../orders/providers/order_provider.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    // Calculate subtotal from cart items.
    final subtotal = cart.fold<double>(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );

    // Shipping fee.
    const shippingFee = 50.0;

    // Final total.
    final total = subtotal + shippingFee;

    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),

      body: cart.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Your cart is empty 🛒',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Summary
                  Row(
                    children: [
                      Icon(
                        Icons.receipt_long,
                        color: primaryColor,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Order Summary',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Cart Items
                  ...cart.map(
                    (item) => Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),

                        leading: Container(
                          width: 55,
                          height: 55,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: Image.network(
                            item.product.image,
                            fit: BoxFit.contain,
                            errorBuilder: (
                              context,
                              error,
                              stackTrace,
                            ) {
                              return Icon(
                                Icons.image_not_supported,
                                color: primaryColor,
                              );
                            },
                          ),
                        ),

                        title: Text(
                          item.product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        subtitle: Padding(
                          padding:
                              const EdgeInsets.only(top: 5),
                          child: Text(
                            'Quantity: ${item.quantity}',
                          ),
                        ),

                        trailing: Text(
                          '\$${item.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Price Summary
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          _priceRow(
                            'Subtotal',
                            '\$${subtotal.toStringAsFixed(2)}',
                          ),

                          const SizedBox(height: 12),

                          _priceRow(
                            'Shipping',
                            '\$${shippingFee.toStringAsFixed(2)}',
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            child: Divider(),
                          ),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${total.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Payment Method
                  Row(
                    children: [
                      Icon(
                        Icons.payment,
                        color: primaryColor,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Payment Method',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        color: primaryColor,
                        width: 1.5,
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            primaryColor.withValues(
                          alpha: 0.1,
                        ),
                        child: Icon(
                          Icons.local_shipping,
                          color: primaryColor,
                        ),
                      ),
                      title: const Text(
                        'Cash on Delivery',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        'Pay when your order arrives',
                      ),
                      trailing: Icon(
                        Icons.check_circle,
                        color: primaryColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Place Order Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15),
                        ),
                      ),
onPressed: () async {
                        // Create the order before clearing the cart.
                        final order = OrderModel(
                          id: DateTime.now()
                              .millisecondsSinceEpoch
                              .toString(),
                          items: List.from(cart),
                          subtotal: subtotal,
                          shippingFee: shippingFee,
                          total: total,
                          date: DateTime.now(),
                          status: 'Processing',
                        );

                        // Save the order.
                await ref
    .read(orderProvider.notifier)
    .addOrder(order);

                        // Clear the cart.
                        ref
                            .read(cartProvider.notifier)
                            .clearCart();

                        // Show success dialog.
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (dialogContext) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20),
                              ),
                              title: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: primaryColor,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  const Expanded(
                                    child: Text(
                                      'Order Successful!',
                                    ),
                                  ),
                                ],
                              ),
                              content: const Text(
                                'Your order has been placed successfully. Thank you for shopping with us! 🎉',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(
                                      dialogContext,
                                    ).pop();

                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Continue Shopping',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_bag,
                      ),
                      label: const Text(
                        'Place Order',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Widget _priceRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}