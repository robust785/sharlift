import 'package:flutter/material.dart';

class InputNew extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;

  const InputNew({
    super.key,
    required this.hinttext,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      height: 50, //height of input field
      child: TextField(
        controller: controller,
        enabled: true,
        style: const TextStyle(
          fontSize: 20.0, //size badhega isse jo text type hoga uska
        ),
        decoration: InputDecoration(
          filled: true,
          hintText: hinttext,
          hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
          fillColor: Colors.white,
          border: const OutlineInputBorder(
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
    );
  }
}
