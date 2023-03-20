import 'package:chat_app/chatting/chat/message.dart';
import 'package:chat_app/chatting/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
        actions: [
          IconButton(
            onPressed: () {
              _authentication.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.exit_to_app_sharp),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: const [
            Expanded(
              child: Message(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
