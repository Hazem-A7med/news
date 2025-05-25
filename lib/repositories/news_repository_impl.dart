import '../models/article.dart';
import '../services/network_service.dart';
import '../config/api_config.dart';
import 'news_repository.dart';

/// Implementation of the NewsRepository interface that fetches news from NewsAPI
class NewsRepositoryImpl implements NewsRepository {
  final NetworkService _networkService;
  
  /// Creates a new instance of NewsRepositoryImpl
  /// 
  /// Parameters:
  /// - [networkService]: Optional NetworkService instance for dependency injection
  NewsRepositoryImpl({NetworkService? networkService})
      : _networkService = networkService ?? NetworkService();

  @override
  Future<List<Article>> getTopHeadlines({
    required String category,
    required String country,
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        '/top-headlines',
        queryParameters: {
          'apiKey': ApiConfig.apiKey,
          'category': category,
          'country': country,
          'page': page,
          'pageSize': pageSize,
        },
      );

      _validateResponse(response);
      return _parseArticles(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<Article>> searchArticles({
    required String query,
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        '/everything',
        queryParameters: {
          'apiKey': ApiConfig.apiKey,
          'q': query,
          'page': page,
          'pageSize': pageSize,
        },
      );

      _validateResponse(response);
      return _parseArticles(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Parses the API response into a list of Article objects
  List<Article> _parseArticles(Map<String, dynamic> response) {
    final articles = response['articles'] as List;
    return articles.map((article) => Article.fromJson(article)).toList();
  }

  /// Validates the API response and throws an exception if invalid
  void _validateResponse(Map<String, dynamic> response) {
    if (response['status'] != 'ok') {
      throw NewsException(response['message'] ?? 'Failed to fetch articles');
    }
  }

  /// Handles errors and converts them to NewsException
  Exception _handleError(dynamic error) {
    if (error is NewsException) {
      return error;
    }
    return NewsException(error.toString());
  }
}

/// Custom exception class for news-related errors
class NewsException implements Exception {
  final String message;

  NewsException(this.message);

  @override
  String toString() => message;
} 