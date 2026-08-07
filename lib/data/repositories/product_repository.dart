import '../models/product_model.dart';
import '../../core/network/api_client.dart';


class ProductRepository {


  final ApiClient apiClient;


  ProductRepository(
      this.apiClient);



  Future<List<ProductModel>> getProducts() async {


    final response =
        await apiClient.dio.get(
          '/products',
        );


    return (response.data as List)

        .map(
          (product) =>
              ProductModel.fromJson(product),
        )

        .toList();

  }


}