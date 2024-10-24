// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sharlift/constants/global_variables.dart';
import 'package:sharlift/constants/http_error_handler.dart';
import 'package:sharlift/constants/toast_msg.dart';

import 'package:sharlift/models/product_model.dart';

import 'package:sharlift/provider/user_provider.dart';

class CartServices {
  Future<List<ProductModel>> fetchPending({
    required BuildContext context,
  }) async {
    var userprovider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse(
            '$uri/fetch-all-pending?email=${Uri.encodeComponent(userprovider.user.email.toString())}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              ProductModel.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      toastMsg(msg: 'You have no pending rides: $e', color_bg: Colors.yellow);
    }
    return productList;
  }

  Future<Map<String, dynamic>> fetchUserByEmail(String email) async {
    try {
      final response = await http.get(Uri.parse(
          '$uri/fetch-chosen?email=${Uri.encodeComponent(email.toString())}'));

      if (response.statusCode == 200) {
        return json.decode(
            response.body); // Returns a map with firstName, lastName, and phone
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow; // You can handle this exception further up if needed
    }
  }
}
