// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sharlift/constants/global_variables.dart';
import 'package:sharlift/constants/http_error_handler.dart';
import 'package:sharlift/constants/toast_msg.dart';

class LiftServices {
  void addProduct({
    required BuildContext context,
    required String giverId,
    required String from,
    required String to,
    required String time_of_start,
    required String date_of_start,
    required String msg,
    required String pickUpPoint,
    required String status,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String vehicalName,
    required String vehicalNumber,
    required int ratingLiftsGiven,
    required int noOfLiftsGiven,
    required int price,
    required bool completeFromPassenger,
    required bool completeFromLifter,
  }) async {
    // const {giverID,from,to,time_of_start,date_of_start,msg,pickUpPoint,status,arr_req_id,chosenID,code,firstName,lastName,phone,email,vehicalName,vehicalNumber}=req.body;

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/user/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'giverID': giverId,
          'from': from,
          'to': to,
          'price': price,
          'time_of_start': time_of_start,
          'date_of_start': date_of_start,
          'msg': msg,
          'pickUpPoint': pickUpPoint,
          'status': status,
          'firstName': firstName,
          'lastName': lastName,
          'phone': phone,
          'email': email,
          'vehicalName': vehicalName,
          'vehicalNumber': vehicalNumber,
          'ratingLiftsGiven': ratingLiftsGiven,
          'noOfLiftsGiven': noOfLiftsGiven,
          'completeFromLifter': completeFromLifter,
          'completeFromPassenger': completeFromPassenger,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          toastMsg(msg: 'Lift Added Successfully!', color_bg: Colors.green);
          Navigator.pop(context);
        },
      );
    } catch (e) {
      toastMsg(msg: '$e from lift servises .dart ');
    }
  }
}
