import 'package:dio/dio.dart';
import 'package:fitpage_test/src/core/constants/api_constants.dart';
import 'package:fitpage_test/src/features/stocks/data/data.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @GET(ApiConstant.getStocks)
  Future<List<StockModel>> getStocks();
}
