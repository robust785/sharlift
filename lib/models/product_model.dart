// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// // ignore_for_file: non_constant_identifier_names

// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';

class ProductModel {
  final String giverID;
  final String from;
  final String to;
  final int price;
  final String time_of_start;
  final String date_of_start;
  final String msg;
  final String pickUpPoint;
  final String status;
  final String chosenID;
  final String code;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String vehicalName;
  final String vehicalNumber;
  final String? id;
  final List<String> arr_req_id;

  var ratingLiftsGiven;

  var lifterCode;

  var profilePhoto;

  var passengerCode;

  var noOfLiftsGiven;

  var modeOfPayment;

  bool completeFromPassenger;

  bool completeFromLifter;

  ProductModel({
    required this.giverID,
    required this.from,
    required this.to,
    required this.price,
    required this.time_of_start,
    required this.date_of_start,
    required this.msg,
    required this.pickUpPoint,
    required this.status,
    required this.chosenID,
    required this.code,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.vehicalName,
    required this.vehicalNumber,
    this.id,
    required this.arr_req_id,
    required this.ratingLiftsGiven,
    required this.lifterCode,
    required this.profilePhoto,
    required this.passengerCode,
    required this.noOfLiftsGiven,
    required this.modeOfPayment,
    required this.completeFromPassenger,
    required this.completeFromLifter,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'giverID': giverID,
      'from': from,
      'to': to,
      'price': price,
      'time_of_start': time_of_start,
      'date_of_start': date_of_start,
      'msg': msg,
      'pickUpPoint': pickUpPoint,
      'status': status,
      'chosenID': chosenID,
      'code': code,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'vehicalName': vehicalName,
      'vehicalNumber': vehicalNumber,
      'id': id,
      'arr_req_id': arr_req_id,
      'modeOfPayment': modeOfPayment,
      'noOfLiftsGiven': noOfLiftsGiven,
      'passengerCode': passengerCode,
      'profilePhoto': profilePhoto,
      'lifterCode': lifterCode,
      'ratingLiftsGiven': ratingLiftsGiven,
      'completeFromPassenger': completeFromPassenger,
      'completeFromLifter': completeFromLifter,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      completeFromPassenger: map['completeFromPassenger'] as bool,
      completeFromLifter: map['completeFromLifter'] as bool,
      giverID: map['giverID'] as String? ?? '',
      profilePhoto: map['profilePhoto'] as String? ?? '',
      from: map['from'] as String? ?? '',
      to: map['to'] as String? ?? '',
      price: map['price'] as int,
      time_of_start: map['time_of_start'] as String? ?? '',
      date_of_start: map['date_of_start'] as String? ?? '',
      msg: map['msg'] as String? ?? '',
      pickUpPoint: map['pickUpPoint'] as String? ?? '',
      status: map['status'] as String? ?? '',
      chosenID: map['chosenID'] as String? ?? '',
      code: map['code'] as String? ?? '',
      firstName: map['firstName'] as String? ?? '',
      lastName: map['lastName'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      email: map['email'] as String? ?? '',
      vehicalName: map['vehicalName'] as String? ?? '',
      vehicalNumber: map['vehicalNumber'] as String? ?? '',
      lifterCode: map['lifterCode'] as String? ?? '',
      passengerCode: map['passengerCode'] as String? ?? '',
      noOfLiftsGiven: map['noOfLiftsGiven'] as int,
      modeOfPayment: map['modeOfPayment'] as String? ?? '',
      ratingLiftsGiven: map['ratingLiftsGiven'] as int,
      id: map['_id'] as String?,
      arr_req_id: List<String>.from(map['arr_req_id'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
