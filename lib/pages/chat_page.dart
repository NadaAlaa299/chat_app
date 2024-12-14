import 'package:chat_app/conetants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key ,  this.email});

  String? email;

  final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void scrollToBottom() {
    // Scroll to the bottom of the ListView
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('created at', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
          }

          // Scroll to the bottom when messages update
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollToBottom();
          });

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 60,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'Chat',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email ? ChatBubble(
                        message: messagesList[index],
                      ) : ChatBubble2(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        'message': data,
                        'created at': DateTime.now(),
                        'id' : email
                      });
                      controller.clear();
                      scrollToBottom();
                    },
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                      ),
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const ModalProgressHUD(inAsyncCall: true, child: Scaffold());
        }
      },
    );
  }
}
