import 'package:flutter/material.dart';

import '../style/color.dart';

Widget Mytextfield(
    TextEditingController controller, String title, Icon icon, bool open) {
  return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: EnabledColor)),
      child: TextField(
          obscureText: open,
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              icon: icon,
              iconColor: Colors.white,
              border: InputBorder.none,
              hintText: title,
              hintStyle: const TextStyle(color: Colors.grey)),
          ),
      );
}