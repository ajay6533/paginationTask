import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/models/user_details_model.dart';
import 'package:task/presentation/blocs/user_details/user_details_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../colors.dart';


class UserDetailsPage extends StatefulWidget {
  final num? userid;
  const UserDetailsPage({Key? key, this.userid}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  void initState() {
    BlocProvider.of<UserDetailsBloc>(context).add(UsersDetailsLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Details",
            style: TextStyle(
              color: primaryColor,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: blocBody());
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => UserDetailsBloc(userID: widget.userid)..add(UsersDetailsLoadEvent()),
      child: BlocBuilder<UserDetailsBloc, UserDetailsState>(
        builder: (context, state) {
          if (state is UsersDetailsInitialLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UsersDetailsLoaded) {
            UserDetailsModel userDetails = state.user;
            return Padding(
              padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          width: double.maxFinite,
                          height: 200.0,
                          fit: BoxFit.scaleDown,
                          imageUrl: userDetails.data!.avatar!,
                          placeholder: (context, url) => const SizedBox(
                            width: 10,
                            height: 10,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/sinimagen.png',
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 60,
                    color: Colors.grey[800],
                  ),
                  Text(
                    'Name',
                    style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${userDetails.data!.firstName!} ${userDetails.data!.lastName!}",
                    style: TextStyle(
                        color: Colors.amberAccent[200],
                        letterSpacing: 2,
                        fontSize: 28,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'support',
                    style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userDetails.support?.text ?? "To keep ReqRes free, contributions towards server costs are appreciated!",
                    style: TextStyle(
                        color: Colors.amberAccent[200],
                        letterSpacing: 2,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        color: Colors.grey[400],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        userDetails.data!.email!,
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 18,
                            letterSpacing: 1
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          if (state is UsersDetailsInitialError) {
            return const Center(
              child: Text("Error"),
            );
          }

          return Container();
        },
      ),
    );
  }
}




