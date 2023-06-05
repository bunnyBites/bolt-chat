import 'package:bolt_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreenState extends StatefulWidget {
  const ChatScreenState({super.key});
  static const id = "chat_screen";

  @override
  State<ChatScreenState> createState() => ChatScreenStateState();
}

class ChatScreenStateState extends State<ChatScreenState> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  late User currentLoggedInUser;

  String messageText = "";

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    currentLoggedInUser = _auth.currentUser!;
  }

  void getMessages() {
    _fireStore.collection('messages').get().then((documents) => {
          for (var document in documents.docs) {print(document.data())}
        });
  }

  void getRealtimeMessages() {
    _fireStore.collection('messages').snapshots().forEach((element) {
      for (var doc in element.docs) {
        print(doc.data());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                // _auth.signOut();
                // Navigator.pop(context);

                getRealtimeMessages();
                // getMessages();
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _fireStore.collection('messages').snapshots(),
                builder: (context, snapshot) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 15.0),
                    children: snapshot.data!.docs.map((e) {
                      dynamic currentDocumentObj = e.data();
                      if (currentDocumentObj != null) {
                        return Text(
                          currentDocumentObj['email'],
                          style: const TextStyle(fontSize: 15),
                        );
                      }

                      return Container();
                    }).toList(),
                  );
                },
              ),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          messageText = value;
                        });
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      _fireStore.collection('messages').add({
                        'text': messageText,
                        'email': currentLoggedInUser.email,
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
