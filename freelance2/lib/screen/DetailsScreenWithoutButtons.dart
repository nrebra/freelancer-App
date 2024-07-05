// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/pages/freelancer/mesaj/MesajPage.dart';
import 'package:uuid/uuid.dart';

import '../service/Functions.dart';
import '../service/chat/chatService.dart';
import '../style/color.dart';
import '../widget/detaycontainer.dart';
import '../widget/employerTextField.dart';
import '../pages/freelancer/mesaj/ChatPage.dart';

class DetailsScreenWithoutButtons extends StatefulWidget {
  User user;
  String userName;

  DetailsScreenWithoutButtons(this.doc,this.user,this.userName,{super.key});

  QueryDocumentSnapshot doc;


  @override
  State<DetailsScreenWithoutButtons> createState() => _DetailsScreenWithoutButtons();
}

class _DetailsScreenWithoutButtons extends State<DetailsScreenWithoutButtons> {

  TextEditingController teklifcontroller = TextEditingController();
  final teklif_id = Uuid().v4();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String currentUserUid;
  late String currentUserEmail;
  late String currentUserName;
  final ChatService _chatService = ChatService();

  @override
  void initState() {
    super.initState();
    _initializeCurrentUser();
  }

  Future<void> _initializeCurrentUser() async {
    final currentUser = _auth.currentUser;

    if (currentUser != null) {
      currentUserUid = currentUser.uid;
      await _fetchUserDetails(currentUserUid);
    } else {
      // Giriş yapmış kullanıcı yoksa yapılacak işlemler
      print('Giriş yapmış kullanıcı yok');
    }

    print(currentUserEmail); // Bu satır e-posta alındıktan sonra çalışacaktır.
  }

  Future<void> _fetchUserDetails(String uid) async {
    final userDetails = await _chatService.getUserDetailsByUid(widget.doc["employer_id"]);
    if (userDetails != null) {
      setState(() {
        currentUserName = userDetails['name']!;
        currentUserEmail = userDetails['email']!;
        print('Name: $currentUserName, Email: $currentUserEmail');
      });
    } else {
      // Kullanıcı bilgileri alınamadı
      print('Kullanıcı bilgileri alınamadı');
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(

        child: Scaffold(
          backgroundColor: Appcolor,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeaderContainers(
                          const Icon(Icons.arrow_back_ios_new_outlined,
                              color: TextColor2),
                              () {
                            Navigator.pop(context);
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(widget.doc["başlık"],style: TextStyle(color: Colors.white,fontSize: 20),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 24),

                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40,right: 10,left: 10,bottom: 15),
                      child: SingleChildScrollView(
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(30)),
                              border: Border.all(color: Colors.orange),
                              color: Colors.black.withOpacity(0.4)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 28),
                                  child: Text(
                                    widget.doc["detay"],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "İsim",
                        style: TextStyle(color: Colors.orange, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(widget.userName,
                            style:
                            const TextStyle(color: Colors.white, fontSize: 17))
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Yetenekler",
                        style: TextStyle(color: Colors.orange, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(widget.doc["yetenekler"],
                            style:
                            const TextStyle(color: Colors.white, fontSize: 17))
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20,top: 20),
                      child: Text(
                        "Son Tarih",
                        style: TextStyle(color: Colors.orange, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(widget.doc["tarih"],
                            style:
                            const TextStyle(color: Colors.white, fontSize: 17))
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        "Fiyat",
                        style: TextStyle(color: Colors.orange, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(widget.doc["fiyat"] + "₺",
                            style:
                            const TextStyle(color: Colors.white, fontSize: 17))
                    ),


                  ],
                )
              ],
            ),
          ),
        ));
  }
}