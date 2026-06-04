import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/dio_helper.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getAllData(String token) async {
    emit(HomeLoading());

    try {
      final profileRes = await DioHelper.getData(
        url: "/api/family/me",
        token: token,
      );

      final recordsRes = await DioHelper.getData(
        url: "/api/family/records",
        token: token,
      );

      emit(HomeSuccess(
        profile: Map<String, dynamic>.from(profileRes.data["data"]),
        records: List<dynamic>.from(recordsRes.data["records"]),
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  // 👇 أضف دالة logout
  Future<bool> logout(String token) async {
    try {
      await DioHelper.logout(token: token);
      return true;
    } catch (e) {
      return false;
    }
  }
}