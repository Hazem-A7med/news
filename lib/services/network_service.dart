import 'package:dio/dio.dart';
import '../config/api_config.dart';

/// A service class that handles all network operations using Dio
class NetworkService {
  final Dio _dio;

  /// Creates a new instance of NetworkService with configured Dio client
  NetworkService() : _dio = Dio() {
    _dio.options.baseUrl = ApiConfig.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  /// Performs a GET request to the specified endpoint
  /// 
  /// Parameters:
  /// - [path]: The endpoint path
  /// - [queryParameters]: Optional query parameters
  /// - [options]: Optional Dio request options
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  /// Handles DioException and converts it to a user-friendly error message
  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timed out');
      case DioExceptionType.badResponse:
        return Exception(_getErrorMessage(error.response?.statusCode));
      case DioExceptionType.connectionError:
        return Exception('No internet connection');
      default:
        return Exception('Something went wrong');
    }
  }

  /// Converts HTTP status codes to user-friendly error messages
  String _getErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Something went wrong';
    }
  }
} 