
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../service/Functions.dart';
import '../style/color.dart';


Widget EmployerCard(Function()? ontap, QueryDocumentSnapshot doc, context) {
  return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: ontap,
        child: Center(
          child: Container(
            height: 200,
            width: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xff282C34),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(doc["başlık"],
                        style:
                        const TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(doc["yetenekler"],
                        style: const TextStyle(fontSize: 18, color: Colors.grey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: Row(children: [
                            Text(
                              doc["fiyat"],
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.white),
                            ),
                            const Text(
                              "₺",
                              style: TextStyle(fontSize: 23, color: EnabledColor),
                            ),
                          ]),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ));
}