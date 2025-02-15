import 'package:dio/dio.dart';
import 'package:qoruz/network/api_end_points.dart';
import 'package:qoruz/network/base_api_service.dart';
import 'package:qoruz/network/network_api_service.dart';

class MarketPlaceRepo {
  final BaseApiService apiService = NetworkApiService();

  Future<Response> getMarketList(int page) async {
    Response response = await apiService.getResponse(
      "${ApiEndPoints.PAGE}$page",
    );
    return response;
  }
}
