// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String id;
  final String firstName;
  final String email;
  final String password;

  final String lastName;
  final String phone;
  final String vehicalName;
  final String vehicalNumber;
  final String profilePhoto;

  final String type;
  final String token;

  final int noOfLiftsGiven;
  final int ratingLiftsGiven;
  final int noOfLiftsTaken;
  final int ratingLiftsTaken;

  UserModel({
    required this.id,
    required this.firstName,
    required this.email,
    required this.password,
    required this.lastName,
    required this.phone,
    required this.vehicalName,
    required this.vehicalNumber,
    required this.profilePhoto,
    required this.type,
    required this.token,
    required this.noOfLiftsGiven,
    required this.ratingLiftsGiven,
    required this.noOfLiftsTaken,
    required this.ratingLiftsTaken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'email': email,
      'password': password,
      'lastName': lastName,
      'phone': phone,
      'vehicalName': vehicalName,
      'vehicalNumber': vehicalNumber,
      'profilePhoto': profilePhoto,
      'type': type,
      'token': token,
      'noOfLiftsGiven': noOfLiftsGiven,
      'ratingLiftsGiven': ratingLiftsGiven,
      'noOfLiftsTaken': noOfLiftsTaken,
      'ratingLiftsTaken': ratingLiftsTaken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as String,
      firstName: map['firstName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      lastName: map['lastName'] as String,
      phone: map['phone'] as String,
      vehicalName: map['vehicalName'] as String,
      vehicalNumber: map['vehicalNumber'] as String,
      profilePhoto: map['profilePhoto'] as String,
      type: map['type'] as String,
      token: map['token'] as String,
      noOfLiftsGiven: map['noOfLiftsGiven'] as int,
      ratingLiftsGiven: map['ratingLiftsGiven'] as int,
      noOfLiftsTaken: map['noOfLiftsTaken'] as int,
      ratingLiftsTaken: map['ratingLiftsTaken'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
