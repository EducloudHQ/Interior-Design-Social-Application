import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/models/ModelProvider.dart';
import 'package:social_media/repositories/login_respository.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/screens/post_item.dart';
import 'package:social_media/screens/shimmer_post_item.dart';
import 'package:social_media/screens/welcome_screen.dart';
import 'package:social_media/utils/shared_preferences.dart';
import '../repositories/post_respository.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:shimmer/shimmer.dart';

import '../utils/FABBottomAppBarItem.dart';
import 'drawer_screen.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userId;
  int count = 0;
  late final Stream<GraphQLResponse<String>> getPostStream;
  Future<void> signOutCurrentUser() async {
    try {
      await Amplify.Auth.signOut();

    } on AuthException catch (e) {
      print(e.message);
    }
  }
  Future<void> subscribeToPosts(int limit) async {

    var postRepo = context.read<PostRepository>();
    String graphQLDocument = '''
    query getAllPosts(\$limit:Int!, \$nextToken:String) {
  getAllPosts(limit: \$limit, nextToken: \$nextToken) {
   items {
      content
      createdOn
      id
      imageKeys
      imageUrls
      updatedOn
      userId
      comments {
        comment
        createdOn
        id
        postId
        updatedOn
        userId
        user {
          about
          address {
            city
            country
            street
            zip
          }
          createdOn
          email
          firstName
          id
          lastName
          profilePicUrl
          updatedOn
          userType
          username
        }
      }
      user {
        about
        createdOn
        email
        firstName
        id
        updatedOn
        userType
        username
        profilePicUrl
        lastName
      }
    }
    nextToken
  }
}
''';

    getPostStream = Amplify.API.subscribe(
         GraphQLRequest<String>(
          document: graphQLDocument,
          apiName: "cdk-rust-social-api_AMAZON_COGNITO_USER_POOLS",
          variables: {
            "limit": limit,
            "nextToken":null,

          },
        ),
      onEstablished: () => print('Subscription established'),
    );

    try {
      await for (var event in getPostStream) {
        Post postItem =  Post.fromJson(json.decode(event.data!));

        if (kDebugMode) {
          print("event message data is ${postItem.content}");
        }
        if (postRepo.postList.isNotEmpty) {
          if (postRepo.postList[0].id != postItem.id) {

            postRepo.singlePost =  postItem;


          }
        } else {

          postRepo.singlePost =  postItem;

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

  int _selectedTabIndex = 0;

  void _selectedTab(int index) {

    if(index == 2)
    {

    }
    setState(() {
      _selectedTabIndex = index;


    });
  }

  @override
  void initState() {

    super.initState();

    subscribeToPosts(10);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  //  tasksStream.cancel();
  }

  @override
  Widget build(BuildContext context) {

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


          drawer: DrawerScreen(),
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

                    InkWell(
                      onTap: (){
                        signOutCurrentUser();
                        sharedPrefs.deleteAllKeys();

                      },
                        child: SvgPicture.asset('assets/off.svg',height: 35,width: 35,color: Colors.white,))



                  ],
                ),
                body:FutureProvider<PostsResult?>(create: (context)=>PostRepository.instance().getAllPosts(10),
                initialData: null,
                catchError: (context,error){
                  throw error!;
                },
                child: Consumer(
                  builder: (_,PostsResult? postsResult,child){
                   return

                     postsResult != null ?
                   ListView.builder(itemBuilder: (context,index){
                      return PostItem(postsResult.items[index]);
                   },itemCount: postsResult.items.length,):

                     Container(

                     child: Shimmer.fromColors(
                         baseColor: Colors.grey.shade300,
                         highlightColor: Colors.grey.shade100,
                         enabled: true,
                         child: SingleChildScrollView(
                           physics: NeverScrollableScrollPhysics(),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisSize: MainAxisSize.max,
                             children: [
                               ShimmerPostItem(),
                               ShimmerPostItem(),

                             ],
                           ),
                         )),
                   );
                  },
                ),),

          bottomNavigationBar: FABBottomAppBar(
            centerItemText: '',
            color: Colors.grey,
            selectedColor: Color(0xFFFF5ACD),

            onTabSelected: _selectedTab,



            items: [
              FABBottomAppBarItem(iconName:'assets/home.svg', text: 'home',),
              FABBottomAppBarItem(iconName:'assets/search.svg', text: 'search'),
              FABBottomAppBarItem(iconName:'assets/notification.svg', text: 'notification'),
              FABBottomAppBarItem(iconName:'assets/profile.svg', text: 'profile'),
            ], email: email,
          ),

              );
      }),
    );
  }
}
