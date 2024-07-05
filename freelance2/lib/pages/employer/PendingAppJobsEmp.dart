import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/pages/employer/WorksStream.dart';

import 'WorksStream2.dart';

class PendingApp extends StatefulWidget {
  User user;
  PendingApp(this.user,{super.key});

  @override
  State<PendingApp> createState() => _PendingAppState();
}

class _PendingAppState extends State<PendingApp> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: WorkStream(widget.user,"Teslim Edildi"),
        )
      ],),
    );
  }
}
