extension FuzzyMatcher on String {
  bool fuzzyMatch(String target, {int threshold = 3}) {
    final source = toLowerCase();
    final targetLower = target.toLowerCase();
    
    if (source.contains(targetLower)) return true;

    return _levenshteinDistance(source, targetLower) <= threshold;
  }

  int _levenshteinDistance(String s, String t) {
    int n = s.length;
    int m = t.length;

    List<List<int>> dp = List.generate(n + 1, (_) => List.filled(m + 1, 0));

    for (int i = 0; i <= n; i++) {
      dp[i][0] = i;
    }
    for (int j = 0; j <= m; j++) {
      dp[0][j] = j;
    }

    for (int i = 1; i <= n; i++) {
      for (int j = 1; j <= m; j++) {
        int cost = (s[i - 1] == t[j - 1]) ? 0 : 1;
        dp[i][j] = [
          dp[i - 1][j] + 1,
          dp[i][j - 1] + 1,
          dp[i - 1][j - 1] + cost
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    return dp[n][m];
  }
} 