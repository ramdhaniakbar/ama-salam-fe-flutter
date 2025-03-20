import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_flutter/src/screens/home/home_screen.dart';
import 'package:mobile_app_flutter/src/screens/user/cubit/user_flow/user_flow_bloc.dart';
import 'package:mobile_app_flutter/src/screens/user/cubit/user_flow/user_flow_event.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserFlowBloc>(
          create: (context) => UserFlowBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        HomePageScreen.route: (context) => const HomePageScreen(),
      },
    );
  }
}
