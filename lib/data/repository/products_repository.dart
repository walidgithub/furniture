import 'package:dartz/dartz.dart';
import 'package:furniture/core/error/failure.dart';
import 'package:furniture/data/datasource/products_remote_datasource.dart';
import 'package:furniture/domain/model/models.dart';
import 'package:furniture/domain/repository/repository.dart';

import '../../core/error/error_handler.dart';
import '../../core/network/network_info.dart';
import '../datasource/products_local_datasource.dart';

class ProductsRepository extends BaseRepository {
  final BaseRemoteDataSource _baseRemoteDataSource;
  final BaseLocalDataSource _baseLocalDataSource;
  final NetworkInfo _networkInfo;

  ProductsRepository(
      this._baseRemoteDataSource, this._baseLocalDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<Chair>>> getChair() async {

    if (await _networkInfo.isConnected) {

      try {

        final remoteChair = await _baseRemoteDataSource.getChair();

        _baseLocalDataSource.casheTopChair(remoteChair);

        return Right(remoteChair);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        final localChair = await _baseLocalDataSource.getCashedTopChair();
        return Right(localChair);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Dining>>> getTable() async {
    if (await _networkInfo.isConnected) {
      try {
        final remoteTable = await _baseRemoteDataSource.getTable();

        _baseLocalDataSource.casheTopTable(remoteTable);

        return Right(remoteTable);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        final localTable = await _baseLocalDataSource.getCashedTopTable();
        return Right(localTable);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Sofa>>> getSofa() async {
    if (await _networkInfo.isConnected) {
      try {
        final remoteSofa = await _baseRemoteDataSource.getSofa();

        _baseLocalDataSource.casheTopSofa(remoteSofa);

        return Right(remoteSofa);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        final localSofa = await _baseLocalDataSource.getCashedTopSofa();
        return Right(localSofa);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Cupboard>>> getCupboard() async {
    if (await _networkInfo.isConnected) {
      try {
        final remoteCupboard = await _baseRemoteDataSource.getCupboard();

        _baseLocalDataSource.casheTopCupboard(remoteCupboard);

        return Right(remoteCupboard);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        final localCupboard = await _baseLocalDataSource.getCashedTopCupboard();
        return Right(localCupboard);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }

  // ---------------------------------------------

  @override
  Future<Either<Failure, List<Dining>>> getAllTables() async{
    if (await _networkInfo.isConnected) {
      try {
        final remoteTable = await _baseRemoteDataSource.getAllTables();

        _baseLocalDataSource.casheAllTable(remoteTable);
        return Right(remoteTable);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        final localTable = await _baseLocalDataSource.getCashedAllTable();
        return Right(localTable);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Chair>>> getAllChairs() async{
    if (await _networkInfo.isConnected) {
      try {
        final remoteChair = await _baseRemoteDataSource.getAllChairs();

        _baseLocalDataSource.casheAllChair(remoteChair);
        return Right(remoteChair);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        final localChair = await _baseLocalDataSource.getCashedAllChair();
        return Right(localChair);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Sofa>>> getAllSofas() async{
    if (await _networkInfo.isConnected) {
      try {
        final remoteSofa = await _baseRemoteDataSource.getAllSofas();

        _baseLocalDataSource.casheAllSofa(remoteSofa);
        return Right(remoteSofa);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        final localSofa = await _baseLocalDataSource.getCashedAllSofa();
        return Right(localSofa);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Cupboard>>> getAllCupboards() async{
    if (await _networkInfo.isConnected) {
      try {
        final remoteCupboard = await _baseRemoteDataSource.getAllCupboards();

        _baseLocalDataSource.casheAllCupboard(remoteCupboard);
        return Right(remoteCupboard);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        final localCupboard = await _baseLocalDataSource.getCashedAllCupboard();
        return Right(localCupboard);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }

  // ---------------------------------------------------

  @override
  Future<Either<Failure, List<ChairDetails>>> getChairDetails(int idChair) async{
    if (await _networkInfo.isConnected) {
      try {
        final remoteChair = await _baseRemoteDataSource.getChairDetails(idChair);

        // print('${remoteChair} chair repository');
        // _baseLocalDataSource.casheFurniture(remoteChair);
        return Right(remoteChair);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        // final localChair = await _baseLocalDataSource.getLastChair();
        final remoteChair = await _baseRemoteDataSource.getChairDetails(idChair);
        return Right(remoteChair);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<TableDetails>>> getTableDetails(int idTable) async{
    if (await _networkInfo.isConnected) {
      try {
        final remoteTable = await _baseRemoteDataSource.getTableDetails(idTable);

        // print('${remoteChair} chair repository');
        // _baseLocalDataSource.casheFurniture(remoteChair);
        return Right(remoteTable);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        // final localChair = await _baseLocalDataSource.getLastChair();
        final remoteTable = await _baseRemoteDataSource.getTableDetails(idTable);
        return Right(remoteTable);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<SofaDetails>>> getSofaDetails(int idSofa) async{
    if (await _networkInfo.isConnected) {
      try {
        final remoteSofa = await _baseRemoteDataSource.getSofaDetails(idSofa);

        // print('${remoteChair} chair repository');
        // _baseLocalDataSource.casheFurniture(remoteChair);
        return Right(remoteSofa);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        // final localChair = await _baseLocalDataSource.getLastChair();
        final remoteSofa = await _baseRemoteDataSource.getSofaDetails(idSofa);
        return Right(remoteSofa);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<CupboardDetails>>> getCupboardDetails(int idCupboard) async{
    if (await _networkInfo.isConnected) {
      try {
        final remoteCupboard = await _baseRemoteDataSource.getCupboardDetails(idCupboard);

        // print('${remoteChair} chair repository');
        // _baseLocalDataSource.casheFurniture(remoteChair);
        return Right(remoteCupboard);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        // final localChair = await _baseLocalDataSource.getLastChair();
        final remoteCupboard = await _baseRemoteDataSource.getCupboardDetails(idCupboard);
        return Right(remoteCupboard);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }

  // -----------------------------------------------------

  @override
  Future<Either<Failure, List<Chair>>> searchForChair(String searchTitle) async {
    if (await _networkInfo.isConnected) {
      try {
        final remoteChair = await _baseRemoteDataSource.searchForChair(searchTitle);

        // _baseLocalDataSource.casheFurniture(remoteChair);
        return Right(remoteChair);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        // final localChair = await _baseLocalDataSource.getLastChair();
        final remoteChair = await _baseRemoteDataSource.searchForChair(searchTitle);
        return Right(remoteChair);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Dining>>> searchForTable(String searchTitle) async {
    if (await _networkInfo.isConnected) {
      try {
        final remoteTable = await _baseRemoteDataSource.searchForTable(searchTitle);

        // _baseLocalDataSource.casheFurniture(remoteChair);
        return Right(remoteTable);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        // final localChair = await _baseLocalDataSource.getLastChair();
        final remoteTable = await _baseRemoteDataSource.searchForTable(searchTitle);
        return Right(remoteTable);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Sofa>>> searchForSofa(String searchTitle) async {
    if (await _networkInfo.isConnected) {
      try {
        final remoteSofa = await _baseRemoteDataSource.searchForSofa(searchTitle);

        // _baseLocalDataSource.casheFurniture(remoteChair);
        return Right(remoteSofa);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        // final localChair = await _baseLocalDataSource.getLastChair();
        final remoteSofa = await _baseRemoteDataSource.searchForSofa(searchTitle);
        return Right(remoteSofa);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Cupboard>>> searchForCupboard(String searchTitle) async {
    if (await _networkInfo.isConnected) {
      try {
        final remoteCupboard = await _baseRemoteDataSource.searchForCupboard(searchTitle);

        // _baseLocalDataSource.casheFurniture(remoteChair);
        return Right(remoteCupboard);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        // final localChair = await _baseLocalDataSource.getLastChair();
        final remoteCupboard = await _baseRemoteDataSource.searchForCupboard(searchTitle);
        return Right(remoteCupboard);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }

  // --------------------------------------------

  @override
  Future<Either<Failure, List<Carts>>> getAllCarts() async {
    if (await _networkInfo.isConnected) {
      try {
        final remoteCart = await _baseRemoteDataSource.getAllCarts();

        // _baseLocalDataSource.casheAllChair(remoteChair);
        return Right(remoteCart);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try{
        // final localChair = await _baseLocalDataSource.getLastChair();
        final remoteCart = await _baseRemoteDataSource.getAllCarts();
        return Right(remoteCart);
      } catch (error) {
        return Left(DataSource.CACHE_ERROR.getFailure());
      }
    }
  }
}
