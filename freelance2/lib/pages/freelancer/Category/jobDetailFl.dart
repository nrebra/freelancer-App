import 'package:flutter/material.dart';

class jobDetailFl extends StatefulWidget {
  const jobDetailFl({super.key});

  @override
  State<jobDetailFl> createState() => _jobDetailFlState();
}

class _jobDetailFlState extends State<jobDetailFl> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Başlık"),
        ),
        body: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
