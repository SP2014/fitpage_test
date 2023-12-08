import 'package:dio/dio.dart';
import 'package:fitpage_test/src/core/constants/api_constants.dart';
import 'package:fitpage_test/src/core/networking/api_client.dart';
import 'package:fitpage_test/src/features/stocks/data/data.dart';
import 'package:fitpage_test/src/features/stocks/domain/domain.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
Dio dioClient(DioClientRef ref) =>
    Dio(BaseOptions(baseUrl: ApiConstant.baseUrl));

@riverpod
ApiClient client(ClientRef ref) =>
    ApiClient(ref.read(dioClientProvider), baseUrl: ApiConstant.baseUrl);

@riverpod
IStockRepository stockRepository(StockRepositoryRef ref) =>
    StockRepositoryImpl(apiClient: ref.read(clientProvider));

@riverpod
Future<Either<Failure, List<StockModel>>> getStocks(GetStocksRef ref) =>
    ref.watch(stockRepositoryProvider).getStocks();
