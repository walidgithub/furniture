import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:furniture/domain/usecases/chair_usecase/get_chair_details_usecase.dart';
import 'package:furniture/domain/usecases/chair_usecase/search_for_chairs_usecase.dart';
import 'package:furniture/presentation/notification/dbHelper.dart';
import 'package:furniture/presentation/product_details/bloc/chair_details_bloc.dart';
import 'package:furniture/presentation/resources/theme_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasource/products_local_datasource.dart';
import '../../data/datasource/products_remote_datasource.dart';
import '../../data/repository/products_repository.dart';
import '../../domain/repository/repository.dart';
import '../../domain/usecases/cupboard_usecase/get_all_cupboards_usecase.dart';
import '../../domain/usecases/cupboard_usecase/get_cupboard_details_usecase.dart';
import '../../domain/usecases/cupboard_usecase/get_top_cupboard_usecase.dart';
import '../../domain/usecases/cupboard_usecase/search_for_cupboards_usecase.dart';
import '../../domain/usecases/get_all_carts_usecase.dart';
import '../../domain/usecases/chair_usecase/get_all_chairs_usecase.dart';
import '../../domain/usecases/chair_usecase/get_top_chair_usecase.dart';
import '../../domain/usecases/sofa_usecase/get_all_sofas_usecase.dart';
import '../../domain/usecases/sofa_usecase/get_sofa_details_usecase.dart';
import '../../domain/usecases/sofa_usecase/get_top_sofa_usecase.dart';
import '../../domain/usecases/sofa_usecase/search_for_sofas_usecase.dart';
import '../../domain/usecases/table_usecase/get_all_tables_usecase.dart';
import '../../domain/usecases/table_usecase/get_table_details_usecase.dart';
import '../../domain/usecases/table_usecase/get_top_table_usecase.dart';
import '../../domain/usecases/table_usecase/search_for_tables_usecase.dart';
import '../../presentation/authentication/authCubit/auth_cubit.dart';
import '../../presentation/cart/bloc/cart_bloc.dart';
import '../../presentation/cubit/interact_cubit.dart';
import '../../presentation/home_page/chair_bloc/chair_bloc.dart';
import '../../presentation/home_page/cupboard_bloc/cupboard_bloc.dart';
import '../../presentation/home_page/sofa_bloc/sofa_bloc.dart';
import '../../presentation/home_page/table_bloc/table_bloc.dart';
import '../../presentation/notification/cubit/notification_cubit.dart';
import '../app_prefs.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    // Shared prefs instance
    final sharedPrefs = await SharedPreferences.getInstance();

    sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

    // dbHelper
    sl.registerLazySingleton<DbHelper>(() => DbHelper());

    // app prefs instance
    sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sl()));

    // theme
    sl.registerLazySingleton<ThemeManager>(() => ThemeManager());

    // Bloc
    sl.registerFactory(() => ChairBloc(sl(), sl(), sl()));
    sl.registerFactory(() => CupboardBloc(sl(), sl(), sl()));
    sl.registerFactory(() => SofaBloc(sl(), sl(), sl()));
    sl.registerFactory(() => TableBloc(sl(), sl(), sl()));

    sl.registerFactory(() => CartBloc(sl()));

    sl.registerFactory(() => ChairDetailsBloc(sl()));

    //Cubit
    sl.registerFactory(() => InterActCubit(sl()));
    sl.registerFactory(() => AuthCubit(sl()));
    sl.registerFactory(() => NotificationCubit(sl(),sl()));

    // UseCase
    sl.registerLazySingleton<GetTopChairUseCase>(
        () => GetTopChairUseCase(sl()));
    sl.registerLazySingleton<GetAllChairsUseCase>(
        () => GetAllChairsUseCase(sl()));
    sl.registerLazySingleton<GetChairDetailsUseCase>(
        () => GetChairDetailsUseCase(sl()));
    sl.registerLazySingleton<SearchForChairsUseCase>(
        () => SearchForChairsUseCase(sl()));

    sl.registerLazySingleton<GetTopCupboardUseCase>(
            () => GetTopCupboardUseCase(sl()));
    sl.registerLazySingleton<GetAllCupboardsUseCase>(
            () => GetAllCupboardsUseCase(sl()));
    sl.registerLazySingleton<GetCupboardDetailsUseCase>(
            () => GetCupboardDetailsUseCase(sl()));
    sl.registerLazySingleton<SearchForCupboardsUseCase>(
            () => SearchForCupboardsUseCase(sl()));

    sl.registerLazySingleton<GetTopSofaUseCase>(
            () => GetTopSofaUseCase(sl()));
    sl.registerLazySingleton<GetAllSofasUseCase>(
            () => GetAllSofasUseCase(sl()));
    sl.registerLazySingleton<GetSofaDetailsUseCase>(
            () => GetSofaDetailsUseCase(sl()));
    sl.registerLazySingleton<SearchForSofasUseCase>(
            () => SearchForSofasUseCase(sl()));

    sl.registerLazySingleton<GetTopTableUseCase>(
            () => GetTopTableUseCase(sl()));
    sl.registerLazySingleton<GetAllTablesUseCase>(
            () => GetAllTablesUseCase(sl()));
    sl.registerLazySingleton<GetTableDetailsUseCase>(
            () => GetTableDetailsUseCase(sl()));
    sl.registerLazySingleton<SearchForTablesUseCase>(
            () => SearchForTablesUseCase(sl()));



    sl.registerLazySingleton<GetAllCartsUseCase>(
        () => GetAllCartsUseCase(sl()));

    // Repository
    sl.registerLazySingleton<BaseRepository>(
        () => ProductsRepository(sl(), sl(), sl()));

    // Remote DataSource
    sl.registerLazySingleton<BaseRemoteDataSource>(
        () => ProductsRemoteDataSource());

    // Local DataSource
    sl.registerLazySingleton<BaseLocalDataSource>(
        () => ProductsLocalDataSource(sl()));

    // Network Info
    sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(InternetConnectionChecker()));
  }
}
