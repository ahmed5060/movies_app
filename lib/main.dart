import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/service/service_locator.dart';
import 'package:movie/core/utils/config_size.dart';
import 'package:movie/features/home/presentation/home_screen.dart';
import 'package:movie/features/home/presentation/manager/movie_manager/movie_bloc.dart';
import 'package:movie/features/home/presentation/manager/movie_manager/movie_event.dart';
import 'package:movie/features/home/presentation/manager/search_manager/search_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ServerLocator().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ConfigSize().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<MovieBloc>()..add(const GetMoviesEvent(page: "1")),
        ),
        BlocProvider(
          create: (context) => getIt<SearchBloc>(),
        ),
      ],
      child: const MaterialApp(
        title: 'Movies App',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
