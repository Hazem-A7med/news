import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/article_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/reconnect_widget.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  Timer? _debounce;
  final List<String> _categories = [
    'general',
    'business',
    'technology',
    'sports',
    'entertainment',
    'health',
    'science',
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<NewsProvider>().fetchArticles(),
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      context.read<NewsProvider>().loadMoreArticles();
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<NewsProvider>().searchArticles(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search news...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: _onSearchChanged,
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Consumer<NewsProvider>(
                        builder: (context, newsProvider, child) {
                          final isSelected =
                              newsProvider.selectedCategory == _categories[index];
                          return ChoiceChip(
                            label: Text(_categories[index].toUpperCase()),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                newsProvider.setCategory(_categories[index]);
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.isLoading) {
            return const LoadingWidget();
          }

          if (newsProvider.error.isNotEmpty) {
            return ReconnectWidget(
              onReconnect: () => newsProvider.fetchArticles(),
            );
          }

          if (newsProvider.articles.isEmpty) {
            return const Center(
              child: Text('No articles available'),
            );
          }

          return RefreshIndicator(
            onRefresh: () => newsProvider.fetchArticles(),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: newsProvider.articles.length + 1,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                if (index == newsProvider.articles.length) {
                  if (newsProvider.isLoadingMore) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: LoadingWidget(),
                    );
                  } else if (newsProvider.hasMorePages) {
                    return const SizedBox.shrink();
                  } else {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No more articles'),
                      ),
                    );
                  }
                }
                final article = newsProvider.articles[index];
                return ArticleCard(article: article);
              },
            ),
          );
        },
      ),
    );
  }
} 