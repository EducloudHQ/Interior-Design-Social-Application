import 'dart:async';

import 'package:amplify_datastore/amplify_datastore.dart';

import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../models/Comment.dart';
import '../models/Task.dart';


import 'package:amplify_core/amplify_core.dart';

import 'package:flutter/foundation.dart';

class CommentsRepository extends ChangeNotifier {

  CommentsRepository.instance();



  final commentController = TextEditingController();



  S3UploadFileOptions? options;
  bool _loading = false;
  String? _userId;
  List<Comment> _comments = [];

  late StreamSubscription commentsStream;
  List<Comment> get comments => _comments;

  set comments(List<Comment> value) {
    _comments = value;
    notifyListeners();
  }

  set comment(Comment value) {
    _comments.insert(0, value);
    notifyListeners();

  }

  String? get userId => _userId;

  set userId(String? value) {
    _userId = value;
    notifyListeners();
  }

  String _profilePic = "";
  String _profilePicKey ="";


  String get profilePicKey => _profilePicKey;

  set profilePicKey(String value) {
    _profilePicKey = value;
    notifyListeners();
  }


  String get profilePic => _profilePic;

  set profilePic(String value) {
    _profilePic = value;
    notifyListeners();
  }



  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }



  void showInSnackBar(BuildContext context,String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:  Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ));
  }



  @override
  void dispose() {
    // TODO: implement dispose

    commentController.dispose();
    commentsStream.cancel();



    super.dispose();
  }

  Future<List<Comment>>queryAllCommentsForTask(String taskId) async{
    List<Comment> comments= await Amplify.DataStore.query(Comment.classType,
        where: Comment.TASKID.eq(taskId),
        sortBy: [Comment.CREATEDON.descending()]);

    if (kDebugMode) {
      print("comments are $comments");
    }
    return comments;
  }

  Future<bool> createComment(String userId,Task task) async{
    loading = true;

    try {


      Comment comment = Comment(comment: commentController.text.trim(),userId: userId,
          taskId:task.id,createdOn: TemporalTimestamp.now(), );

      await Amplify.DataStore.save(comment);
      loading = false;
      return true;
    }catch(ex){
      print(ex.toString());
      loading = false;
      return false;
    }
  }



}