import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/pages/freelancer/%C4%B0slerim/FreelancerWorkStream.dart';

import '../../../style/color.dart';
import '../../../widget/EndButton.dart';
import 'freelancerDetailsScreen.dart';


class PendingApproval extends StatefulWidget {
  User user;

  PendingApproval(this.user,{super.key});

  @override
  State<PendingApproval> createState() => _PendingApproval();
}

class _PendingApproval extends State<PendingApproval> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FreelancerWorkStream(widget.user,"Teslim Edildi"),
        )
      ],),
    );
  }
}
