import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:task/models/user_details_model.dart';


import '../models/error_model.dart';
import '../models/user_list_model.dart';

class UserRepo {
  static Future<Either<Failure, UserListModel>> getUsers(
      {required num page}) async {
    try {
      var uri = Uri.parse(
              "https://reqres.in/api/users?page=$page");
      final response =
          await http.get(uri, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        UserListModel products = UserListModel.fromJson(json);
        return Right(products);
      } else {
        return const Left(Failure(message: 'Failed to parse json response'));
      }
    } catch (e) {
      return const Left(Failure(message: 'Something went wrong'));
    }
  }

  static Future<Either<Failure, UserDetailsModel>> getUserDetails(
      {required num userId}) async {
    try {
      var uri = Uri.parse(
          "https://reqres.in/api/users/$userId");
      final response =
      await http.get(uri, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        UserDetailsModel products = UserDetailsModel.fromJson(json);
        return Right(products);
      } else {
        return const Left(Failure(message: 'Failed to parse json response'));
      }
    } catch (e) {
      return const Left(Failure(message: 'Something went wrong'));
    }
  }
}
