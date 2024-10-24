import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class RequestModel {
  final String? id;
  final String from;
  final String to;
  final int price;
  final String time_of_start;
  final String date_of_start;
  final String pickUpPoint;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String profilePhoto;
  final int ratingLiftsTaken;
  final int noOfLiftsTaken;

  RequestModel({
    this.id,
    required this.from,
    required this.to,
    required this.price,
    required this.time_of_start,
    required this.date_of_start,
    required this.pickUpPoint,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.profilePhoto,
    required this.ratingLiftsTaken,
    required this.noOfLiftsTaken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'from': from,
      'to': to,
      'time_of_start': time_of_start,
      'date_of_start': date_of_start,
      'price': price,
      'pickUpPoint': pickUpPoint,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'profilePhoto': profilePhoto,
      'ratingLiftsTaken': ratingLiftsTaken,
      'noOfLiftsTaken': noOfLiftsTaken,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      id: map['id'] as String?,
      from: map['from'] as String? ?? '',
      to: map['to'] as String? ?? '',
      time_of_start: map['time_of_start'] as String? ?? '',
      date_of_start: map['date_of_start'] as String? ?? '',
      pickUpPoint: map['pickUpPoint'] as String? ?? '',
      firstName: map['firstName'] as String? ?? '',
      lastName: map['lastName'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      email: map['email'] as String? ?? '',
      profilePhoto: map['profilePhoto'] as String? ?? '',
      ratingLiftsTaken: map['ratingLiftsTaken'] as int,
      noOfLiftsTaken: map['noOfLiftsTaken'] as int,
      price: map['price'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestModel.fromJson(String source) =>
      RequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
