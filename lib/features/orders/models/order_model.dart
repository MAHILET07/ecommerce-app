import '../../cart/models/cart_item.dart';
import '../../../data/models/product_model.dart';

class OrderModel {
  final String id;
  final List<CartItem> items;
  final double subtotal;
  final double shippingFee;
  final double total;
  final DateTime date;
  final String status;

  OrderModel({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.shippingFee,
    required this.total,
    required this.date,
    required this.status,
  });

  // Convert order to JSON for local storage.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) {
        return {
          'product': {
            'id': item.product.id,
            'title': item.product.title,
            'price': item.product.price,
            'description': item.product.description,
            'category': item.product.category,
            'image': item.product.image,
            'rating': item.product.rating,
          },
          'quantity': item.quantity,
        };
      }).toList(),
      'subtotal': subtotal,
      'shippingFee': shippingFee,
      'total': total,
      'date': date.toIso8601String(),
      'status': status,
    };
  }

  // Convert saved JSON back into an OrderModel.
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List).map((item) {
      final productData =
          Map<String, dynamic>.from(item['product']);

      final product = ProductModel(
        id: productData['id'],
        title: productData['title'],
        price: (productData['price'] as num).toDouble(),
        description: productData['description'],
        category: productData['category'],
        image: productData['image'],
        rating: (productData['rating'] as num).toDouble(),
      );

      return CartItem(
        product: product,
        quantity: item['quantity'],
      );
    }).toList();

    return OrderModel(
      id: json['id'],
      items: items,
      subtotal: (json['subtotal'] as num).toDouble(),
      shippingFee: (json['shippingFee'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      status: json['status'],
    );
  }
}