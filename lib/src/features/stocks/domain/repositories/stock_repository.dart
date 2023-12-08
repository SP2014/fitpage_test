import 'package:fitpage_test/src/features/stocks/data/data.dart';
import 'package:fpdart/fpdart.dart';

abstract class IStockRepository {
  Future<Either<Failure, List<StockModel>>> getStocks();
}
