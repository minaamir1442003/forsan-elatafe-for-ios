import 'package:dio/dio.dart';
import '../models/request_model.dart';

class RequestService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://forsan-el-t3afy-backend.vercel.app",
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {'Content-Type': 'application/json'},
  ));

  Future<Map<String, dynamic>> createRequest(RequestModel request) async {
    try {
      final response = await _dio.post(
        "/api/request/create",
        data: request.toJson(),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        return {
          'success': false,
          'message': 'فشل في إرسال الطلب: ${response.statusCode}'
        };
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        return e.response!.data;
      }
      return {
        'success': false,
        'message': 'خطأ في الاتصال: ${e.message}'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'حدث خطأ غير متوقع: ${e.toString()}'
      };
    }
  }

  Future<Map<String, dynamic>> getRequestStatus(String nationalId) async {
    try {
      final response = await _dio.get(
        "/api/request/status/$nationalId",
      );
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return {
          'success': false,
          'message': 'فشل في جلب حالة الطلب: ${response.statusCode}'
        };
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        return e.response!.data;
      }
      return {
        'success': false,
        'message': 'خطأ في الاتصال: ${e.message}'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'حدث خطأ غير متوقع: ${e.toString()}'
      };
    }
  }
}