import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../data/models/product_model.dart';



final productRepositoryProvider =
    Provider<ProductRepository>((ref){

  return ProductRepository(
    ApiClient(),
  );

});



final productsProvider =
    FutureProvider<List<ProductModel>>(
        (ref) async {


  return ref
      .read(productRepositoryProvider)
      .getProducts();


});