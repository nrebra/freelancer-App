import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/service/Functions.dart';

import '../style/color.dart';

Widget EndButton(QueryDocumentSnapshot doc, context, String referans) {
  return IconButton(
    icon: const Icon(Icons.check_box),
    color: Colors.deepOrange,
    onPressed: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Appcolor2,
              title: const Text(
                "Bitirdiğine Emin misin?",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    updateOfferState(doc.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Gönderildi",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.orange,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Evet",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Hayır",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          });
    },
  );
}

