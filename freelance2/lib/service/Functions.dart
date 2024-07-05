import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/screen/user/login.dart';
import 'package:uuid/uuid.dart';

import '../pages/employer/employerHomePage.dart';
import '../pages/freelancer/freelancerHomePage.dart';

Future<String> signUp(
    String email, String password, String kullaniciAdi, String userType, BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;

    if (user != null) {
      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        "email": email,
        "sifre": password,
        "Kullanıcı Adı": kullaniciAdi,
        "User Tipi": userType,
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
      return "Success";
    }
  } on FirebaseAuthException catch (e) {
    String errorMessage;
    if (e.code == 'email-already-in-use') {
      errorMessage = "Bu email ile zaten bir hesap oluşturulmuş.";
    } else {
      errorMessage = e.message ?? "Bir hata oluştu";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 3),
      ),
    );
    return errorMessage;
  }
  return "Bir hata oluştu";
}

Future<User?> loginFunction(
    String email, String password, BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email, password: password);
    user = userCredential.user;
  } on FirebaseAuthException catch (e) {
    String errorMessage;
    print(e.code);
    if (e.code == 'invalid-credential') {
      errorMessage = "Giriş yaparken bir hata oluştu";
    } else {
      errorMessage = "Giriş yaparken bir hata oluştu";
    }
    // Snackbar ile hata mesajını göster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 3),
      ),
    );
  }
  return user;
}


Future<void> saveJobs(String job_id, String Baslik, String Detay, String Fiyat, String Yetenekler, String sonTarih, String category, User user) async {
  await FirebaseFirestore.instance.collection('jobs').doc(job_id).set({
    'job_id': job_id,
    'employer_id': user.uid,
    'başlık': Baslik,
    'detay': Detay,
    'durum': 'Active',
    'kategori': category,
    'tarih': sonTarih,
    'yetenekler': Yetenekler,
    'fiyat': Fiyat,
  });
}
void AddFavoriData(QueryDocumentSnapshot doc, String freelancerId, BuildContext context) async {
  var uuid = Uuid();
  String favoriId = uuid.v4();

  // Belirli bir job_id ve freelancer_id ile belge olup olmadığını kontrol et
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Favoriler")
      .where("job_id", isEqualTo: doc["job_id"])
      .where("freelancer_id", isEqualTo: freelancerId)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    // Eğer böyle bir belge varsa uyarı ver
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "Bu iş daha önce favorilere eklenmiş.",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  } else {
    // Eğer böyle bir belge yoksa ekleme işlemini gerçekleştir
    print("Veri geliyor: ${doc.data()}");
    await FirebaseFirestore.instance.collection("Favoriler").add({
      "favori_id": favoriId,
      "başlık": doc["başlık"],
      "detay": doc["detay"],
      "yetenekler": doc["yetenekler"],
      "fiyat": doc["fiyat"],
      "tarih": doc["tarih"],
      "durum": doc["durum"],
      "freelancer_id": freelancerId,
      "job_id": doc["job_id"],
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.orange,
        content: Text(style: TextStyle(color: Colors.white,fontSize: 17),"Favorilere eklendi"),
      ),
    );
  }
}
deleteData(id, String Referans) async {
  await FirebaseFirestore.instance.collection(Referans).doc(id).delete();
}



Future<void> updateOfferState(String id) async {
  try {

    await FirebaseFirestore.instance
        .collection('jobs')
        .doc(id)
        .update({'durum': 'Teslim Edildi'});

    print(' durum başarıyla güncellendi');
  } catch (e) {
    print('durum güncellenirken hata oluştu: $e');
  }
}

Future<void> acceptJobsRequest(String id) async {
  try {

    await FirebaseFirestore.instance
        .collection('jobs')
        .doc(id)
        .update({'durum': 'Tamamlandı'});

    print(' durum başarıyla güncellendi');
  } catch (e) {
    print('durum güncellenirken hata oluştu: $e');
  }
}

Future<void> refuseJobsRequest(String id) async {
  try {
    // Freelancerjobs koleksiyonunu güncelle
    await FirebaseFirestore.instance
        .collection('offers')
        .doc(id)
        .update({'durum': 'Reddedildi'});

    print(' durum başarıyla güncellendi');
  } catch (e) {
    print('durum güncellenirken hata oluştu: $e');
  }
}


Future<void> updateJobsState(String id) async {
  try {
    // Freelancerjobs koleksiyonunu güncelle
    await FirebaseFirestore.instance
        .collection('jobs')
        .doc(id)
        .update({'durum': 'Tamamlandı'});

    print('Durum başarıyla güncellendi');
  } catch (e) {
    print('Durum güncellenirken hata oluştu: $e');
  }
}

