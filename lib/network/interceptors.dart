import 'package:dio/dio.dart';

class AuthInterCeptors extends Interceptor {
  // @override
  // void onError(DioException err, errInterceptorHandler handler) async {
  //   super.onError(err, handler);
  //   if (err.response?.statusCode == 401) {
  //     String? refreshToken = await LocalStorage.getRefreshToken();
  //     String newToken = await refreshTokenCall(refreshToken);
  //     err.requestOptions.headers[AppConstant.authorization] =
  //         "Bearer $newToken";
  //     return handler.resolve(await dio.fetch(err.requestOptions));
  //   }
  //   return handler.next(err);
  // }
}
