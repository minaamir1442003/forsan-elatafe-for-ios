import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forsan_eltafe/core/network/dio_helper.dart';
import 'package:forsan_eltafe/features/Profile/models/login_response_model.dart';
import 'package:forsan_eltafe/features/auth/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({
    required String nationalId,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      final response = await DioHelper.postData(
        url: "/api/family/login",
        data: {
          "nationalId": nationalId,
          "password": password,
        },
      );

      final loginModel = LoginResponseModel.fromJson(response.data);

      if (loginModel.success && loginModel.token != null) {
        emit(LoginSuccess(
          token: loginModel.token!,
          patientName: loginModel.name ?? 'مريض',
        ));
      } else {
        // عرض رسالة الفشل من الـ API نفسها
        emit(LoginError(
          message: loginModel.message ?? 'فشل تسجيل الدخول. تحقق من البيانات.',
        ));
      }
    } on DioException catch (e) {
      String errorMessage = 'حدث خطأ في الاتصال بالخادم';

      // محاولة جلب رسالة الخطأ من الـ API أولاً
      if (e.response != null && e.response!.data != null) {
        try {
          // محاولة قراءة message من response
          if (e.response!.data is Map) {
            errorMessage = e.response!.data['message'] ?? 
                          e.response!.data['error'] ?? 
                          'حدث خطأ في الخادم';
          } else {
            errorMessage = e.response!.data.toString();
          }
        } catch (_) {
          // لو فشل في قراءة الرسالة، نستخدم رسائل الأكواد
          if (e.response!.statusCode == 401) {
            errorMessage = 'رقم الهوية أو كلمة المرور غير صحيحة';
          } else if (e.response!.statusCode == 404) {
            errorMessage = 'المريض غير موجود';
          } else if (e.response!.statusCode == 400) {
            errorMessage = 'بيانات غير صحيحة';
          } else {
            errorMessage = 'خطأ في الخادم: ${e.response!.statusCode}';
          }
        }
      } 
      // مشاكل الاتصال بالإنترنت
      else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'انتهى وقت الاتصال، تأكد من الإنترنت';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'لا يوجد اتصال بالإنترنت';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'انتهى وقت انتظار الرد من الخادم';
      } else if (e.type == DioExceptionType.sendTimeout) {
        errorMessage = 'انتهى وقت إرسال البيانات';
      }

      emit(LoginError(message: errorMessage));
    } catch (e) {
      emit(LoginError(message: 'حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }
}