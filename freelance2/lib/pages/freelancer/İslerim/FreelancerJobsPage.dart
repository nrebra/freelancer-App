
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/pages/freelancer/%C4%B0slerim/freelancerDetailsScreen.dart';


class MyJobsPage extends StatelessWidget {
  final User user;

  MyJobsPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('İşlerim'),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('offers')
            .where('freelancer_id', isEqualTo: user.uid)
            .where('durum', isEqualTo: 'Teklif Verildi')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Teklif verilen iş bulunmamaktadır.', style: TextStyle(color: Colors.white)));
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['başlık'], style: TextStyle(color: Colors.white)),
                subtitle: Text('Teklif: ${doc['teklif']}', style: TextStyle(color: Colors.grey)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobDetailsScreen(doc, user),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
