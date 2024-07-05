import 'package:flutter/material.dart';

Widget buildImage(String imageurl, int index) => Container(
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(26),
      color: const Color.fromRGBO(255, 255, 255, 0.69),
      image: DecorationImage(
        image: AssetImage(imageurl),
        fit: BoxFit.fill,
        //colorFilter: ColorFilter.mode(
        //Colors.black.withOpacity(0.5), BlendMode.dstATop),
      )),
);