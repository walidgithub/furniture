import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../model/models.dart';

abstract class BaseRepository {
  Future<Either<Failure, List<Chair>>> getChair();
  Future<Either<Failure, List<Dining>>> getTable();
  Future<Either<Failure, List<Sofa>>> getSofa();
  Future<Either<Failure, List<Cupboard>>> getCupboard();

  Future<Either<Failure, List<Chair>>> getAllChairs();
  Future<Either<Failure, List<Dining>>> getAllTables();
  Future<Either<Failure, List<Sofa>>> getAllSofas();
  Future<Either<Failure, List<Cupboard>>> getAllCupboards();

  Future<Either<Failure, List<Carts>>> getAllCarts();

  Future<Either<Failure, List<ChairDetails>>> getChairDetails(int chairId);
  Future<Either<Failure, List<TableDetails>>> getTableDetails(int tableId);
  Future<Either<Failure, List<SofaDetails>>> getSofaDetails(int sofaId);
  Future<Either<Failure, List<CupboardDetails>>> getCupboardDetails(int cupboardId);

  Future<Either<Failure, List<Chair>>> searchForChair(String searchTitle);
  Future<Either<Failure, List<Dining>>> searchForTable(String searchTitle);
  Future<Either<Failure, List<Sofa>>> searchForSofa(String searchTitle);
  Future<Either<Failure, List<Cupboard>>> searchForCupboard(String searchTitle);
}
