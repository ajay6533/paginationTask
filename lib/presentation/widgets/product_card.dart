import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../models/user_list_model.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        elevation: 5,
        surfaceTintColor: primaryColor,
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        width: double.maxFinite,
                        height: 130.0,
                        fit: BoxFit.scaleDown,
                        imageUrl: user.avatar!,
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
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user.firstName!} ${user.lastName!}",
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            user.email ?? "",
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
