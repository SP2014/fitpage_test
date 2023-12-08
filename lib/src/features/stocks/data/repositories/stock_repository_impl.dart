import 'package:dio/dio.dart';
import 'package:fitpage_test/src/core/core.dart';
import 'package:fitpage_test/src/features/stocks/data/models/failure.dart';
import 'package:fitpage_test/src/features/stocks/data/models/stock_model.dart';
import 'package:fitpage_test/src/features/stocks/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class StockRepositoryImpl implements IStockRepository {
  final ApiClient apiClient;

  StockRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, List<StockModel>>> getStocks() async {
    try {
      final response = await apiClient.getStocks();
      return right(response);
    } on DioException catch (e) {
      return left(Failure(e.message ?? 'API Exception', e.stackTrace));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
