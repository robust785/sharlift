import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sharlift/constants/global_variables.dart';
import 'package:sharlift/constants/http_error_handler.dart';
import 'package:sharlift/constants/toast_msg.dart';
// import 'package:sharlift/models/product_model.dart';

class SendRequest {
  Future<void> requestLift({
    required BuildContext context,
    required String requestEmail,
    required String liftID,
  }) async {
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/send-request'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'requestEmail': requestEmail, 'liftID': liftID}),
      );

      httpErrorHandle(
          response: res,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () {
            toastMsg(
                msg: "Your request has been successfully sent.",
                color_bg: Colors.green);
          });
    } catch (e) {
      toastMsg(msg: e.toString());
    }
  }
}
