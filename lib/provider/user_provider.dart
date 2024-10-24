import 'package:flutter/material.dart';
import 'package:sharlift/features/auth/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
    id: "",
    email: "",
    profilePhoto: "",
    password: "",
    firstName: "",
    lastName: "",
    phone: "",
    vehicalName: "",
    vehicalNumber: "",
    type: "",
    token: "",
    noOfLiftsGiven: 0,
    ratingLiftsGiven: 0,
    noOfLiftsTaken: 0,
    ratingLiftsTaken: 0,
  );

  UserModel get user => _user;

  void setUser(String user) {
    _user = UserModel.fromJson(user);
    notifyListeners();
  }
}
