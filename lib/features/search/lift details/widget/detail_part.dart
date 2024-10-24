// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class DetailPart extends StatelessWidget {
  final param;
  final title;
  const DetailPart({
    super.key,
    required this.title,
    required this.param,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title - ",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          Expanded(
            child: Text(
              maxLines: 3,
              overflow: TextOverflow.fade,
              title == "Price" ? 'Rs.${param}' : '${param}',
              style: const TextStyle(fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }
}
