import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/pages/freelancer/%C4%B0slerim/FreelancerJobs.dart';
import 'package:freelance2/pages/freelancer/Category/Category.dart';
import 'package:freelance2/pages/freelancer/Favorites.dart';
import 'package:freelance2/pages/freelancer/Profil/Profil.dart';
import 'package:freelance2/pages/freelancer/mesaj/MesajPage.dart';
import 'package:freelance2/pages/freelancer/freelancerHomePage.dart';

import '../../style/color.dart';
import 'Favori/Favori.dart';

class freelancerControlPage extends StatefulWidget {
  User user;

  freelancerControlPage(this.user,{super.key});

  @override
  State<freelancerControlPage> createState() => _freelancerControlPageState();
}

class _freelancerControlPageState extends State<freelancerControlPage> {
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
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [MenuHeader(_kullaniciAdi ?? ""), MenuItems()],
          ),
        ),
      ),
      body: SizedBox(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Category(widget.user),
            Favorites(widget.user),
            FreelancerJobs(widget.user),
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
              title: const Text('Favoriler'),
              icon: const Icon(Icons.favorite)),
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

class MenuHeader extends StatelessWidget {
  String kullanici;
  MenuHeader(this.kullanici, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Appcolor2,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/login.jpg"),
              radius: 40,
            ),
            const SizedBox(
              height: 12,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Hoşgeldiniz",
                style: TextStyle(color: TextColor, fontSize: 19),
              ),
            ),
            Text(
              kullanici,
              style: const TextStyle(color: TextColor, fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItems extends StatelessWidget {

  MenuItems( {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {

              /*Navigator.push(context,
                  MaterialPageRoute(builder: ((context) =>  HomePage()))); */
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favoriler"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const FavoriPage())));
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_basket),
            title: const Text("Sepet"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) =>  MesajPage())));
            },
          ),
          const Divider(
            color: Colors.black54,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Ayarlar"),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Hata Bildirimi"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Çıkış Yap"),
            onTap: () {

            },
          )
        ],
      ),
    );
  }
}