import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/presentation/notification/dbHelper.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/network/network_info.dart';
import '../../../domain/model/models.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this._dbHelper, this._networkInfo) : super(NotificationInitial());

  final DbHelper _dbHelper;

  static NotificationCubit get(context) => BlocProvider.of(context);

  var notificationsList = [];

  final NetworkInfo _networkInfo;

  Future<void> checkInternet() async {
    if (!await _networkInfo.isConnected) {
      emit(NotificationNoInternetState());
    }
  }

  Future<int> sendNotification(NotificationModel notification) async {
    try {
      Database? db = await _dbHelper.createDatabase();
      emit(NotificationSentSucceededState());
      return db!.insert('notifications', notification.toMap());
    } catch (e) {
      emit(NotificationErrorState());
    }
    return 0;
  }

  Future<List> allNotifications() async {
    Database? db = await _dbHelper.createDatabase();
    return db!.query('notifications');
  }

  Future<int> delete(int id) async {
    try {
      Database? db = await _dbHelper.createDatabase();
      emit(NotificationDeletedSucceededState());
      return db!.delete('notifications', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      emit(NotificationDeletingErrorState());
    }
    return 0;
  }

  Future<void> showAllNotifications() async {
    try {
      emit(NotificationLoadingState());
      await allNotifications().then((notifications) {
        notificationsList = notifications;
      });
      emit(NotificationShowSucceededState());
    } catch (e) {
      emit(NotificationShowingErrorState());
    }
  }
}
