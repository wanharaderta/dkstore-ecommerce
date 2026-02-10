import 'package:dkstore/config/api_base_helper.dart';
import 'package:dkstore/config/api_routes.dart';

import '../../../config/constant.dart';
import '../../../services/location/location_service.dart';

class CategoryRepository {
  Future<Map<String, dynamic>> fetchCategory({
    required int perPage,
    required int currentPage,
    String? categoryIds
}) async {
    try{
      final locationService = LocationService.getStoredLocation();
      final latitude = locationService!.latitude;
      final longitude = locationService.longitude;
      String categoryParam = '';
      if(categoryIds != null && categoryIds.isNotEmpty){
        categoryParam = '&ids=$categoryIds';
      }
      final response = await AppConstant.apiBaseHelper.getAPICall(
        '${ApiRoutes.categoryApi}?per_page=$perPage&page=$currentPage&latitude=$latitude&longitude=$longitude$categoryParam',
        {}
      );
      return response.data;
    }catch(e){
      throw ApiException('Failed to fetch categories');
    }
  }
}