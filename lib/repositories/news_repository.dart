import '../models/article.dart';

abstract class NewsRepository {
  Future<List<Article>> getTopHeadlines({
    required String category,
    required String country,
    required int page,
    required int pageSize,
  });

  Future<List<Article>> searchArticles({
    required String query,
    required int page,
    required int pageSize,
  });
} 