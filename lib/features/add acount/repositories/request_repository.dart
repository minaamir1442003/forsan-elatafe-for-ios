// lib/repositories/request_repository.dart
import 'package:dio/dio.dart';
import 'package:forsan_eltafe/core/network/dio_helper.dart';
import '../models/request_model.dart';

class RequestRepository {
  
  // إرسال طلب جديد
  Future<Response> createRequest(RequestModel request) async {
    try {
      return await DioHelper.postData(
        url: "/api/request/create",
        data: request.toJson(),
        token: null,
      );
    } catch (e) {
      rethrow;
    }
  }

  // جلب حالة الطلب
  Future<Response> getRequestStatus(String nationalId) async {
    try {
      return await DioHelper.getData(
        url: "/api/request/status/$nationalId",
        token: null,
      );
    } catch (e) {
      rethrow;
    }
  }
}