// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sharlift/constants/global_variables.dart';
import 'package:sharlift/constants/http_error_handler.dart';
import 'package:sharlift/constants/toast_msg.dart';
import 'package:sharlift/features/auth/models/user_model.dart';
import 'package:sharlift/features/auth/services/auth_services.dart';
import 'package:sharlift/provider/user_provider.dart';

class ProfileServices {
  final authservice = AuthServices();
  void profileUpdate({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String vehicalName,
    required String vehicalNumber,
    required List<File> images,
    String? password,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String currentUserpass = userProvider.user.password;

    try {
//cloudname,upload_preset
      final cloudinary = CloudinaryPublic("dvgjttbuc", "sbak9sec");
      List<String> imageURLs = [];
      if (images.isNotEmpty) {
        for (int i = 0; i < images.length; i++) {
          CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(
              images[i].path,
              folder: email,
            ),
          );
          imageURLs.add(res.secureUrl);
        }
      }

      UserModel user = UserModel(
        id: userProvider.user.id,
        firstName:
            firstName.isNotEmpty ? firstName : userProvider.user.firstName,
        lastName: lastName.isNotEmpty ? lastName : userProvider.user.lastName,
        email: email.isNotEmpty ? email : userProvider.user.email,
        phone: phone.isNotEmpty ? phone : userProvider.user.phone,
        vehicalName: vehicalName.isNotEmpty
            ? vehicalName
            : userProvider.user.vehicalName,
        vehicalNumber: vehicalNumber.isNotEmpty
            ? vehicalNumber
            : userProvider.user.vehicalNumber,
        profilePhoto:
            imageURLs.isEmpty ? userProvider.user.profilePhoto : imageURLs[0],
        password: currentUserpass,
        type: userProvider.user.type,
        token: userProvider.user.token,
        noOfLiftsGiven: userProvider.user.noOfLiftsGiven,
        ratingLiftsGiven: userProvider.user.ratingLiftsGiven,
        noOfLiftsTaken: userProvider.user.noOfLiftsTaken,
        ratingLiftsTaken: userProvider.user.ratingLiftsTaken,
      );

      // Sending data to DB
      http.Response res = await http.post(
        Uri.parse('$uri/api/profileUpdate'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        context: context,
        response: res,
        onSuccess: () {
          toastMsg(msg: "Profile updated successfully", color_bg: Colors.green);
          // Update the provider with the new user data
          authservice.getUserData(context);
          userProvider.setUser(res.body);
        },
      );
    } catch (e) {
      toastMsg(msg: '$e from profile services', color_bg: Colors.red);
    }
  }
}
