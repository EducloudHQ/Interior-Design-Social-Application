import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoish/screens/create_task_screen.dart';
import 'package:todoish/screens/task_item.dart';
import 'package:todoish/screens/welcome_screen.dart';
import 'package:todoish/utils/shared_preferences.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../models/ModelProvider.dart';
import '../models/Task.dart';
import '../repositories/task_respository.dart';
import 'package:todoish/repositories/task_respository.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userId;
  int count = 0;
  Future<void> signOutCurrentUser() async {
    try {
      await Amplify.Auth.signOut();

    } on AuthException catch (e) {
      print(e.message);
    }
  }


  late StreamSubscription<QuerySnapshot<Task>> tasksStream;

  Future<void> _getAllTasks() async {


       var taskRepo = context.read<TaskRepository>();
       tasksStream = Amplify.DataStore.observeQuery(Task.classType,sortBy: [Task.CREATEDON.descending()]).listen((QuerySnapshot<Task> event) {

         if(taskRepo.tasks.isNotEmpty) {
           if (taskRepo.tasks[0].id != event.items[0].id) {
             taskRepo.setTask = event.items[0];
           }
         }else{
           taskRepo.setTasks = event.items;

           if (kDebugMode) {
             print('Received post ${event.items}');
           }
         }
       });





  }



  @override
  void initState() {
    // TODO: implement initState
    _getAllTasks();

    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tasksStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var taskRepo = context.watch<TaskRepository>();
    var sharedPrefs = context.watch<SharedPrefsUtils>();


    return FutureProvider<String?>(
      create: (BuildContext context) {
        return sharedPrefs.getUserEmail();
      },
      initialData: null,
      child: Consumer<String?>(builder: (_, String? email, child) {
        return email == null
            ? WelcomeScreen()
            : Scaffold(

          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                appBar: AppBar(
                  title: const Text('Todoish'),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  actions: [
                    IconButton(onPressed: (){
                      signOutCurrentUser();
                      sharedPrefs.deleteAllKeys();

                    }, icon: Icon(Icons.logout_outlined))
                  ],
                ),
                body:

                taskRepo.tasks.isEmpty ? const Center(child: Text("No Tasks available")) :
                  ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskItem(taskRepo.tasks[index]);
                  },
                  itemCount:taskRepo.tasks.length,
                ),



                floatingActionButton: FloatingActionButton(

                  onPressed: () {
                    Navigator.push(
                        context,
                        (MaterialPageRoute(builder: (BuildContext context) {
                          return CreateTaskScreen(email: email);
                        })));
                  },
                  child: const Icon(Icons.add),
                ),
              );
      }),
    );
  }
}
