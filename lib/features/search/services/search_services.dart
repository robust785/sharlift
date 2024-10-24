// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
import 'package:sharlift/constants/global_variables.dart';
import 'package:sharlift/constants/http_error_handler.dart';
import 'package:sharlift/constants/toast_msg.dart';
import 'package:sharlift/models/product_model.dart';
// import 'package:sharlift/provider/user_provider.dart';

class SearchServices {
  Future<List<ProductModel>> fetchSearchedProduct({
    required BuildContext context,
    required String from,
    required String to,
  }) async {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse(
            '$uri/user/search?from=${Uri.encodeComponent(from)}&to=${Uri.encodeComponent(to)}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // 'x-auth-token': userProvider.user.token,
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
      toastMsg(msg: '$e from search sevices');
    }
    return productList;
  }
}