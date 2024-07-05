import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../service/Functions.dart';
import '../../style/color.dart';
import '../../widget/loginButon.dart';
import '../../widget/textFile.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _username = TextEditingController();
  String _userType ='freelancer';





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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset("assets/freelancer.png" , width: 70,height: 70,color: Colors.black,),
                                    ),
                                    Text(
                                      "Freelance \n Yolculuğu",
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: Colors.black,
                                          fontFamily: 'Schyler'
                                          ,
                                          fontWeight: FontWeight.bold
                                      ),
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
                              const SizedBox(
                                height: 20,
                              ),
                              Mytextfield(
                                  _username,
                                  "Kullanıcı Adı",
                                  const Icon(Icons.supervised_user_circle_rounded),
                                  false),
                              const SizedBox(
                                height: 20,
                              ),
                              ListTile(
                                title: const Text('Freelancer',style: TextStyle(color: Colors.orange),),
                                leading: Radio<String>(
                                  activeColor: Colors.orange,
                                  value: 'freelancer',
                                  groupValue: _userType,
                                  onChanged: (String? value){
                                    setState(() {
                                      _userType=value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('İş veren',style: TextStyle(color: Colors.orange),),
                                leading: Radio<String>(

                                  activeColor: Colors.orange,
                                  value: 'employer',
                                  groupValue: _userType,
                                  onChanged: (String? value){
                                    setState(() {
                                      _userType=value!;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              LoginButton(
                                "Kayıt Ol",
                                    () async {
                                  await signUp(_email.text , _password.text ,_username.text , _userType,context);

                                },
                              ),
                              const SizedBox(
                                height: 20,
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
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ),
        );
    }
}