import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../../service/chat/chatService.dart';

class ChatPage extends StatefulWidget {
  final String receiverAd;
  final String receiverMail;
  const ChatPage({Key? key, required this.receiverAd, required this.receiverMail}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ChatService _chatService = ChatService();
  late String currentUserUid;
  late String currentUserEmail;
  bool isLoading = true;  // Loading state

  @override
  void initState() {
    super.initState();
    _initializeCurrentUser();
  }

  Future<void> _initializeCurrentUser() async {
    final currentUser = _auth.currentUser;

    if (currentUser != null) {
      currentUserUid = currentUser.uid;
      await _fetchEmail(currentUserUid);
    } else {
      // Giriş yapmış kullanıcı yoksa yapılacak işlemler
      print('Giriş yapmış kullanıcı yok');
    }

    print(currentUserEmail); // Bu satır e-posta alındıktan sonra çalışacaktır.
  }

  Future<void> _fetchEmail(String uid) async {
    final email = await _chatService.getEmailByUid(uid);
    if (email != null) {
      setState(() {
        currentUserEmail = email;
        isLoading = false;
        print(currentUserEmail);
      });
    } else {
      // Email alınamadı
      print('Email alınamadı');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverAd)),
      body: isLoading ? Center(child: CircularProgressIndicator()) : Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _chatService.getMessagesStream(currentUserUid, widget.receiverAd, widget.receiverMail, currentUserEmail),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No Messages"));
                }
                final messages = snapshot.data!;
                return ListView.builder(
                  reverse: true, // Reverse the list to show latest messages at bottom
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final messageData = messages[index];
                    final text = messageData['text'] ?? '';
                    final sender = messageData['sender'] ?? 'Anonymous';
                    final isMe = sender == currentUserEmail;
                    final timestamp = (messageData['timestamp'] as Timestamp?)?.toDate();
                    final time = timestamp != null
                        ? DateFormat('hh:mm a').format(timestamp)
                        : 'N/A';

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue[100] : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(text),
                            SizedBox(height: 5),
                            Text(time, style: TextStyle(fontSize: 10, color: Colors.grey)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Type your message here'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage(String text) {
    if (text.isNotEmpty) {
      _chatService.sendMessage(text, currentUserUid, widget.receiverAd, widget.receiverMail, currentUserEmail);
      _controller.clear();
    }
  }
}
