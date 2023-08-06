import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../colors.dart';
import '../../models/user_list_model.dart';
import '../blocs/users/users_bloc.dart';
import '../widgets/widgets.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    BlocProvider.of<UsersBloc>(context).add(UsersLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Followers",
            style: TextStyle(
              color: primaryColor,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: PaginationWidget<User>(
          loadMore: () {
            BlocProvider.of<UsersBloc>(context).add(UsersLoadEvent());
          },
          initialEmpty: const EmptyWidget(),
          initialLoading: const CircularProgressIndicator(),
          initialError: const CustomErrorWidget(),
          child: (User userModel) {
            return UserCard(user: userModel);
          },
        ));
  }
}
