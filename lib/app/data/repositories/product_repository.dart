import 'package:dummyjsonproduct/app/data/models/apiResponse/api_response.dart';
import 'package:dummyjsonproduct/app/data/models/product/product.dart';
import 'package:dummyjsonproduct/app/data/services/api_service.dart';

typedef ProductListResponse = ApiResponse<List<Product>>;
typedef JsonResponse = ApiResponse<dynamic>;

class ProductRepository {
  final ApiService _api;

  ProductRepository(this._api);

  Future<ProductListResponse> getProducts() async {
    JsonResponse data = await _api.get('products');
    
    return data.when(
        loading: () => ProductListResponse.loading(),
        success: (jsonData) {
          var productsJson = jsonData['products'] as List<dynamic>;
          var products =
              productsJson.map((json) => Product.fromJson(json)).toList();
          return ProductListResponse.success(products);
        },
        failed: (message, error) => ProductListResponse.failed(message, error));
  }
}