Future<void> refuseFinishRequest(String id) async {
  try {
    // Freelancerjobs koleksiyonunu güncelle
    await FirebaseFirestore.instance
        .collection('jobs')
        .doc(id)
        .update({'durum': 'devam ediyor'});

    print('Durum başarıyla güncellendi');
  } catch (e) {
    print('Durum güncellenirken hata oluştu: $e');
  }
}



Future<void> acceptOfferStatus(String jobId, String freelancerId) async {
  try {
    // jobs koleksiyonundaki iş belgesini alın
    DocumentReference jobDocRef = FirebaseFirestore.instance.collection('jobs').doc(jobId);
    DocumentSnapshot jobSnapshot = await jobDocRef.get();

    if (jobSnapshot.exists) {
      // offers koleksiyonundaki ilgili belgeyi alın
      QuerySnapshot offerSnapshot = await FirebaseFirestore.instance
          .collection('offers')
          .where('job_id', isEqualTo: jobId)
          .get();

      if (offerSnapshot.docs.isNotEmpty) {
        // İlk belgeyi al (varsayım: her job_id için yalnızca bir teklif vardır)
        var offerDoc = offerSnapshot.docs.first;
        var offerData = offerDoc.data() as Map<String, dynamic>;

        // İş belgesini güncelle
        await jobDocRef.update({
          'durum': 'devam ediyor', // Durum alanını "devam ediyor" olarak güncelle
          'freelancer_id': freelancerId, // freelancer_id alanını ekle veya güncelle
          'ucret': offerData['teklif'], // offers tablosundaki ücreti ekle
        });

        // offers koleksiyonundaki durumu güncelle
        for (var doc in offerSnapshot.docs) {
          await doc.reference.update({
            'durum': 'Kabul Edildi', // Durum alanını "Kabul Edildi" olarak güncelle
          });
        }

        print('İş ve freelancer durumu güncellendi: $jobId, $freelancerId');
      } else {
        print('İlgili teklif belgesi bulunamadı: $jobId');
      }
    } else {
      print('İş belgesi bulunamadı: $jobId');
    }
  } catch (e) {
    print('İş veya freelancer durumu güncellenemedi: $e');
  }
}

Future<void> deletedata(String teklifId, {String? jobId, String? freelancerId}) async {
  try {
    // offers koleksiyonundan belgeyi sil
    await FirebaseFirestore.instance.collection('offers').doc(teklifId).delete();
    print("Teklif belgesi başarıyla silindi: $teklifId");

    // Eğer jobId ve freelancerId sağlanmışsa, freelancerjobs koleksiyonundaki ilgili belgeyi sil
    if (jobId != null && freelancerId != null) {
      print("Freelancer job belgesini silmeye hazırlanıyor: jobId: $jobId, freelancerId: $freelancerId");
      QuerySnapshot freelancerJobSnapshot = await FirebaseFirestore.instance
          .collection('freelancerjobs')
          .where('job_id', isEqualTo: jobId)
          .where('freelancer_id', isEqualTo: freelancerId)
          .limit(1)
          .get();

      if (freelancerJobSnapshot.docs.isNotEmpty) {
        DocumentReference freelancerJobDocRef = freelancerJobSnapshot.docs.first.reference;
        await freelancerJobDocRef.delete();
        print("Freelancer job belgesi başarıyla silindi: ${freelancerJobDocRef.id}");
      } else {
        print('Freelancer iş belgesi bulunamadı: jobId: $jobId, freelancerId: $freelancerId');
      }
    } else {
      print('jobId veya freelancerId sağlanmadı. Sadece offers belgesi silindi.');
    }
  } catch (error) {
    print("Belge silinirken hata oluştu: $error");
  }
}

Future<void> teklif(
    String teklif_id,
    String jobid,
    String employer_id,
    String teklif,
    String baslik,
    String detay,
    String fiyat,
    String yetenekler,
    String tarih,
    User user,
    BuildContext context,
    ) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Check if an offer with the same freelancer_id and job_id already exists
  QuerySnapshot querySnapshot = await firestore
      .collection('offers')
      .where('freelancer_id', isEqualTo: user.uid)
      .where('job_id', isEqualTo: jobid)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    // Show a warning dialog if a duplicate offer exists
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Uyarı'),
        content: Text('Bu işe Daha Önceden Teklif Yapılmış'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
    return; // Exit the function without adding the offer
  }

  // Add the offer if no duplicate is found
  await firestore.collection('offers').doc(teklif_id).set({
    'teklif_id': teklif_id,
    'job_id': jobid,
    'freelancer_id': user.uid,
    'employer_id': employer_id,
    'başlık': baslik,
    'detay': detay,
    'fiyat': fiyat,
    'yetenekler': yetenekler,
    'tarih': tarih,
    'teklif': teklif,
    'durum': 'Teklif Verildi',
    'timestamp': FieldValue.serverTimestamp(),
  });


  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text(
        "Gönderildi",
        style: TextStyle(fontSize: 17,color: Colors.white),
      ),
      backgroundColor: Colors.orange,
    ),
  );
}



