import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/repositories/login_respository.dart';
import 'package:social_media/screens/welcome_screen.dart';
import 'package:social_media/utils/shared_preferences.dart';
import '../repositories/post_respository.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

/*
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
*/


  @override
  void initState() {
    // TODO: implement initState
   // _getAllTasks();

    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  //  tasksStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var taskRepo = context.watch<PostRepository>();
    var sharedPrefs = context.watch<SharedPrefsUtils>();


    return FutureProvider<String?>(
      create: (BuildContext context) {
        return sharedPrefs.getUserEmail();
      },
      initialData: null,
      child: Consumer<String?>(builder: (_, String? email, child) {
        return email == null
            ? ChangeNotifierProvider(create: (context) => LoginRepository.instance(),
        child:  WelcomeScreen(),)
            : Scaffold(

          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 1),
                          colors: [
                            Color(0xFFFBDA61),
                            Color(0xFFFF5ACD),

                          ]

                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child:  CachedNetworkImage(
                          width: 80,
                          height: 80,
                          imageUrl:" profileModel.profilePicUrl",
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: Image.asset("assets/avatars/Image-71.jpg",width: 60,height: 60,fit: BoxFit.cover,),
                          ),
                        ),

                      ),
                      Container(

                        child: Text(" Rosius Ndimofor" ,
                          style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      ),
                      Expanded(
                        child: Container(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: const Row(
                                  children: [
                                    Text('170',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                    Text(' '),
                                    Text('Followers',style: TextStyle(fontSize: 12),)
                                  ],
                                ),
                              ),
                              Container(
                                child: const Row(
                                  children: [
                                    Text('6',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                    Text(' '),
                                    Text('Followings',style: TextStyle(fontSize: 12))
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
                appBar:

                AppBar(

                  title: InkWell(
                    onTap: (){
                      context.push('/profile/$email');
                    },
                    child: ClipRRect(

                      borderRadius: BorderRadius.circular(1000),
                      child:  CachedNetworkImage(
                        width: 40,
                        height: 40,
                        imageUrl:" profileModel.profilePicUrl",
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.asset("assets/avatars/Image-71.jpg",fit: BoxFit.cover,
                          width: 40,height: 40,),

                      ),

                    ),
                  ),
                  centerTitle: true,

                  actions: [
                    IconButton(onPressed: (){
                      signOutCurrentUser();
                      sharedPrefs.deleteAllKeys();

                    }, icon: Icon(Icons.logout_outlined))
                  ],
                ),
                body:Center(child: Text("No Tasks available")),
/*
                taskRepo.tasks.isEmpty ? const Center(child: Text("No Tasks available")) :


                  ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskItem(taskRepo.tasks[index]);
                  },
                  itemCount:taskRepo.tasks.length,
                ),
*/


                floatingActionButton: FloatingActionButton(

                  onPressed: () {
                   context.push('/post/$email');
                  },
                  child: const Icon(Icons.add),
                ),
              );
      }),
    );
  }
}
