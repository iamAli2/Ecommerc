import 'package:ecommerce_app/Data/ApiResponse/networkApiResponse.dart';
import 'package:ecommerce_app/Utils/Constant/string_constant.dart';

import '../../Models/strore_Model.dart';
import '../../Utils/Constant/countryCode.dart';

class HomeRepository {
  final _apiService = NetworkApiService();

  Future<List<Store>> userListApi() async {
    try {
      dynamic response = await _apiService.getGetApiResponse(appUrlForProduct);

      List<dynamic> responseData = response;

      List<Store> storeList =
          responseData.map((data) => Store.fromJson(data)).toList();

      return storeList;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> getCountryPhoneCode() async {
    try {
      dynamic response =
          await _apiService.getGetApiResponse('http://ip-api.com/json');
      final isoCode = response['countryCode'];

      var data = Countries.allCountries.firstWhere(
        (element) => element['code'] == isoCode,
        orElse: () => Countries.allCountries.first,
      )['dial_code'];

      return data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
