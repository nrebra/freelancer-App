import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/pages/freelancer/%C4%B0slerim/FreelancerJobs.dart';
import 'package:freelance2/pages/freelancer/%C4%B0slerim/FreelancerWorkStream.dart';


class FreelancerEndJobs extends StatefulWidget {
  User user;

  FreelancerEndJobs(this.user,{super.key});

  @override
  State<FreelancerEndJobs> createState() => _FreelancerEndJobsState();
}

class _FreelancerEndJobsState extends State<FreelancerEndJobs> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FreelancerWorkStream(widget.user,"Tamamlandı"),
        )
      ],),
    );
  }
}
