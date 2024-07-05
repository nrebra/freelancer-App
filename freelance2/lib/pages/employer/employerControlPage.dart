import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/pages/employer/Jobs.dart';
import 'package:freelance2/pages/employer/employerHomePage.dart';
import 'package:freelance2/pages/freelancer/Profil/Profil.dart';
import 'package:freelance2/pages/freelancer/mesaj/MesajPage.dart';


import '../../style/color.dart';



class employerControlPage extends StatefulWidget {
  User user;

  employerControlPage(this.user,{super.key});

  @override
  State<employerControlPage> createState() => _employerControlPageState();
}

class _employerControlPageState extends State<employerControlPage> {
  int _currentIndex = 0;
  late PageController _pageController;
  String? _kullaniciAdi;



  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor,

      body: SizedBox(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            employerHomePage(widget.user),
            Jobs(widget.user),
            MesajPage(),
            ProfilPage(widget.user)

            //settings gelicek
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Appcolor,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              activeColor: EnabledColor,
              inactiveColor: TextColor,
              title: const Text('Ana Ekran'),
              icon: const Icon(
                Icons.home,
              )),

          BottomNavyBarItem(
              activeColor: EnabledColor,
              inactiveColor: TextColor,
              title: const Text('İşlerim'),
              icon: const Icon(Icons.work)),
          BottomNavyBarItem(
              activeColor: EnabledColor,
              inactiveColor: TextColor,
              title: const Text('Mesaj'),
              icon: const Icon(Icons.message)),
          BottomNavyBarItem(
              activeColor: EnabledColor,
              inactiveColor: TextColor,
              title: const Text('Profil'),
              icon: const Icon(Icons.person)),
        ],
      ),
    );
  }
}

