import 'dart:convert';

import 'package:dio/dio.dart';
import '../../core/error/error_handler.dart';
import '../../core/network/api_constants.dart';
import '../models/chair_model.dart';
import '../models/cupboard_model.dart';
import '../models/sofa_model.dart';
import '../models/table_model.dart';

abstract class BaseRemoteDataSource {
  Future<List<ChairModel>> getChair();
  Future<List<TableModel>> getTable();
  Future<List<SofaModel>> getSofa();
  Future<List<CupboardModel>> getCupboard();

  Future<List<ChairModel>> getAllChairs();
  Future<List<TableModel>> getAllTables();
  Future<List<SofaModel>> getAllSofas();
  Future<List<CupboardModel>> getAllCupboards();

  Future<List<CartsModel>> getAllCarts();

  Future<List<ChairDetailsModel>> getChairDetails(int idChair);
  Future<List<TableDetailsModel>> getTableDetails(int idTable);
  Future<List<SofaDetailsModel>> getSofaDetails(int idSofa);
  Future<List<CupboardDetailsModel>> getCupboardDetails(int idCupboard);

  Future<List<ChairModel>> searchForChair(String searchTitle);
  Future<List<TableModel>> searchForTable(String searchTitle);
  Future<List<SofaModel>> searchForSofa(String searchTitle);
  Future<List<CupboardModel>> searchForCupboard(String searchTitle);
}

class ProductsRemoteDataSource extends BaseRemoteDataSource {
  ProductsRemoteDataSource();

  @override
  Future<List<ChairModel>> getChair() async {
    try {
      await Dio().get(
        ApiConstants.topProducts,
      );
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.message);
      } else {
        print(e.message);
      }
    }

    final response = await Dio().get(
      ApiConstants.topProducts,
    );

    if (response.statusCode == 200) {
      return List<ChairModel>.from(
        (response.data['data']['chair'] as List).map(
          (x) => ChairModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  Future<List<TableModel>> getTable() async {
    final response = await Dio().get(
      ApiConstants.topProducts,
    );

    if (response.statusCode == 200) {
      return List<TableModel>.from(
        (response.data['data']['table'] as List).map(
          (x) => TableModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  Future<List<SofaModel>> getSofa() async {
    final response = await Dio().get(
      ApiConstants.topProducts,
    );

    if (response.statusCode == 200) {
      return List<SofaModel>.from(
        (response.data['data']['sofa'] as List).map(
          (x) => SofaModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  Future<List<CupboardModel>> getCupboard() async {
    final response = await Dio().get(
      ApiConstants.topProducts,
    );

    if (response.statusCode == 200) {
      return List<CupboardModel>.from(
        (response.data['data']['cupboard'] as List).map(
          (x) => CupboardModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }

  //-------------------------------------------------------

  @override
  Future<List<ChairModel>> getAllChairs() async {
    final response = await Dio().get(
      ApiConstants.allChairs,
    );

    if (response.statusCode == 200) {
      return List<ChairModel>.from(
        (response.data['data'] as List).map(
          (x) => ChairModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  Future<List<TableModel>> getAllTables() async {
    final response = await Dio().get(
      ApiConstants.allTables,
    );

    if (response.statusCode == 200) {
      return List<TableModel>.from(
        (response.data['data'] as List).map(
          (x) => TableModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  Future<List<SofaModel>> getAllSofas() async {
    final response = await Dio().get(
      ApiConstants.allSofas,
    );

    if (response.statusCode == 200) {
      return List<SofaModel>.from(
        (response.data['data'] as List).map(
          (x) => SofaModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  Future<List<CupboardModel>> getAllCupboards() async {
    final response = await Dio().get(
      ApiConstants.allCupboards,
    );

    if (response.statusCode == 200) {
      return List<CupboardModel>.from(
        (response.data['data'] as List).map(
          (x) => CupboardModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }

  // -------------------------------

  @override
  Future<List<ChairDetailsModel>> getChairDetails(int idChair) async {
    final response = await Dio().get(
      idChair == 1 ? ApiConstants.chairDetails1 : ApiConstants.chairDetails2,
    );

    if (response.statusCode == 200) {
      return List<ChairDetailsModel>.from(
        (response.data['data'] as List).map(
          (x) => ChairDetailsModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  Future<List<TableDetailsModel>> getTableDetails(int idTable) async {
    final response = await Dio().get(
      idTable == 1 ? ApiConstants.tableDetails1 : ApiConstants.tableDetails2,
    );

    if (response.statusCode == 200) {
      return List<TableDetailsModel>.from(
        (response.data['data'] as List).map(
          (x) => TableDetailsModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  Future<List<SofaDetailsModel>> getSofaDetails(int idSofa) async {
    final response = await Dio().get(
      idSofa == 1 ? ApiConstants.sofaDetails1 : ApiConstants.sofaDetails2,
    );

    if (response.statusCode == 200) {
      return List<SofaDetailsModel>.from(
        (response.data['data'] as List).map(
          (x) => SofaDetailsModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  Future<List<CupboardDetailsModel>> getCupboardDetails(int idCupboard) async {
    final response = await Dio().get(
      idCupboard == 1
          ? ApiConstants.cupboardDetails1
          : ApiConstants.cupboardDetails2,
    );

    if (response.statusCode == 200) {
      return List<CupboardDetailsModel>.from(
        (response.data['data'] as List).map(
          (x) => CupboardDetailsModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }

  // ------------------------------------------

  @override
  Future<List<ChairModel>> searchForChair(String searchTitle) async {
    final response = await Dio().get(ApiConstants.searchForChair);

    if (response.statusCode == 200) {
      return List<ChairModel>.from(
        (response.data['data'] as List).map(
          (x) => ChairModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  Future<List<TableModel>> searchForTable(String searchTitle) async {
    final response = await Dio().get(ApiConstants.searchForTable);

    if (response.statusCode == 200) {
      return List<TableModel>.from(
        (response.data['data'] as List).map(
          (x) => TableModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  Future<List<SofaModel>> searchForSofa(String searchTitle) async {
    final response = await Dio().get(ApiConstants.searchForSofa);

    if (response.statusCode == 200) {
      return List<SofaModel>.from(
        (response.data['data'] as List).map(
          (x) => SofaModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }

  @override
  Future<List<CupboardModel>> searchForCupboard(String searchTitle) async {
    final response = await Dio().get(ApiConstants.searchForCupboard);

    if (response.statusCode == 200) {
      return List<CupboardModel>.from(
        (response.data['data'] as List).map(
          (x) => CupboardModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }

  // --------------------------------------------------------

  @override
  Future<List<CartsModel>> getAllCarts() async {
    final response = await Dio().get(
      ApiConstants.allCarts,
    );

    if (response.statusCode == 200) {
      return List<CartsModel>.from(
        (response.data['data'] as List).map(
          (x) => CartsModel.fromJson(x),
        ),
      );
    } else {
      throw ErrorHandler.handle(DataSource.INTERNAL_SERVER_ERROR);
    }
  }
}
