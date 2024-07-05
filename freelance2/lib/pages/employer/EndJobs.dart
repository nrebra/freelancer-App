import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../freelancer/İslerim/FreelancerWorkStream.dart';
import 'WorksStream.dart';
import 'WorksStream2.dart';

class EndJobs extends StatefulWidget {
  User user;

   EndJobs(this.user,{super.key});

  @override
  State<EndJobs> createState() => _EndJobsState();
}

class _EndJobsState extends State<EndJobs> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: WorkStream(widget.user,"Tamamlandı"),
        )
      ],),
    );
  }
}
