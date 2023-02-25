import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/error_handler.dart';
import '../models/chair_model.dart';
import '../models/cupboard_model.dart';
import '../models/sofa_model.dart';
import '../models/table_model.dart';

abstract class BaseLocalDataSource {
  Future<List<ChairModel>> getCashedTopChair();
  Future<List<TableModel>> getCashedTopTable();
  Future<List<SofaModel>> getCashedTopSofa();
  Future<List<CupboardModel>> getCashedTopCupboard();

  Future<void> casheTopChair(List<ChairModel> chairToCashe);
  Future<void> casheTopTable(List<TableModel> tableToCashe);
  Future<void> casheTopSofa(List<SofaModel> sofaToCashe);
  Future<void> casheTopCupboard(List<CupboardModel> cupboardToCashe);

  Future<List<ChairModel>> getCashedAllChair();
  Future<List<TableModel>> getCashedAllTable();
  Future<List<SofaModel>> getCashedAllSofa();
  Future<List<CupboardModel>> getCashedAllCupboard();

  Future<void> casheAllChair(List<ChairModel> chairToCashe);
  Future<void> casheAllTable(List<TableModel> tableToCashe);
  Future<void> casheAllSofa(List<SofaModel> sofaToCashe);
  Future<void> casheAllCupboard(List<CupboardModel> cupboardToCashe);
}

const CACHED_TOP_CHAIR = 'CACHED_TOP_CHAIR';
const CACHED_TOP_TABLE = 'CACHED_TOP_TABLE';
const CACHED_TOP_SOFA = 'CACHED_TOP_SOFA';
const CACHED_TOP_CUPBOARD = 'CACHED_TOP_CUPBOARD';

const CACHED_ALL_CHAIR = 'CACHED_ALL_CHAIR';
const CACHED_ALL_TABLE = 'CACHED_ALL_TABLE';
const CACHED_ALL_SOFA = 'CACHED_ALL_SOFA';
const CACHED_ALL_CUPBOARD = 'CACHED_ALL_CUPBOARD';

class ProductsLocalDataSource extends BaseLocalDataSource{

  final SharedPreferences sharedPreferences;

  ProductsLocalDataSource(this.sharedPreferences);

  @override
  Future<void> casheTopChair(List<ChairModel> chairToCashe) {
    return sharedPreferences.setString(
      CACHED_TOP_CHAIR,jsonEncode(chairToCashe),
    );
  }

  @override
  Future<List<ChairModel>> getCashedTopChair() async{
    final jsonString = sharedPreferences.getString(CACHED_TOP_CHAIR);
    if (jsonString != null){
      try{
        Iterable l = json.decode(jsonString);
        return List<ChairModel>.from(l.map((model)=> ChairModel.fromJson(model)));
      } catch (error) {
        return [];
      }
    }else{
      throw DataSource.CACHE_ERROR.getFailure();
    }
  }

  @override
  Future<void> casheAllChair(List<ChairModel> chairToCashe) {
    return sharedPreferences.setString(
      CACHED_ALL_CHAIR,jsonEncode(chairToCashe),
    );
  }

  @override
  Future<List<ChairModel>> getCashedAllChair() async{
    final jsonString = sharedPreferences.getString(CACHED_ALL_CHAIR);
    if (jsonString != null){
      try{
        Iterable l = json.decode(jsonString);
        return List<ChairModel>.from(l.map((model)=> ChairModel.fromJson(model)));
      } catch (error) {
        return [];
      }
    }else{
      throw DataSource.CACHE_ERROR.getFailure();
    }
  }

  // ------------------------------------------------

  @override
  Future<void> casheTopTable(List<TableModel> tableToCashe) {
    return sharedPreferences.setString(
      CACHED_TOP_TABLE,jsonEncode(tableToCashe),
    );
  }

