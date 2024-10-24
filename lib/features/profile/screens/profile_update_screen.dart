import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharlift/common/input.dart';
import 'package:sharlift/constants/toast_msg.dart';
import 'package:sharlift/constants/utils.dart';
import 'package:sharlift/features/auth/services/auth_services.dart';
import 'package:sharlift/features/profile/services/profile_services.dart';
import 'package:sharlift/provider/user_provider.dart';

class ProfileUpdate extends StatefulWidget {
  static const String routeName = "/profile-update";
  const ProfileUpdate({super.key});

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final TextEditingController firstnameController =
      TextEditingController(text: '');
  final TextEditingController lastnameController =
      TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController phoneController = TextEditingController(text: '');
  final TextEditingController vehicalnameController =
      TextEditingController(text: '');
  final TextEditingController numberplateController =
      TextEditingController(text: '');
  AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current user data
    final user = Provider.of<UserProvider>(context, listen: false).user;
    firstnameController.text = user.firstName.toString();
    lastnameController.text = user.lastName.toString();
    emailController.text = user.email.toString();
    phoneController.text = user.phone.toString();
    vehicalnameController.text = user.vehicalName.toString();
    numberplateController.text = user.vehicalNumber.toString();
  }

  @override
  void dispose() {
    super.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    vehicalnameController.dispose();
    numberplateController.dispose();
  }

  List<File> images = [];

  void selectImage() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void _updateProfile() {
    ProfileServices profileServices = ProfileServices();

    profileServices.profileUpdate(
      context: context,
      firstName: firstnameController.text,
      lastName: lastnameController.text,
      email: emailController.text,
      phone: phoneController.text,
      vehicalName: vehicalnameController.text,
      vehicalNumber: numberplateController.text,
      images: images,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.grey,
        elevation: 2,
        title: const Text(
          "Update Profile",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width - 30,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  images.isNotEmpty
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: ClipOval(
                                child: Image.file(
                                  images[0],
                                  fit: BoxFit.cover,
                                  height: 300,
                                  width: 300,
                                ),
                              ),
                            ),
                            TextButton(
                              child: const Text(
                                "Delete Image",
                                style:
                                    TextStyle(fontSize: 25, color: Colors.red),
                              ),
                              onPressed: () {
                                images = [];
                                setState(() {});
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      : GestureDetector(
                          onTap: selectImage,
                          child: DottedBorder(
                            color: Colors.grey,
                            strokeWidth: 2,
                            borderType: BorderType.RRect,
                            dashPattern: const [10, 3],
                            strokeCap: StrokeCap.round,
                            radius: const Radius.circular(20),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.folder_open,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Select Profile Photo",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                  const Text(
                    "General data ",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "    First Name ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Input(
                      hinttext: 'First Name', controller: firstnameController),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "    Last Name ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Input(hinttext: 'Last Name', controller: lastnameController),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "    Email ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Input(hinttext: 'Email', controller: emailController),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "    Phone ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    height: 50, //height of input field
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      enabled: true,
                      style: const TextStyle(
                        fontSize:
                            20.0, //size badhega isse jo text type hoga uska
                      ),
                      decoration: const InputDecoration(
                        prefixText: "+91  ",
                        filled: true,
                        hintText: "Phone",
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width - 30,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Lift Giver Data ",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "    Vehical Name ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Input(
                      hinttext: 'Vehical Name',
                      controller: vehicalnameController),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "    Vehical Number Plate ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Input(
                      hinttext: 'Ex- MH 15 AA 1004',
                      controller: numberplateController),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              height: 50,
              width: MediaQuery.of(context).size.width, //height of button
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.black),
                ),
                onPressed: () {
                  if (phoneController.text.length != 10) {
                    toastMsg(msg: "Invalid phone number");
                    return;
                  }
                  if (firstnameController.text == '' ||
                      lastnameController.text == '' ||
                      emailController.text == '' ||
                      phoneController.text == '') {
                    toastMsg(
                        msg:
                            "You must fill all the details in general data section");
                    return;
                  }
                  if ((vehicalnameController.text == '' &&
                          numberplateController.text.length > 1) ||
                      (vehicalnameController.text.length > 1 &&
                          numberplateController.text == '')) {
                    toastMsg(
                      msg:
                          "You must fill all the details in the Lift Giver section",
                      color_bg: Colors.red,
                    );
                    return;
                  }

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "Alert",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                          "Here by you declare that all the info provided by you is correct. \nCompany will not be responsible for any unfortunate incident.",
                          style: TextStyle(fontSize: 20),
                        ),
                        actions: [
                          TextButton(
                            child: const Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                _updateProfile();

                                setState(() {
                                  authServices.getUserData(context);
                                });
                                Navigator.of(context).pop();
                              }),
                        ],
                      );
                    },
                  );
                  authServices.getUserData(context);
                  setState(() {});
                },
                child: const Text(
                  "Update Profile",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
