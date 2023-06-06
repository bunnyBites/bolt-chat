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
  final TextEditingController _controller = TextEditingController();
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

  // void getMessages() {
  //   _fireStore.collection('messages').get().then((documents) => {
  //         for (var document in documents.docs) {print(document.data())}
  //       });
  // }

  // void getRealtimeMessages() {
  //   _fireStore.collection('messages').snapshots().forEach((element) {
  //     for (var doc in element.docs) {
  //       print(doc.data());
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
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
                  if (snapshot.hasError) return Container();

                  return ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 15.0),
                    children: snapshot.data!.docs.map((e) {
                      dynamic currentDocumentObj = e.data();

                      return chatView(
                        currentDocumentObj['email'],
                        currentDocumentObj['text'],
                      );
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
                      controller: _controller,
                      onChanged: (value) {
                        setState(() {
                          messageText = value;
                        });
                      },
                      decoration: kMessageTextFieldDecoration,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      _controller.clear();
                      if (messageText.isNotEmpty) {
                        _fireStore.collection('messages').add({
                          'text': messageText,
                          'email': currentLoggedInUser.email,
                        });
                      }
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

  Padding chatView(String email, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            email,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 5.0,
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(text,
                  style: const TextStyle(
                    fontSize: 20.0,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
