import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/presentation/pages/user_details_page.dart';

import '../../models/user_list_model.dart';
import '../blocs/users/users_bloc.dart';

class PaginationWidget<t> extends StatelessWidget {
  final Function() loadMore;
  final Widget initialError;
  final Widget initialLoading;
  final Widget initialEmpty;
  final Widget Function(t p) child;
  final Widget? onLoadMoreError;
  final Widget? onLoadMoreLoading;

  const PaginationWidget(
      {Key? key,
      required this.loadMore,
      required this.initialError,
      required this.initialLoading,
      required this.initialEmpty,
      this.onLoadMoreError,
      this.onLoadMoreLoading,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is UsersLoaded) {
          print("UsersLoaded");

          List<User>? users = state.users.data;
          print("${users?.length}usersLoaded");
          return NotificationListener<ScrollEndNotification>(
              onNotification: (scrollInfo) {
                scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent ? loadMore() : null;
                return true;
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: users?.length, itemBuilder: (context, index) =>
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  UserDetailsPage(userid: users?[index].id,)));
                            },
                              child: child(users?[index] as t))
                      )),
                  //if error occured while loading more
                  if (state.error != null) Expanded(child: onLoadMoreError ?? initialError),
                  if (state.loading != null) Center(child: SizedBox( height: 20, child: onLoadMoreLoading ?? initialLoading)),
                  SizedBox(height: 20,),
                ],
              ));
        }
        if (state is UsersInitialLoading) {
          return initialLoading;
        }
        if (state is UsersEmpty) {
          return initialEmpty;
        }
        if (state is UsersInitialError) {
          return initialError;
        }
        return const SizedBox.shrink();
      },
    );
  }
}
