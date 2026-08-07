import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/product_model.dart';


class FavoriteNotifier extends StateNotifier<List<ProductModel>> {


  FavoriteNotifier() : super([]);



  void toggleFavorite(ProductModel product) {


    final exists = state.any(
      (item) => item.id == product.id,
    );



    if (exists) {

      state = state
          .where(
            (item) => item.id != product.id,
          )
          .toList();


    } else {


      state = [

        ...state,

        product,

      ];


    }


  }



  bool isFavorite(ProductModel product) {


    return state.any(
      (item) => item.id == product.id,
    );


  }


}



final favoriteProvider =

StateNotifierProvider<FavoriteNotifier, List<ProductModel>>(

  (ref) => FavoriteNotifier(),

);