import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/pages/freelancer/%C4%B0slerim/FreelancerWorkStream.dart';


class ContiuneJobs extends StatefulWidget {
  User user;

  ContiuneJobs(this.user,{super.key});

  @override
  State<ContiuneJobs> createState() => _ContiuneJobsState();
}

class _ContiuneJobsState extends State<ContiuneJobs> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FreelancerWorkStream(widget.user,"devam ediyor"),
        )
      ],),
    );
  }
}
