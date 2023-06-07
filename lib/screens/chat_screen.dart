import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bolt_chat/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
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
        backgroundColor: kTextColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _fireStore
                    .collection('messages')
                    .orderBy('key')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Container();

                  return ListView(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 15.0),
                    children: snapshot.data!.docs.reversed.map((e) {
                      dynamic currentDocumentObj = e.data();

                      return messageInput(
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
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      _controller.clear();
                      if (messageText.isNotEmpty) {
                        _fireStore.collection('messages').count().get().then(
                              (value) => {
                                _fireStore.collection('messages').add({
                                  'text': messageText,
                                  'email': currentLoggedInUser.email,
                                  'key': (value.count + 1),
                                })
                              },
                            );
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

  Padding messageInput(String email, String text) {
    final bool isSenderMe = (currentLoggedInUser.email == email);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment:
            (isSenderMe ? CrossAxisAlignment.end : CrossAxisAlignment.start),
        children: [
          Text(
            email,
            style: TextStyle(
              fontSize: 15,
              color: Colors.blue[100],
            ),
          ),
          Material(
            borderRadius: kMessageBubbleBorder.copyWith(
              topLeft: (isSenderMe
                  ? kCircularBorderRadius
                  : const Radius.circular(0)),
              topRight: (isSenderMe
                  ? const Radius.circular(0)
                  : kCircularBorderRadius),
            ),
            elevation: 5.0,
            color: (isSenderMe ? Colors.deepPurple[300] : kRegisterButtonColor),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(text,
                  style: const TextStyle(
                    fontSize: 17.0,
                    // letterSpacing: 1,
                    color: Colors.black,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
