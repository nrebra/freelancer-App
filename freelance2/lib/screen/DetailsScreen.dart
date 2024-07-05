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

class DetailsScreen extends StatefulWidget {
  User user;
  DetailsScreen(this.doc,this.user,{super.key});

  QueryDocumentSnapshot doc;


  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

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

  void newteklif() {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          "Teklif Ver",
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: employerTextField(teklifcontroller, "Teklif"),
              ),

              SizedBox(height: 16),


            ],
          ),
        ),
        actions: [
          MaterialButton(
            color: Colors.orange,
            onPressed: () async{
              Navigator.pop(context);

             await teklif(
                  teklif_id,
                  widget.doc["job_id"],
                  widget.doc["employer_id"],
                  teklifcontroller.text,
                  widget.doc["başlık"],
                  widget.doc["detay"],
                  widget.doc["fiyat"],
                  widget.doc["yetenekler"],
                  widget.doc["tarih"],
                  widget.user,
               context
              );
              teklifcontroller.clear();

            },
            child: const Text(
              "Gönder",
              style: TextStyle(color: Colors.white),

            ),
          ),
          MaterialButton(
            color: Colors.orange,
            onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  "İptal edildi",
                  style: TextStyle(fontSize: 17,color: Colors.white),
                ),
                backgroundColor: Colors.orange,
              ),
            );
          },
            child: const Text(
              "İptal",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void cancel() {
    Navigator.pop(context);
    //clear();
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
                            padding: const EdgeInsets.only(right: 20),
                            child: HeaderContainers(
                                const Icon(Icons.favorite, color: TextColor2,size: 35,),
                                    () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                          Row(
                                            children: [
                                              Text("Favorilere Eklendi"),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(Icons.favorite,color: Colors.deepOrange,),
                                              )
                                            ],
                                          )));
                                  final currentUser = _auth.currentUser;
                                  AddFavoriData(widget.doc,currentUser!.uid,context);

                                    }),
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

                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: SizedBox(
                                height: 47,
                                width: 160,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)),
                                        backgroundColor: Colors.orange),
                                    onPressed: () {
                                     newteklif();

                                     },
                                    child: const Text("Teklif ver",
                                        style: TextStyle(fontSize: 18,color: Colors.white))),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: SizedBox(
                                height: 47,
                                width: 160,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)),
                                        backgroundColor: Colors.orange),
                                    onPressed: () {

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>ChatPage(receiverAd: currentUserName,receiverMail:currentUserEmail)));                                    },
                                    child: const Text("Mesaj At",
                                        style: TextStyle(fontSize: 18,color: Colors.white))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ));
    }
}