// lib/network/dio_helper.dart
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://forsan-el-t3afy-backend.vercel.app",
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  // ==================== Authentication ====================
  
  static Future<Response> logout({
    required String token,
  }) async {
    dio.options.headers = {
      "Authorization": "Bearer $token",
    };
    return await dio.post("/api/family/logout");
  }

  // ==================== Generic Methods ====================

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    if (token != null && token.isNotEmpty) {
      dio.options.headers = {
        "Authorization": "Bearer $token",
      };
    } else {
      // إزالة التوكين لو مش موجود عشان ميسببش مشاكل
      dio.options.headers.remove("Authorization");
    }
    return await dio.post(url, data: data);
  }

  static Future<Response> getData({
    required String url,
    String? token,
  }) async {
    if (token != null && token.isNotEmpty) {
      dio.options.headers = {
        "Authorization": "Bearer $token",
      };
    } else {
      dio.options.headers.remove("Authorization");
    }
    return await dio.get(url);
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    if (token != null && token.isNotEmpty) {
      dio.options.headers = {
        "Authorization": "Bearer $token",
      };
    } else {
      dio.options.headers.remove("Authorization");
    }
    return await dio.put(url, data: data);
  }

  static Future<Response> deleteData({
    required String url,
    String? token,
  }) async {
    if (token != null && token.isNotEmpty) {
      dio.options.headers = {
        "Authorization": "Bearer $token",
      };
    } else {
      dio.options.headers.remove("Authorization");
    }
    return await dio.delete(url);
  }

  static Future<Response> patchData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    if (token != null && token.isNotEmpty) {
      dio.options.headers = {
        "Authorization": "Bearer $token",
      };
    } else {
      dio.options.headers.remove("Authorization");
    }
    return await dio.patch(url, data: data);
  }
}