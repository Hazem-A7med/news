import 'package:flutter/material.dart';
import 'package:news_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/news_provider.dart';
import 'theme/app_theme.dart';
import 'core/di/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: MaterialApp(
        title: 'News App',
        theme: AppTheme.theme,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
} 