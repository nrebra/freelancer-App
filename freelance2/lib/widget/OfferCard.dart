/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:freelance2/service/Functions.dart';

import '../style/color.dart';

Widget OfferCard(Function()? ontap, QueryDocumentSnapshot doc, context, User user) {
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
            child: Slidable(
              endActionPane: ActionPane(motion: StretchMotion(), children: [
                SlidableAction(
                    icon: Icons.check,
                    backgroundColor: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                    onPressed: (context) async {
                      String jobId = doc["job_id"];
                      String freelancerId = doc["freelancer_id"];
                      print("Job ID: $jobId, Freelancer ID: $freelancerId");
                      await updateJobStatus(jobId, freelancerId);
                      deleteData(doc.id, "teklif");
                    }),
                SlidableAction(
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    onPressed: (context) {
                      deleteData(doc.id, "teklif");
                    }),
              ]),
              child: ListTile(
                  subtitle: Row(
                    children: [
                      Text(
                        doc.data().toString().contains("fiyat")
                            ? doc.get("fiyat") + " ₺"
                            : "",
                        style: TextStyle(fontSize: 17, color: Colors.orange),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(
                          doc.data().toString().contains("teklif")
                              ? "Teklif: " + doc.get("teklif") + " ₺"
                              : "",
                          style: TextStyle(fontSize: 17, color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                  title: Text(
                    doc.data().toString().contains("başlık")
                        ? doc.get("başlık")
                        : "",
                    style: const TextStyle(fontSize: 20, color: TextColor),
                  )),
            ),
          ),
        ),
      ]),
    ),
  );
}
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../style/color.dart';
import 'package:freelance2/service/Functions.dart';

Widget OfferCard(Function()? ontap, QueryDocumentSnapshot doc, BuildContext context, User user) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      padding: const EdgeInsets.all(14),
      child: Wrap(runSpacing: 15, children: [
        Container(
          decoration: BoxDecoration(
            color: Appcolor2,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Slidable(
              endActionPane: ActionPane(
                motion: StretchMotion(),
                children: [
                  SlidableAction(
                    icon: Icons.check,
                    backgroundColor: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                    onPressed: (context) async {
                      String jobId = doc["job_id"];
                      String freelancerId = doc["freelancer_id"];
                      await acceptOfferStatus(jobId, freelancerId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Teklif kabul edildi ve kaldırıldı.')),
                      );
                    },
                  ),
                  SlidableAction(
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    onPressed: (context) async {
                      String jobId = doc["job_id"];
                      String freelancerId = doc["freelancer_id"];
                      await refuseJobsRequest(doc.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Teklif reddedildi ve kaldırıldı.')),
                      );
                    },
                  ),
                ],
              ),
              child: ListTile(
                subtitle: Row(
                  children: [
                    Text(
                      doc.data().toString().contains("fiyat") ? doc.get("fiyat") + " ₺" : "",
                      style: TextStyle(fontSize: 17, color: Colors.orange),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        doc.data().toString().contains("teklif") ? "Teklif: " + doc.get("teklif") + " ₺" : "",
                        style: TextStyle(fontSize: 17, color: Colors.orange),
                      ),
                    ),
                  ],
                ),
                title: Text(
                  doc.data().toString().contains("başlık") ? doc.get("başlık") : "",
                  style: const TextStyle(fontSize: 20, color: TextColor),
                ),
              ),
            ),
          ),
        ),
      ]),
    ),
  );
}

