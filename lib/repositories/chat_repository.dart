
import 'package:flutter/cupertino.dart';

import '../models/Message.dart';
import 'dart:convert';
import 'dart:ui';

import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:flutter/foundation.dart';

import 'dart:async';


import 'package:flutter/material.dart';



class ChatRepository extends ChangeNotifier {
  ChatRepository.instance();

  List<Message> _chatMessagesList = [];

  List<Message> get chatMessagesList => _chatMessagesList;

  set chatMessagesList(List<Message> value) {
    _chatMessagesList = value;
    notifyListeners();
  }

  set chatMessage(Message value) {

    _chatMessagesList.insert(0, value);
    notifyListeners();
  }

  Future<bool> sendMessage(
      String senderId, String messageText, String receiverId,bool read, String? image,String messageType) async {
    try {
      String graphQLDocument = '''
     mutation sendMessage(\$messageType:String!, \$senderId:String!,\$receiverId:String!,
     \$read:Boolean!,\$image:String,\$text:String) {
  sendMessage(
    input: {
      messageType:\$messageType
      senderId: \$senderId
      receiverId:\$receiverId
      read: \$read
      image: \$image
      text: \$text
    }
  ) {
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

      var operation = Amplify.API.mutate(
          request: GraphQLRequest<String>(
            document: graphQLDocument,
            apiName: "cdk-rust-social-api_AMAZON_COGNITO_USER_POOLS",
            variables: {
              "messageType": messageType,
              "senderId": senderId,
              "receiverId": receiverId,
              "read": read,
              "image": image,
              "text": messageText
            },
          ));

      var response = await operation.response;

      var data = response.data;
      if (response.data != null) {
        Map value = json.decode(response.data!);
        if (kDebugMode) {
          print('Mutation result is${data!}');
        }
        return true;
      } else {
        if (kDebugMode) {
          print('Mutation error: ${response.errors}');
        }

        return false;
      }
    } catch (ex) {
      return false;
    }
  }

  Future<bool> typingIndicator(
      String senderId, String receiverId, bool typing) async {
    try {
      String graphQLDocument = '''
      mutation create(
            \$senderId: String!
            \$receiverId: String!
    
            
            \$typing:Boolean!
           ) {
  typingIndicator(

 senderId: \$senderId, 

  receiverId: \$receiver, typing: \$typing) {
  typing
  senderId
  receiverId
  }
}
      ''';

      var operation = Amplify.API.mutate(
          request: GraphQLRequest<String>(
            document: graphQLDocument,
            apiName: "cdk-rust-social-api_AMAZON_COGNITO_USER_POOLS",
            variables: {
              "typing": typing,
              "senderId": senderId,
              "receiverId": receiverId,
            },
          ));

      var response = await operation.response;

      var data = response.data;
      if (response.data != null) {
        if (kDebugMode) {
          print('Mutation result is${data!}');
        }
        return true;
      } else {
        if (kDebugMode) {
          print('Mutation error: ${response.errors}');
        }

        return false;
      }
    } catch (ex) {
      return false;
    }
  }

}