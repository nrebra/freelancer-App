import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JobDetailsScreen extends StatelessWidget {
  final QueryDocumentSnapshot doc;
  final User user;

  JobDetailsScreen(this.doc, this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(doc['başlık']),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doc['başlık'],
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "Detaylar",
              style: TextStyle(color: Colors.orange, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              doc['detay'],
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Yetenekler",
              style: TextStyle(color: Colors.orange, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              doc['yetenekler'],
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Son Tarih",
              style: TextStyle(color: Colors.orange, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              doc['tarih'],
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Fiyat",
              style: TextStyle(color: Colors.orange, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              "${doc['fiyat']}₺",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Teklif",
              style: TextStyle(color: Colors.orange, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              "${doc['teklif']}₺",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
