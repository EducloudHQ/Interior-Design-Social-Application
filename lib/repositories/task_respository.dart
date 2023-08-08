import 'dart:io';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import '../models/Task.dart';
import '../models/User.dart';


class TaskRepository extends ChangeNotifier{

  TaskRepository.instance();

  bool _loading = false;


  bool get loading => _loading;

  List<Task> _tasks = [];
  final List<TextEditingController> _controllers = [];
   final TextEditingController _controller = TextEditingController();
  final List<TextField> _fields = [];
final TextField _field = TextField();


  List<TextField> get fields => _fields;


  TextEditingController get controller => _controller;

  set controller(TextEditingController value) {
    _controllers.add(value);
    notifyListeners();
  }
  TextField get field => _field;

  set field(TextField value) {
    _fields.add(_field);
    notifyListeners();

  }


  List<TextEditingController> get controllers => _controllers;

  set controllers(List<TextEditingController> value) {
    _controllers.addAll(value);
    notifyListeners();
  }

  List<Task> get tasks => _tasks;

  set setTasks(List<Task> value) {

    _tasks = value;
    notifyListeners();
  }

  set setTask(Task value) {

    _tasks.insert(0, value);
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  Future<bool> createTask(String email) async{
    loading = true;
    /**
     * first retrieve user model
     */
    try {
      List<User> user = await Amplify.DataStore.query(
          User.classType, where: User.EMAIL.eq(email));
      if (kDebugMode) {
        print("user details${user[0]}");
      }
      Task task = Task(userId:email,isComplete: false, title: taskTitleController.text.trim(),
      description: taskDescriptionController.text.trim(),createdOn: TemporalTimestamp.now());
      await Amplify.DataStore.save(task);
      loading = false;
      return true;
    }catch(ex){
      if (kDebugMode) {
        print(ex.toString());
      }
      loading = false;
      return false;
    }
  }
  Future<List<Task>>queryTasks() async{
    List<Task> tasks = await Amplify.DataStore.query(Task.classType);

    return tasks;
  }

 Future<List<Task>>queryAllTasks() async{

      List<Task> tasks = await Amplify.DataStore.query(Task.classType,sortBy: [Task.CREATEDON.descending()]);

        print("tasks is $tasks");

      setTasks = tasks;

      return tasks;




  }

  Future<List<Task>>paginateTasks(int page) async{
    List<Task> tasks = await Amplify.DataStore.query(Task.classType,sortBy: [Task.CREATEDON.descending()],
                 pagination: QueryPagination(page:page, limit:100));
    return tasks;
  }
  Future<List<Task>>getSingleTasks(String taskID) async{
    List<Task> tasks = await Amplify.DataStore.query(Task.classType,where: Task.ID.eq(taskID));
    return tasks;
  }
  Future<List<Task>>queryAllUserTasks(String userId) async{
    List<Task> tasks = await Amplify.DataStore.query(Task.classType,
        where: Task.USERID.eq(userId),
        sortBy: [Task.CREATEDON.descending()]);
    return tasks;
  }
  void showInSnackBar(BuildContext context,String value) {
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle( fontSize: 20.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ));
  }



  Future<void> updateTask(String taskId) async{
    Task oldTask = (await Amplify.DataStore.query(Task.classType,
        where: Task.ID.eq(taskId)))[0];
    Task newTask = oldTask.copyWith(id: oldTask.id,
        createdOn: TemporalTimestamp.now(),
        );

    await Amplify.DataStore.save(newTask);
  }


  Future<User> retrieveUser(String userId) async{
    User user = (await Amplify.DataStore.query(User.classType, where: User.ID.eq(userId)))[0];
    return user;

  }



  @override
  void dispose() {
    // TODO: implement dispose
    for (final controller in _controllers) {
      controller.dispose();
    }
    taskTitleController.dispose();
    taskDescriptionController.dispose();
    super.dispose();


  }


}