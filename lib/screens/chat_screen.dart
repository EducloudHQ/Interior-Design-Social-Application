import 'dart:convert';
import 'dart:ui';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:async';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media/screens/right_chat_screen.dart';
import 'package:social_media/screens/typing_indicator.dart';

import '../models/Message.dart';
import '../models/User.dart';
import '../repositories/chat_repository.dart';
import 'left_chat_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(this.userId, {super.key});
  final String userId;

  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  bool _isSomeoneTyping = false;
  final greyColor = const Color(0xffaeaeae);
  bool update = false;
  String chatId = "";

  final ImagePicker _picker = ImagePicker();

  FocusNode? myFocusNode;
  XFile? imageFile;
  File? audioFile;
  late bool isLoading;
  String? audioFilePath;
  String? imageUrl;

  final TextEditingController textEditingController = TextEditingController();
  ScrollController? listScrollController;
  final FocusNode focusNode = FocusNode();

  String? fileExtension;


  late final Stream<GraphQLResponse<String>> operation;
  late final Stream<GraphQLResponse<String>> sendMessageStream;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();

    listScrollController = ScrollController();
    isLoading = false;

    subscribeToTyping();
    subscribeToSendMessage();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode!.dispose();
    textEditingController.dispose();


    super.dispose();
  }


  Future<void> subscribeToSendMessage() async {

    var chatRepo = context.read<ChatRepository>();
    const graphQLDocument = '''
      subscription sendMessage {
  newMessage {
    createdOn
    id
    image
    messageType
    read
    receiverId
    senderId
    text
  }
      }
    ''';

    sendMessageStream = Amplify.API.subscribe(
      GraphQLRequest<String>(
        document: graphQLDocument,
        apiName: "cdk-rust-social-api_AMAZON_COGNITO_USER_POOLS",
      ),
      onEstablished: () => print('Subscription established'),
    );

    try {
      await for (var event in sendMessageStream) {
        Message chatItemModel =  Message.fromJson(json.decode(event.data!));

        if (kDebugMode) {
          print("event message data is ${chatItemModel.text}");
        }
        if (chatRepo.chatMessagesList.isNotEmpty) {
          if (chatRepo.chatMessagesList[0].id != chatItemModel.id) {

              chatRepo.chatMessage =  chatItemModel;


          }
        } else {
          chatRepo.chatMessage = chatItemModel;

        }
        if (kDebugMode) {
        //  print("all list messages are $chatMessagesList");
          print('Subscription event data received: ${event.data}');
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error in subscription stream: $e');
      }
    }
  }

  Future<void> subscribeToTyping() async {
    const graphQLDocument = '''
      subscription typingIndicator {
        typingIndicator {
    groupId
    typing
    userId
  }
      }
    ''';

    operation = Amplify.API.subscribe(
      GraphQLRequest<String>(
        document: graphQLDocument,
        apiName: "cdk-rust-social-api_AMAZON_COGNITO_USER_POOLS",
      ),
      onEstablished: () => print('Subscription established'),
    );

    try {
      await for (var event in operation) {
        Map value = json.decode(event.data!);

        if (value['typingIndicator']['userId'] == widget.userId) {
        } else {
          setState(() {
            _isSomeoneTyping = value['typingIndicator']['typing'];
          });
        }

        // print("map is ${map["typingIndicator"]}");
        if (kDebugMode) {
          print('Subscription event data received: ${event.data}');
        }
      }
    } on Exception catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
   User? userDetails = context.watch<User?>();
    var chatRepo = context.watch<ChatRepository>();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body:  Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(left: 10, top: 10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              const Color(0xFFfa709a),
                              Theme.of(context).primaryColor
                              // Color(0XFFfee140)
                            ],
                          ),
                          shape: BoxShape.circle),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              const Color(0xFFfa709a),
                              Theme.of(context).primaryColor
                              // Color(0XFFfee140)
                            ],
                          ),
                          shape: BoxShape.rectangle),
                      child: const Text("Splash waterfalls"),
                    ),
                  ],
                ),
              ),
            ),

            Flexible(
              child: ListView.builder(
                  itemCount: chatRepo.chatMessagesList.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return widget.userId == chatRepo.chatMessagesList[index].senderId
                        ? RightChatScreen(message: chatRepo.chatMessagesList[index].text!)

                        : LeftChatScreen(
                      message: chatRepo.chatMessagesList[index],
                      user:userDetails

                    );


                  }),
            ),

            Align(
              alignment: Alignment.bottomLeft,
              child: TypingIndicatorWidget(
                showIndicator: _isSomeoneTyping,
              ),
            ),

            // Sticker

            // Input content
            buildInput(userDetails,chatRepo,widget.userId),
          ],
        ));
  }

  Widget buildInput(User? user, ChatRepository chatRepo, String userId) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              isLoading
                  ? Container(
                      height: 20.0,
                      width: 20.0,
                      margin: EdgeInsets.only(right: 20.0),
                      child: CircularProgressIndicator())
                  : Container()
            ],
          ),
          Row(
            children: <Widget>[
              // Button send image

              // Edit text
              Flexible(
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),
                  //  padding: EdgeInsets.symmetric(vertical: 10.0),

                  child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          maxLines: null,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            labelText: "Say Something ....",
                            contentPadding: new EdgeInsets.all(18.0),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            floatingLabelStyle:
                                const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2.0, color: Colors.white),
                                borderRadius: BorderRadius.circular(100)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: (Colors.grey.withOpacity(0.2)),
                                    width: 2),
                                borderRadius: BorderRadius.circular(300)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onChanged: (String text) {
                            if (text.trim().isNotEmpty) {
                              chatRepo.typingIndicator(
                                  widget.userId, user!.id, true);
                            } else {
                              chatRepo.typingIndicator(
                                  widget.userId, user!.id, false);
                            }
                          },
                          focusNode: myFocusNode,
                          style: const TextStyle(color: Colors.black, fontSize: 15.0),
                          controller: textEditingController,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Button send message
              Container(
                margin: new EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        const Color(0xFFfa709a),
                        Theme.of(context).primaryColor
                        // Color(0XFFfee140)
                      ],
                    ),
                    shape: BoxShape.circle),
                child: Center(
                  child: IconButton(
                      icon: new Icon(Icons.arrow_forward),
                      onPressed: () {
                        chatRepo.sendMessage(
                            userId, textEditingController.text, user!.id,false, null,'TEXT');
                        textEditingController.clear();
                        chatRepo.typingIndicator(
                            widget.userId, user.id, false);

                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
