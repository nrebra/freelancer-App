// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../style/color.dart';
import '../../widget/FavoriCard.dart';
import '../../screen/DetailsScreen.dart';

class Favorites extends StatefulWidget {

  User user;
   Favorites(this.user,{super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Wrap(
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    "Favorilerim",
                    style: TextStyle(
                        fontSize: 30, color: TextColor, fontFamily: 'Schyler'),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Favoriler")
                      .where('freelancer_id', isEqualTo: widget.user.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView(
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((value) => FavoriCard(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsScreen(value,widget.user)));
                        }, value, context))
                            .toList(),
                      );
                    } else {
                      return const Text(
                        "Favori Ürününüz Yok",
                        style: TextStyle(color: Colors.white),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}