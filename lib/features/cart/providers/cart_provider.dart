import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_item.dart';

import '../../../data/models/product_model.dart';



class CartNotifier extends StateNotifier<List<CartItem>> {


  CartNotifier()
      : super([]);




  void addToCart(ProductModel product) {


    final existingIndex = state.indexWhere(

      (item) => item.product.id == product.id,

    );



    if(existingIndex >= 0){


      state = [

        for(int i = 0; i < state.length; i++)

          if(i == existingIndex)

            CartItem(

              product: state[i].product,

              quantity:
                  state[i].quantity + 1,

            )

          else

            state[i],

      ];



    } else {


      state = [

        ...state,

        CartItem(

          product: product,

        ),

      ];


    }


  }





  void removeFromCart(int productId){


    state = state.where(

      (item) =>
          item.product.id != productId,

    ).toList();


  }





  void increaseQuantity(int productId){


    state = [

      for(final item in state)

        if(item.product.id == productId)

          CartItem(

            product: item.product,

            quantity: item.quantity + 1,

          )

        else

          item

    ];


  }





  void decreaseQuantity(int productId){


    state = [

      for(final item in state)

        if(item.product.id == productId &&
            item.quantity > 1)

          CartItem(

            product: item.product,

            quantity: item.quantity - 1,

          )

        else

          item

    ];


  }




  double get totalAmount {


    return state.fold(

      0,

      (sum,item)=>

          sum + item.totalPrice,

    );


  }


}




final cartProvider =

    StateNotifierProvider<CartNotifier,List<CartItem>>(

      (ref){

        return CartNotifier();

      },

    );