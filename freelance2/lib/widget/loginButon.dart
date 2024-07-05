import 'package:flutter/material.dart';

import '../style/color.dart';

Widget LoginButton(String title, Function()? ontap) {
  return SizedBox(
      width: 300,
      height: 60,
      child: ElevatedButton(
          onPressed: ontap,
          style: ElevatedButton.styleFrom(
            side: const BorderSide(
                width: 2, // the thickness
                color: EnabledColor // the color of the border
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
            shape: const StadiumBorder(),
            backgroundColor: Appcolor2,
          ),
          child: Text(
            title,
            style: const TextStyle(color: EnabledColor, fontSize: 20),
          ),
          ),
      );
}