  @override
  Future<List<TableModel>> getCashedTopTable() async{
    final jsonString = sharedPreferences.getString(CACHED_TOP_TABLE);
    if (jsonString != null){
      try{
        Iterable l = json.decode(jsonString);
        return List<TableModel>.from(l.map((model)=> TableModel.fromJson(model)));
      } catch (error) {
        return [];
      }
    }else{
      throw DataSource.CACHE_ERROR.getFailure();
    }
  }

  @override
  Future<void> casheAllTable(List<TableModel> tableToCashe) {
    return sharedPreferences.setString(
      CACHED_ALL_TABLE,jsonEncode(tableToCashe),
    );
  }

  @override
  Future<List<TableModel>> getCashedAllTable() async{
    final jsonString = sharedPreferences.getString(CACHED_ALL_TABLE);
    if (jsonString != null){
      try{
        Iterable l = json.decode(jsonString);
        return List<TableModel>.from(l.map((model)=> TableModel.fromJson(model)));
      } catch (error) {
        return [];
      }
    }else{
      throw DataSource.CACHE_ERROR.getFailure();
    }
  }

  // ------------------------------------------

  @override
  Future<void> casheTopSofa(List<SofaModel> sofaToCashe) {
    return sharedPreferences.setString(
      CACHED_TOP_SOFA,jsonEncode(sofaToCashe),
    );
  }

  @override
  Future<List<SofaModel>> getCashedTopSofa() async{
    final jsonString = sharedPreferences.getString(CACHED_TOP_SOFA);
    if (jsonString != null){
      try{
        Iterable l = json.decode(jsonString);
        return List<SofaModel>.from(l.map((model)=> SofaModel.fromJson(model)));
      } catch (error) {
        return [];
      }
    }else{
      throw DataSource.CACHE_ERROR.getFailure();
    }
  }

  @override
  Future<void> casheAllSofa(List<SofaModel> sofaToCashe) {
    return sharedPreferences.setString(
      CACHED_ALL_SOFA,jsonEncode(sofaToCashe),
    );
  }

  @override
  Future<List<SofaModel>> getCashedAllSofa() async{
    final jsonString = sharedPreferences.getString(CACHED_ALL_SOFA);
    if (jsonString != null){
      try{
        Iterable l = json.decode(jsonString);
        return List<SofaModel>.from(l.map((model)=> SofaModel.fromJson(model)));
      } catch (error) {
        return [];
      }
    }else{
      throw DataSource.CACHE_ERROR.getFailure();
    }
  }

  // ---------------------------------------------

  @override
  Future<void> casheTopCupboard(List<CupboardModel> cupboardToCashe) {
    return sharedPreferences.setString(
      CACHED_TOP_CUPBOARD,jsonEncode(cupboardToCashe),
    );
  }

  @override
  Future<List<CupboardModel>> getCashedTopCupboard() async{
    final jsonString = sharedPreferences.getString(CACHED_TOP_CUPBOARD);
    if (jsonString != null){
      try{
        Iterable l = json.decode(jsonString);
        return List<CupboardModel>.from(l.map((model)=> CupboardModel.fromJson(model)));
      } catch (error) {
        return [];
      }
    }else{
      throw DataSource.CACHE_ERROR.getFailure();
    }
  }

  @override
  Future<void> casheAllCupboard(List<CupboardModel> cupboardToCashe) {
    return sharedPreferences.setString(
      CACHED_ALL_CUPBOARD,jsonEncode(cupboardToCashe),
    );
  }

  @override
  Future<List<CupboardModel>> getCashedAllCupboard() async{
    final jsonString = sharedPreferences.getString(CACHED_ALL_CUPBOARD);
    if (jsonString != null){
      try{
        Iterable l = json.decode(jsonString);
        return List<CupboardModel>.from(l.map((model)=> CupboardModel.fromJson(model)));
      } catch (error) {
        return [];
      }
    }else{
      throw DataSource.CACHE_ERROR.getFailure();
    }
  }
}