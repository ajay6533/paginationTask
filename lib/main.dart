import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/presentation/blocs/user_details/user_details_bloc.dart';
import 'package:task/presentation/blocs/users/users_bloc.dart';
import 'package:task/presentation/pages/users_page.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UsersBloc()),
          BlocProvider(create: (context) => UserDetailsBloc())
        ],
        child: MaterialApp(
          title: 'Pagination Example with Flutter',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          home: const UsersPage(),
        ));
  }
}


