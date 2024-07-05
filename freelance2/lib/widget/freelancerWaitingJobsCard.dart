

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/widget/EndButton.dart';

import '../style/color.dart';


Widget FreelancerWaitingJobsCard(Function()? ontap, QueryDocumentSnapshot doc, context) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      padding: const EdgeInsets.all(14),
      child: Wrap(runSpacing: 15, children: [
        Container(
          decoration: BoxDecoration(
              color: Appcolor2, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: ListTile(
                subtitle: Text(  doc.data().toString().contains("fiyat")
                    ? doc.get("fiyat") + " ₺"
                    : "",style: TextStyle(fontSize: 17,color: Colors.orange),),
                title: Text(
                    doc.data().toString().contains("başlık")
                        ? doc.get("başlık")
                        : "",

                    style: const TextStyle(fontSize: 20, color: TextColor)),
       ),
          ),
        ),
      ]),
    ),
  );
}
