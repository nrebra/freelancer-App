import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/pages/employer/employerControlPage.dart';
import 'package:freelance2/pages/freelancer/freelancerControlPage.dart';

import 'package:freelance2/screen/user/register.dart';

import '../../service/Functions.dart';
import '../../service/userTypeService.dart';
import '../../style/color.dart';
import '../../widget/loginButon.dart';
import '../../widget/loginContainer.dart';
import '../../widget/textFile.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  late final UserTypeService _userTypeService = UserTypeService();
//----------------------------------------------

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;




  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.orange,
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                child: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.orange,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  [
                              Padding(
                                padding: EdgeInsets.only(top: 16, left: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(9.0),
                                      child: Image.asset("assets/freelancer.png",height: 70,width: 70,color: Colors.black,),
                                    ),
                                    Text(
                                      "Freelance \n Yolculuğu",
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: Colors.black,
                                          fontFamily: 'Schyler',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        )),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Appcolor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Mytextfield(
                                  _email, "Email", const Icon(Icons.email), false),
                              const SizedBox(
                                height: 20,
                              ),
                              Mytextfield(
                                  _password, "Şifre", const Icon(Icons.lock), true),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: GestureDetector(
                                      onTap: () {

                                      },
                                      child: const Text(
                                        "Şifremi Unuttum",
                                        style: TextStyle(
                                            color: TextColor, fontSize: 16),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              LoginButton(
                                "Giriş Yap",
                                    () async {
                                  User? user = await loginFunction(_email.text, _password.text, context);


                                  if (user != null) {
                                    FirebaseFirestore.instance.collection("users").where("email",isEqualTo: _email.text).get().then((querySnapshot) {

                                      if(querySnapshot.docs.isNotEmpty){
                                        String userRole = querySnapshot.docs[0].data()["User Tipi"];
                                        if(userRole == "employer") {
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>employerControlPage(user)));

                                        }else if (userRole == "freelancer") {
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>freelancerControlPage(user)));

                                        }
                                      }
                                    });
                                  } },


                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));

                                  },
                                  child: const Text(
                                    "Kayıt Ol",
                                    style:
                                    TextStyle(color: TextColor, fontSize: 16),
                                  ),
                                ),
                              ),
                              Row(children: <Widget>[
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 10.0, right: 20.0),
                                      child: const Divider(
                                        color: Colors.white,
                                        height: 36,
                                      )),
                                ),
                                const Text(
                                  "Veya",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20.0, right: 10.0),
                                      child: const Divider(
                                        color: Colors.white,
                                        height: 36,
                                      )),
                                ),
                              ]),
                              SizedBox(height: 20,),
                              LoginContainer("assets/google.jpg", "Google"),
                              const SizedBox(
                                height: 20,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            ),
        );
    }
}