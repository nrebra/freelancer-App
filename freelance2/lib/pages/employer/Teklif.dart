import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/screen/DetailsScreenWithoutButtons.dart';
import 'package:freelance2/widget/OfferCard.dart';
import '../../style/color.dart';
import '../../screen/DetailsScreen.dart';

class TeklifPage extends StatefulWidget {
  final User user;

  TeklifPage(this.user, {super.key});

  @override
  State<TeklifPage> createState() => _TeklifPageState();
}

class _TeklifPageState extends State<TeklifPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor,
      appBar: AppBar(
        backgroundColor: Appcolor, // Arka plan rengini ayarlayabilirsiniz
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: TextColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Gelen Teklifler",
          style: TextStyle(fontSize: 24, color: TextColor, fontFamily: 'Schyler'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Wrap(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('offers')
                    .where('employer_id', isEqualTo: widget.user.uid.toString())
                    .where('durum', isEqualTo: 'Teklif Verildi')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((offerData) {
                        // `freelancer_id`yi kullanarak kullanıcıyı al
                        String freelancerId = offerData['freelancer_id'];
                        return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance.collection('users').doc(freelancerId).get(),
                          builder: (context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                            if (userSnapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (userSnapshot.hasData && userSnapshot.data != null) {
                              // Kullanıcının ismini al
                              String freelancerName = userSnapshot.data!['Kullanıcı Adı'];
                              return OfferCard(
                                    () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreenWithoutButtons(
                                        offerData,
                                        widget.user,
                                        freelancerName, // freelancerName'i ekliyoruz
                                      ),
                                    ),
                                  );
                                },
                                offerData,
                                context,
                                widget.user,
                              );
                            } else {
                              return const Text(
                                "Kullanıcı Bilgisi Yüklenemedi",
                                style: TextStyle(color: Colors.white),
                              );
                            }
                          },
                        );
                      }).toList(),
                    );
                  } else {
                    return const Text(
                      "Teklif Yok",
                      style: TextStyle(color: Colors.white),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
