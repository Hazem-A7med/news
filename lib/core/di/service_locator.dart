import 'package:get_it/get_it.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {


  sl.registerFactory(
    () => NewsBloc(repository: sl()),
  );

} 