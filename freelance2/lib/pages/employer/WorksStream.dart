import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/screen/DetailsScreen.dart';
import 'package:freelance2/widget/Freelancer_Card.dart';
import 'package:freelance2/widget/employer_card.dart';

import '../../widget/employerWaitingJobsCard.dart';

class WorkStream extends StatefulWidget {
  User user;
  String durum;

  WorkStream(this.user,this.durum,{super.key});

  @override
  State<WorkStream> createState() => _WorkStreamState();
}

class _WorkStreamState extends State<WorkStream> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('jobs').
          where('employer_id', isEqualTo: widget.user.uid.toString()).
          where('durum',isEqualTo: widget.durum)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.6 / 1.5,
                    crossAxisSpacing: 10),
                children: widget.durum == 'Teslim Edildi' ? snapshot.data!.docs
                    .map((value) =>   EmployerWaitingJobsCard(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  DetailsScreen(value,widget.user))); //detay sayfasına buradan atıcak
                }, value, context))
                    .toList() :
                  snapshot.data!.docs
                    .map((value) =>   EmployerCard(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  DetailsScreen(value,widget.user))); //detay sayfasına buradan atıcak
                }, value, context))
                    .toList(),
              );
            }
            return const Text("Veri yok");
          }),
    );
  }
}