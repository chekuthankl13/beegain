import 'package:beegain/presentation/splash/splash_screen.dart';
import 'package:beegain/repository/api_repository.dart';
import 'package:beegain/utils/utills.dart';
import 'package:flutter/material.dart';

import 'logic/bloc_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// bloc observe state change
  Bloc.observer = MyBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => ApiRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthCubit(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                EnquiryCubit(apiRepository: context.read<ApiRepository>()),
          ),
        ],
        child: MaterialApp(
          title: 'Job',
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            primaryColor: Colors.black,
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
