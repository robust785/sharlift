// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sharlift/constants/global_variables.dart';
import 'package:sharlift/constants/http_error_handler.dart';
import 'package:sharlift/constants/toast_msg.dart';
import 'package:sharlift/models/request_model.dart';
import 'package:sharlift/provider/user_provider.dart';

class RequestServices {
  Future<List<RequestModel>> fetchRequests({
    required BuildContext context,
  }) async {
    var userprovider = Provider.of<UserProvider>(context, listen: false);
    List<RequestModel> requestList = [];
    try {
      http.Response res = await http.get(
        Uri.parse(
            '$uri/fetch-all-request?email=${Uri.encodeComponent(userprovider.user.email.toString())}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            requestList.add(
              RequestModel.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      toastMsg(msg: 'You have no live requests: $e', color_bg: Colors.yellow);
    }
    return requestList;
  }

  Future<void> declineRequest({
    required BuildContext context,
    required String declinedEmail,
    required String liftID,
  }) async {
    try {
      http.Response res = await http.put(
        Uri.parse(
            '$uri/decline-request?declinedEmail=${Uri.encodeComponent(declinedEmail.toString())}&liftID=${Uri.encodeComponent(liftID.toString())}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            toastMsg(msg: "Request Declined ", color_bg: Colors.green);
          });
    } catch (e) {
      toastMsg(msg: e.toString());
    }
  }

  Future<void> acceptRequest({
    required BuildContext context,
    required String acceptedEmail,
    required String liftID,
  }) async {
    try {
      http.Response res = await http.put(
        Uri.parse(
            '$uri/accept-request?acceptedEmail=${Uri.encodeComponent(acceptedEmail.toString())}&liftID=${Uri.encodeComponent(liftID.toString())}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            toastMsg(
                msg: "Request Accepted. Visit Cart ", color_bg: Colors.green);
          });
    } catch (e) {
      toastMsg(msg: e.toString());
    }
  }
}
