import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/pages/employer/WorksStream.dart';

class ActiveJobs extends StatefulWidget {
  User user;
   ActiveJobs(this.user,{super.key});

  @override
  State<ActiveJobs> createState() => _ActiveJobsState();
}

class _ActiveJobsState extends State<ActiveJobs> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(children: [
        
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: WorkStream(widget.user,"Active"),
          )
        ],),
      ),
    );
  }
}
