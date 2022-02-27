import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/service.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/services/http.service.dart';
import 'package:fuodz/services/location.service.dart';

class SearchRequest extends HttpService {
  //
  Future<List<List<dynamic>>> searchRequest({
    String keyword = "",
    String categoryId = null,
    String vendorTypeId = null,
    int vendorId = null,
    String type = "",
    int page = 1,
  }) async {
    final params = {
      "page": page,
      "keyword": keyword,
      "category_id": categoryId,
      "vendor_type_id": vendorTypeId,
      "vendor_id": vendorId,
      "type": type,
      "latitude": LocationService?.currenctAddress?.coordinates?.latitude,
      "longitude": LocationService?.currenctAddress?.coordinates?.longitude,
    };

    // print("params ==> $params");
    final apiResult = await get(Api.search, queryParameters: params);
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      //
      List<List> result = [];
      List<Product> products = [];
      List<Service> services = [];
      List<Vendor> vendors = [];

      //
      if (apiResponse.body["products"] is Map) {
        products = (apiResponse.body["products"]["data"] as List)
            .map((jsonObject) => Product.fromJson(jsonObject))
            .toList();
      }
      //
      if (apiResponse.body["services"] is Map) {
        services = (apiResponse.body["services"]["data"] as List)
            .map((jsonObject) => Service.fromJson(jsonObject))
            .toList();
      }

      if ((apiResponse.body["vendors"] is Map)) {
        vendors = (apiResponse.body["vendors"]["data"] as List).map(
          (jsonObject) {
            try {
              return Vendor.fromJson(jsonObject);
            } catch (error) {
              print("Error ==> $error");
            }
          },
        ).toList();
      }
      //
      result.add(products);
      result.add(vendors);
      result.add(services);

      return result;
    }

    throw apiResponse.message;
  }
}
