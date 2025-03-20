import 'dart:async';
import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://127.0.0.1:8000", // Change this if needed
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  Future<Response?> getRequest(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      print("🌍 Sending GET request to: $endpoint with params: $queryParams");
      
      final response = await _dio.get(endpoint, queryParameters: queryParams);

      print("✅ Response received: ${response.statusCode}");
      print("📩 Response data: ${response.data}");
      
      return response;
    } on DioException catch (e) {
      print("🔥 DioException: ${e.response?.statusCode} - ${e.message}");
      return null;
    } catch (e) {
      print("🚨 Unexpected Error: $e");
      return null;
    }
  }
}
