import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:yagnik_task/helper/color_helper.dart';
import 'package:yagnik_task/repositories/user_repository.dart';
import 'package:yagnik_task/screens/home_screen.dart';
import 'package:yagnik_task/services/api_service.dart';
import 'package:yagnik_task/user_bloc/user_bloc.dart';
import 'package:yagnik_task/user_bloc/user_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final http.Client client = http.Client();
  late final ApiService apiService =
      ApiService(client); 
  late final UserRepository userRepository = UserRepository(
    client,
    apiService: apiService,
  ); 

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) =>
              UserBloc(userRepository, repository: userRepository)
                ..add(FetchUsers(page: 1)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            surfaceTintColor: AppColor.transparent,
          ),
        ),
        title: 'Yagnik Task',
        home: HomeScreen(),
      ),
    );
  }
}
