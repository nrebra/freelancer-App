import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../service/CategoryStream.dart';
import '../../style/color.dart';

class FreelancerHomePage extends StatefulWidget {
  String CategoryName;
  User user;
  FreelancerHomePage(this.CategoryName, this.user, {Key? key}) : super(key: key);

  @override
  State<FreelancerHomePage> createState() => _FreelancerHomePageState();
}

class _FreelancerHomePageState extends State<FreelancerHomePage> {
  TextEditingController arama = TextEditingController();
  int index = 0;
  String name = "";

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Appcolor,
        appBar: AppBar(
          backgroundColor: Appcolor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: TextColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            widget.CategoryName,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 1, // Only one item (the Column containing all the content)
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 28,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 33, right: 58),
                  child: TextField(
                    style: const TextStyle(color: TextColor),
                    controller: arama,
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    decoration: InputDecoration(
                      fillColor: const Color(0xff282C34),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: EnabledColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: EnabledColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: SizedBox(
                        height: 5,
                        width: 5,
                        child: Lottie.network(
                          "https://assets9.lottiefiles.com/packages/lf20_vhppiil2.json",
                        ),
                      ),
                      hintText: "İstediğin Freelancerı Ara",
                      hintStyle: const TextStyle(color: Color(0xff52575D), fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                const SizedBox(
                  height: 21,
                ),
                CategoryStream(widget.CategoryName, name, widget.user),
              ],
            );
          },
        ),
      ),
    );
  }
}
