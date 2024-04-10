import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:social_media/models/ModelProvider.dart';
import 'package:social_media/repositories/login_respository.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/repositories/profile_repository.dart';
import 'package:social_media/screens/post_item.dart';
import 'package:social_media/screens/profile_screen.dart';
import 'package:social_media/screens/shimmer_post_item.dart';
import 'package:social_media/screens/welcome_screen.dart';
import 'package:social_media/utils/shared_preferences.dart';
import '../repositories/post_respository.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/FABBottomAppBarItem.dart';
import '../utils/gradient_text.dart';
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
  Future<void> subscribeToPosts(PostRepository postRepo) async {

    String graphQLDocument = '''
  subscription createdPost {
  createdPost {
    content
    createdOn
    id
    imageKeys
    imageUrls
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
      profilePicKey
      updatedOn
      username
      userType
    }
    comments {
      comment
      createdOn
      id
      postId
      updatedOn
      userId
    }
  }
}

''';

    getPostStream = Amplify.API.subscribe(
         GraphQLRequest<String>(
          document: graphQLDocument,
          apiName: "cdk-rust-social-api_AMAZON_COGNITO_USER_POOLS",

        ),
      onEstablished: () => print('Subscription established'),
    );



    try {
      await for (var event in getPostStream) {
        print("post stream $event");
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
    var postRepo = context.read<PostRepository>();

    Future.delayed(Duration.zero).then((_) async {
      subscribeToPosts(postRepo);
      postRepo.getAllPosts(10);
    });



  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    var sharedPrefs = context.watch<SharedPrefsUtils>();
    var postRepo = context.watch<PostRepository>();

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

                    },
                    child: const GradientText(
                      'INTERIOR.AI',
                      style: TextStyle(fontSize: 20,fontFamily: 'BungeeShade-Regular',
                          fontWeight: FontWeight.bold),
                      gradient: LinearGradient(colors: [
                        Color(0xFFFBDA61),
                        Color(0xFFFF5ACD),
                      ]),
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
                body: _selectedTabIndex == 3 ?
                ChangeNotifierProvider(create: (context) => ProfileRepository.instance(),
                child: ProfileScreen(email: email,),) :

                postRepo.postList.isEmpty ? Container(

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
                ) :
                ListView.builder(itemBuilder: (context,index){
                  return PostItem(postRepo.postList[index]);
                },itemCount: postRepo.postList.length,),



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
