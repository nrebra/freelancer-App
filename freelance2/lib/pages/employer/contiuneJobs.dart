import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/pages/employer/WorksStream.dart';


class contiuneJobs extends StatefulWidget {
  User user;
  contiuneJobs(this.user,{super.key});

  @override
  State<contiuneJobs> createState() => _contiuneJobsState();
}
class _contiuneJobsState extends State<contiuneJobs> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: WorkStream(widget.user,"devam ediyor"),
        )
      ],),
    );
  }
}