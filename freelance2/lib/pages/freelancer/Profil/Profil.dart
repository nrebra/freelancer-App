import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freelance2/style/color.dart';
import 'package:freelance2/widget/textFile.dart';
import 'package:freelance2/widget/userImagePicker.dart';
import '../../../screen/user/login.dart';
import '../../../widget/loginButon.dart';

class ProfilPage extends StatefulWidget {
  final User user;
  const ProfilPage(this.user, {super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late TextEditingController kullaniciAdiController;
  late TextEditingController emailController;
  late TextEditingController yeteneklerController;
  late TextEditingController telefonController;
  late TextEditingController sifreController;
  String? _userImageUrl;

  @override
  void initState() {
    super.initState();
    kullaniciAdiController = TextEditingController();
    emailController = TextEditingController();
    yeteneklerController = TextEditingController();
    sifreController = TextEditingController();
    telefonController = TextEditingController();
  }

  Future<void> updateUser([String? imageUrl]) async {
    try {
      final updateData = {
        "Kullanıcı Adı": kullaniciAdiController.text,
        "email": emailController.text,
        "yetenekler": yeteneklerController.text,
        "telefon": telefonController.text,
        "sifre": sifreController.text,
      };

      if (imageUrl != null) {
        updateData["image_url"] = imageUrl;
      }

      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.user.uid)
          .set(updateData, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Kullanıcı bilgileri güncellendi!"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Güncelleme sırasında bir hata oluştu: $e"),
        ),
      );
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Çıkış yaparken bir hata oluştu: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor,
      resizeToAvoidBottomInset: true,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("users").doc(widget.user.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.exists) {
            var userData = snapshot.data!.data() as Map<String, dynamic>;
            kullaniciAdiController.text = userData['Kullanıcı Adı'] ?? '';
            emailController.text = userData['email'] ?? '';
            sifreController.text = userData['sifre'] ?? '';
            yeteneklerController.text = userData['yetenekler'] ?? '';
            telefonController.text = userData['telefon'] ?? '';
            _userImageUrl = userData['image_url'];

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 50), // Üst boşluğu artırmak için eklenen SizedBox
                    if (_userImageUrl != null)
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(_userImageUrl!),
                        backgroundColor: Colors.grey,
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: UserImagePicker(
                        onImagePicked: (imageUrl) {
                          setState(() {
                            _userImageUrl = imageUrl;
                          });
                          updateUser(imageUrl); // Profil fotoğrafı URL'sini güncelleyin
                        },
                      ),
                    ),
                    Mytextfield(kullaniciAdiController, "Kullanıcı Adı", Icon(Icons.account_circle_rounded), false),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Mytextfield(emailController, "E-mail", Icon(Icons.email), false),
                    ),
                    Mytextfield(sifreController, "Şifre", Icon(Icons.key), true),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Mytextfield(yeteneklerController, "Yetenekler", Icon(Icons.account_tree_rounded), false),
                    ),
                    Mytextfield(telefonController, "Telefon", Icon(Icons.phone), false),
                    SizedBox(height: 15),
                    LoginButton("Güncelle", () => updateUser()),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        foregroundColor: Colors.black,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.exit_to_app),
                          SizedBox(width: 4),
                          Text("Çıkış"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text("Kullanıcı verisi bulunamadı."));
          }
        },
      ),
    );
  }
}
