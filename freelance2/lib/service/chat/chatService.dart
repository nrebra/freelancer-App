/*import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'Kullanıcı Adı': doc['Kullanıcı Adı'],
        };
      }).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> getMessagesStream(String receiverAd) {
    return _firestore
        .collection('messages')
        .where('receiver', isEqualTo: receiverAd)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'text': doc['text'],
          'sender': doc['sender'],
        };
      }).toList();
    });
  }

  void sendMessage(String text, String senderAd, String receiverAd) {
    _firestore.collection('messages').add({
      'text': text,
      'sender': senderAd,
      'receiver': receiverAd,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
/*
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'Kullanıcı Adı': doc['Kullanıcı Adı'],
          'Mail': doc['email'],
        };
      }).toList();
    });
  }
*/
  Stream<List<Map<String, dynamic>>> getUsersStream(String currentUserUid) async* {
    // Öncelikle currentUserUid ile userType'ı kontrol ediyoruz
    DocumentSnapshot currentUserDoc = await _firestore.collection('users').doc(currentUserUid).get();

    if (currentUserDoc.exists) {
      String userType = "${currentUserDoc['User Tipi'] as String}_id";
      String recieverType = userType == 'employer_id' ? 'freelancer_id' : 'employer_id';
      print(recieverType);

      print(userType);

      if (userType != null) {
        yield* _firestore
            .collection('offers')
            .where(userType, isEqualTo: currentUserUid)
            .snapshots()
            .asyncMap((offerSnapshot) async {
          List<Map<String, dynamic>> usersData = [];
          Set<String> addedEmails = Set();  // Eklenen e-posta adreslerini takip etmek için set

          for (var offerDoc in offerSnapshot.docs) {
            String employerId = offerDoc[recieverType];

            DocumentSnapshot userDoc = await _firestore.collection('users').doc(employerId).get();



            if (userDoc.exists) {
              String email = userDoc['email'] as String;
              if (email != null && !addedEmails.contains(email)) {
                addedEmails.add(email);  // E-posta adresini set'e ekle
                usersData.add({
                  'Kullanıcı Adı': userDoc['Kullanıcı Adı'] as String?,
                  'Mail': email,
                  'image': userDoc['image_url'],
                });
              }
            } else {
              usersData.add({
                'Kullanıcı Adı': null,
                'Mail': null,
                'image':null,
              });
            }
          }

          return usersData;
        });
      } else {
        print('User type not found for the current user.');
        yield [];
      }
    } else {
      print('Current user document does not exist.');
      yield [];
    }
  }



  Stream<List<Map<String, dynamic>>> getMessagesStream(String currentUserUid, String receiverAd, String receiverMail,String currentUserEmail) {
  // İlk sorgu: currentUserUid tarafından gönderilen mesajlar
    print(receiverMail);
    print(currentUserEmail);
  final sentMessagesStream = _firestore
      .collection('messages')
      .where('sender', isEqualTo: currentUserEmail)
      .where('receiver', isEqualTo: receiverMail)
      .snapshots();

  // İkinci sorgu: currentUserUid tarafından alınan mesajlar
  final receivedMessagesStream = _firestore
      .collection('messages')
      .where('sender', isEqualTo: receiverMail)
      .where('receiver', isEqualTo: currentUserEmail)

      .snapshots();

  // İki sorgunun sonuçlarını birleştir
  return CombineLatestStream.list([sentMessagesStream, receivedMessagesStream]).map((snapshots) {
  final sentDocs = snapshots[0].docs;
  final receivedDocs = snapshots[1].docs;
  final allDocs = [...sentDocs, ...receivedDocs];
  allDocs.sort((a, b) => b['timestamp'].compareTo(a['timestamp'])); // Zaman damgasına göre sırala
  return allDocs.map((doc) {
  return {
  'text': doc['text'],
  'sender': doc['sender'],
  'timestamp': doc['timestamp'],
  };
  }).toList();
  });
  }

  void sendMessage(String text, String senderAd, String receiverAd,String receiverMail, String currentUserEmail) {
  _firestore.collection('messages').add({
  'text': text,
  'sender': currentUserEmail,
  'receiver': receiverMail,
  'timestamp': FieldValue.serverTimestamp(),
  });
  }

  Future<String?> getEmailByUid(String uid) async {
    try {
      // Kullanıcı dökümanını Firestore'dan al
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();

      // Döküman mevcutsa, e-posta adresini döndür
      if (userDoc.exists) {
        return userDoc.get('email') as String?;
      } else {
        print('Kullanıcı bulunamadı');
        return null;
      }
    } catch (e) {
      print('Hata: $e');
      return null;
    }
  }
  Future<Map<String, String?>> getUserDetailsByUid(String uid) async {
    try {
      // Kullanıcı dökümanını Firestore'dan al
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();

      // Döküman mevcutsa, isim ve e-posta adresini döndür
      if (userDoc.exists) {
        String? email = userDoc.get('email') as String?;
        String? name = userDoc.get('Kullanıcı Adı') as String?;
        return {'name': name, 'email': email};
      } else {
        print('Kullanıcı bulunamadı');
        return {'name': null, 'email': null};
      }
    } catch (e) {
      print('Hata: $e');
      return {'name': null, 'email': null};
    }
  }

}



