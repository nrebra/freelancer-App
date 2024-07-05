import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/pages/freelancer/freelancerControlPage.dart';
import 'package:freelance2/pages/freelancer/freelancerHomePage.dart';

import 'Buildimage.dart';

Widget CategoryContainer(List Url, String title, context,User user) {
  return Column
    (
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 40,right: 40,top: 20,bottom: 10),
        child: Container(
            width: double.infinity,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.orange, 
              borderRadius: BorderRadius.circular(40)
            ),
            child: Center(child: Text(title,style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),))),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FreelancerHomePage(title,user))); //başlık gönderilicek
        },
        child: Padding(
          padding: const EdgeInsets.only( left: 40, right: 40),
          child: SizedBox(
            width: double.infinity,
            height: 180,
            child: Stack(children: [
              CarouselSlider.builder(
                  itemCount: Url.length,
                  itemBuilder: (context, index, realIndex) {
                    final imageurl = Url[index];
                    return buildImage(imageurl, index);
                  },
                  options: CarouselOptions(
                      height: 180,
                      viewportFraction: 1,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      autoPlayInterval: const Duration(seconds: 7))),

            ]),
          ),
        ),
      ),
    ],
  );
}