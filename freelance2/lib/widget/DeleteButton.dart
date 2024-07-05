// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../service/Functions.dart';
import '../style/color.dart';

Widget DeleteButton(QueryDocumentSnapshot doc, context, String referans) {
  return IconButton(
    icon: const Icon(Icons.favorite),
    color: Colors.deepOrange,
    onPressed: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Appcolor2,
              title: const Text(
                "Silmek İstiyor Musunuz?",
                style: TextStyle(color: Colors.white,fontSize: 18),
              ),

              actions: [
                ElevatedButton(
                    style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    onPressed: () {
                      deleteData(doc.id, referans);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Silindi")));
                      Navigator.pop(context);
                    },
                    child: const Text("Evet",style: TextStyle(color: Colors.white),)),
                ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Hayır",style: TextStyle(color: Colors.white),)),
              ],
            );
          });
    },
  );
}