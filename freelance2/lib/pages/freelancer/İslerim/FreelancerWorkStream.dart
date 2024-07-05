import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/widget/FreelancerJobsCard.dart';

import '../../../widget/Freelancer_Card.dart';
import '../../../widget/freelancerWaitingJobsCard.dart';
import '../../../screen/DetailsScreen.dart';

class FreelancerWorkStream extends StatefulWidget {
  User user;
  String durum;

  FreelancerWorkStream(this.user,this.durum,{super.key});

  @override
  State<FreelancerWorkStream> createState() => _FreelancerWorkStreamState();
}

class _FreelancerWorkStreamState extends State<FreelancerWorkStream> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('jobs').
          where('freelancer_id', isEqualTo: widget.user.uid.toString()).
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
                children: widget.durum=='devam ediyor'? snapshot.data!.docs
                    .map((value) => FreelancerJobsCard(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsScreen(value,widget.user))); //detay sayfasına buradan atıcak
                }, value, context))
                    .toList() : snapshot.data!.docs
                    .map((value) => FreelancerWaitingJobsCard(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsScreen(value,widget.user))); //detay sayfasına buradan atıcak
                }, value, context))
                    .toList(),
              );
            }
            return const Text("Veri yok");
          }),
    );
  }
}