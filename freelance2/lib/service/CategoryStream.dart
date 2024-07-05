import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/pages/freelancer/Category/jobDetailFl.dart';
import 'package:freelance2/pages/freelancer/freelancerControlPage.dart';
import 'package:freelance2/screen/DetailsScreen.dart';
import 'package:freelance2/widget/Freelancer_Card.dart';

class CategoryStream extends StatefulWidget {
  User user;
  String kategori;
  String name = "";


  CategoryStream(this.kategori, this.name,this.user,{super.key});

  @override
  State<CategoryStream> createState() => _CategoryStreamState();
}

class _CategoryStreamState extends State<CategoryStream> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
          stream: (widget.name != "")
              ? FirebaseFirestore.instance
              .collection('jobs')
              .where("Arama", arrayContains: widget.name)
              
              .snapshots()
              : FirebaseFirestore.instance
              .collection('jobs')
              .where('kategori', isEqualTo: widget.kategori)
              .where('durum',isEqualTo: 'Active')

          
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.6 / 1.5,
                    crossAxisSpacing: 10),
                children: snapshot.data!.docs
                    .map((value) => FreelancerCard(widget.user,value,() {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>DetailsScreen(value,widget.user))); //detay sayfasına buradan atıcak
                }, value, context))
                    .toList(),
              );
            }
            return const Text("Veri yok");
          }),
    );
  }
}