import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forsan_eltafe/core/shared_preferences_helper.dart';
import 'package:forsan_eltafe/features/add%20acount/services/request_service.dart';
import '../models/request_model.dart';

part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  final RequestService _requestService = RequestService();
  
  // المتغيرات المحفوظة
  String? savedNationalId;

  RequestCubit() : super(RequestInitial()) {
    _loadSavedData();
  }

  // تحميل البيانات المحفوظة
  Future<void> _loadSavedData() async {
    savedNationalId = await SharedPreferencesHelper.getNationalId();
  }

  // إنشاء طلب جديد
  Future<void> createRequest(RequestModel request) async {
    emit(RequestLoading());
    
    try {
      final response = await _requestService.createRequest(request);
      
      if (response['success'] == true) {
        // حفظ الـ nationalId في SharedPreferences
        await SharedPreferencesHelper.saveNationalId(request.nationalId);
        await SharedPreferencesHelper.setHasSubmittedRequest(true);
        savedNationalId = request.nationalId;
        
        emit(RequestCreatedSuccess(
          message: response['message'],
          requestId: response['data']['_id'],
        ));
      } else {
        emit(RequestCreatedFailure(
          error: response['message'] ?? 'حدث خطأ ما',
        ));
      }
    } catch (e) {
      emit(RequestCreatedFailure(
        error: 'فشل في الاتصال بالخادم: ${e.toString()}',
      ));
    }
  }

  // الحصول على حالة الطلب
  Future<void> getRequestStatus(String nationalId) async {
    emit(RequestStatusLoading());
    
    try {
      final statusData = await _requestService.getRequestStatus(nationalId);
      
      if (statusData['success'] == true) {
        final statusModel = RequestStatusModel.fromJson(statusData['data']);
        
        // حفظ الحالة في SharedPreferences
        await SharedPreferencesHelper.saveRequestStatus(statusModel.status);
        savedNationalId = nationalId;
        
        // التحقق من حالة الطلب - دعم accepted و approved
        final statusLower = statusModel.status.toLowerCase();
        
        if (statusLower == 'rejected' || statusLower == 'declined') {
          emit(RequestStatusRejected(message: 'تم رفض طلبك', statusModel: statusModel));
        } else if (statusLower == 'approved' || statusLower == 'accepted') {
          emit(RequestStatusApproved(status: statusModel));
        } else if (statusLower == 'pending') {
          emit(RequestStatusPending(status: statusModel));
        } else {
          emit(RequestStatusSuccess(status: statusModel));
        }
      } else {
        emit(RequestStatusNotFound(
          message: statusData['message'] ?? 'لم يتم العثور على الطلب',
        ));
      }
    } catch (e) {
      emit(RequestStatusFailure(
        error: 'فشل في جلب حالة الطلب: ${e.toString()}',
      ));
    }
  }

  // التحقق من وجود طلب سابق والعودة للحالة المناسبة
  Future<void> checkForExistingRequest() async {
    final hasSubmitted = await SharedPreferencesHelper.getHasSubmittedRequest();
    final nationalId = await SharedPreferencesHelper.getNationalId();
    
    if (hasSubmitted && nationalId != null && nationalId.isNotEmpty) {
      savedNationalId = nationalId;
      await getRequestStatus(nationalId);
    } else {
      emit(RequestInitial());
    }
  }

  // إعادة تعيين الحالة والذهاب للنموذج (للمستخدم عندما يضغط زر إعادة التقديم)
  Future<void> resetAndGoToForm() async {
    await SharedPreferencesHelper.clearRequestData();
    savedNationalId = null;
    emit(RequestInitial());
  }

  // تحديث الحالة (للزر Refresh)
  Future<void> checkRequestStatus(String nationalId) async {
    await getRequestStatus(nationalId);
  }
}