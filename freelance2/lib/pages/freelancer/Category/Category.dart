import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../style/color.dart';
import 'CategoryContainer.dart';
import 'imageList.dart';


class Category extends StatefulWidget {
  User user;
   Category(this.user,{super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.black,
        title: Text("Kategoriler",style: TextStyle(color: Colors.white),),
       leading: Icon(Icons.menu,color: Colors.white,),
        ),
        backgroundColor: Appcolor,
        body: ListView(
          children: [

            Expanded(
                child: Column(
                  children: [
                    CategoryContainer(yazilim, "Yazılım ve Teknoloji", context,widget.user),
                    CategoryContainer(grafik, "Grafik Tasarım", context,widget.user),
                    CategoryContainer(ceviri, "Yazı ve Çeviri", context,widget.user),
                    CategoryContainer(isveyonetimi, "İş ve Yönetimi", context,widget.user),
                    CategoryContainer(video, "Video Animasyon", context,widget.user),


                  ],
                ))
          ],
        ),
      ),
    );
  }
}