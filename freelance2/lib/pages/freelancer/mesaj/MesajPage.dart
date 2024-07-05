import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../screen/user/login.dart';
import '../../../service/chat/chatService.dart';
import 'ChatPage.dart';

class MesajPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ChatService _chatService = ChatService();

  MesajPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentUser = _auth.currentUser?.displayName ?? 'Anonymous';
    String currentUserId = _auth.currentUser?.uid ?? 'Anonymous';


    final ChatService _chatService = ChatService();
    return Scaffold(
      appBar: AppBar(
        title: Text("Mesaj"),
      ),
      body: _buildUserList(context, currentUser),
    );
  }

  Widget _buildUserList(BuildContext context, String currentUser) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String currentUserId = _auth.currentUser?.uid ?? 'Anonymous';
    return FutureBuilder<bool>(
      future: isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          final bool isLoggedIn = snapshot.data ?? false;
          if (!isLoggedIn) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            });
            return Container();
          } else {
            return StreamBuilder<List<Map<String, dynamic>>>(
              stream: _chatService.getUsersStream(currentUserId),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No Users Found"));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final userData = snapshot.data![index];
                    print("aa $userData");
                    final ad = userData['Kullanıcı Adı'] ?? 'No Name';
                    final mail = userData['Mail'] ?? 'No Mail';
                    final image = userData['image'] ?? 'No image_url';
                    print(image);
                    return ListTile(
                      title: Row(
                        children: [
                      CircleAvatar(
                      backgroundImage: NetworkImage(image),
                    ),
                          SizedBox(width: 10),
                          Text(ad),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(receiverAd: ad,receiverMail:mail),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          }
        }
      },
    );
  }

  Future<bool> isUserLoggedIn() async {
    final currentUser = _auth.currentUser;
    return currentUser != null;
  }
}
