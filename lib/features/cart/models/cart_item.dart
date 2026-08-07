import '../../../data/models/product_model.dart';


class CartItem {

  final ProductModel product;

  int quantity;


  CartItem({

    required this.product,

    this.quantity = 1,

  });



  double get totalPrice {

    return product.price * quantity;

  }


}