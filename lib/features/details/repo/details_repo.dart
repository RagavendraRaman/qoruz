import 'package:dio/dio.dart';
import 'package:qoruz/network/api_end_points.dart';
import 'package:qoruz/network/base_api_service.dart';
import 'package:qoruz/network/network_api_service.dart';

class DetailsRepo {
  final BaseApiService apiService = NetworkApiService();

  Future<Response> getDetails(String id) async {
    Response response = await apiService.getResponse(
      "${ApiEndPoints.ID_HASH}$id",
    );
    return response;
  }
}
