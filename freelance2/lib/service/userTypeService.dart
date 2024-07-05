import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/freelancer/freelancerHomePage.dart';
import '../pages/employer/employerHomePage.dart';

class UserTypeService {
  static void navigateToHomePage(BuildContext context, String userType) {
    //YÖNLENDİRME
    if (userType == 'freelancer') {
      Navigator.pushReplacement( //YENİ SAYFAYI GEÇERLİ KILAR
        context,
        MaterialPageRoute(
            builder: (context) => freelancerHomePage()),
      );
    } else if (userType == 'employer') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => employerHomePage()),
      );
    } else {
      // Kullanıcı tipi geçersizse, bir hata işleyin veya varsayılan bir sayfaya yönlendirin
    }
  }

  // Yeni eklenen yöntem
  static Future<void> checkUserTypeAndNavigate(BuildContext context) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {

        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (snapshot.exists) {
          String userType = snapshot.get('User Tipi');

          // Kullanıcı tipine göre yönlendirme yap
          navigateToHomePage(context, userType);
        }
        else {
          print('Kullanıcı belgesi bulunamadı.');
        }
      }
    }

  static employerHomePage(){}
  static freelancerHomePage() {}
}
