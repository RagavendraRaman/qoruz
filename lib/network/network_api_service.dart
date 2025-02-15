import 'dart:developer';
import 'package:dio/dio.dart';
import 'base_api_service.dart';

class NetworkApiService extends BaseApiService {
  final String baseUrl =
      "https://staging3.hashfame.com/api/v1/interview.mplist?";
  final Dio dio = Dio();

  @override
  Future getResponse(String endPoint) async {
    Response responseJson;
    try {
      responseJson = await dio.get(
        baseUrl + endPoint,
      );
    } on DioException catch (e) {
      log("err ${e.toString()}");
      return e.response;
    }
    log("response json $responseJson");
    return responseJson;
  }
}
