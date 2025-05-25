import 'package:flutter/material.dart';
import '../models/article.dart';
import '../extensions/string_extensions.dart';
import '../repositories/news_repository.dart';
import '../repositories/news_repository_impl.dart';

class NewsProvider with ChangeNotifier {
  final NewsRepository _repository;
  
  // State variables
  final List<Article> _articles = [];
  final List<Article> _filteredArticles = [];
  String _error = '';
  String _selectedCategory = 'general';
  String _searchQuery = '';
  
  int _currentPage = 1;
  bool _hasMorePages = true;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  static const int _pageSize = 5;

  NewsProvider({NewsRepository? repository})
      : _repository = repository ?? NewsRepositoryImpl();

  List<Article> get articles => _searchQuery.isEmpty ? _articles : _filteredArticles;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String get error => _error;
  String get selectedCategory => _selectedCategory;
  bool get hasMorePages => _hasMorePages;

  Future<void> fetchArticles({String? searchQuery, bool loadMore = false}) async {
    if (!_shouldFetch(loadMore)) return;
    
    _setLoadingState(loadMore);

    try {
      final newArticles = await _fetchArticles(searchQuery);
      _updateArticles(newArticles, loadMore);
      _updatePaginationState(newArticles);
      
      if (_searchQuery.isNotEmpty) {
        _performLocalSearch(_searchQuery);
      }
      
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      _clearLoadingState();
    }
  }

  void setCategory(String category) {
    _selectedCategory = category;
    _searchQuery = '';
    fetchArticles();
  }

  void searchArticles(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredArticles.clear();
      notifyListeners();
      return;
    }
    _performLocalSearch(query);
  }

  Future<void> loadMoreArticles() async {
    if (!_hasMorePages || _isLoadingMore || _searchQuery.isNotEmpty) return;
    await fetchArticles(loadMore: true);
  }

  // Private helper methods
  bool _shouldFetch(bool loadMore) {
    if (!loadMore) return true;
    return _hasMorePages && !_isLoadingMore;
  }

  void _setLoadingState(bool loadMore) {
    if (!loadMore) {
      _currentPage = 1;
      _hasMorePages = true;
      _isLoading = true;
    } else {
      _isLoadingMore = true;
    }
    notifyListeners();
  }

  void _clearLoadingState() {
    _isLoading = false;
    _isLoadingMore = false;
    notifyListeners();
  }

  Future<List<Article>> _fetchArticles(String? searchQuery) async {
    if (searchQuery != null) {
      return _repository.searchArticles(
        query: searchQuery,
        page: _currentPage,
        pageSize: _pageSize,
      );
    } else {
      return _repository.getTopHeadlines(
        category: _selectedCategory,
        country: 'us',
        page: _currentPage,
        pageSize: _pageSize,
      );
    }
  }

  void _updateArticles(List<Article> newArticles, bool loadMore) {
    if (loadMore) {
      _articles.addAll(newArticles);
    } else {
      _articles.clear();
      _articles.addAll(newArticles);
    }
  }

  void _updatePaginationState(List<Article> newArticles) {
    _hasMorePages = newArticles.length >= _pageSize;
    if (_hasMorePages) _currentPage++;
  }

  void _performLocalSearch(String query) {
    _filteredArticles.clear();
    _filteredArticles.addAll(_articles.where((article) {
      return article.title.fuzzyMatch(query) ||
             article.description.fuzzyMatch(query) ||
             article.content.fuzzyMatch(query) ||
             article.author.fuzzyMatch(query);
    }));
    notifyListeners();
  }
} 