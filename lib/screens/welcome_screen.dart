import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/models/grid_images.dart';
import 'package:social_media/repositories/login_respository.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../models/User.dart';
import '../repositories/profile_repository.dart';
import 'package:go_router/go_router.dart';

import '../utils/gradient_text.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LoginRepository loginRepo = context.watch<LoginRepository>();
    ProfileRepository profileRepo = context.watch<ProfileRepository>();
    return Scaffold(

      body:Stack(

        children: [


          MasonryGridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 7,
            crossAxisSpacing: 7,
            itemCount: gridImages.length,

            itemBuilder: (context, index) {
              return Image.asset(gridImages[index].imageAsset,fit: BoxFit.cover,);
            },
          ),


        Padding(
          padding: EdgeInsets.only(bottom: size.height/4),
          child: const Align(
            alignment: Alignment.bottomCenter,
              child: GradientText(
                'INTERIOR.AI',
                style: TextStyle(fontSize: 30,fontFamily: 'BungeeShade-Regular',
                    fontWeight: FontWeight.bold),
                gradient: LinearGradient(colors: [
                  Color(0xFFFBDA61),
                  Color(0xFFFF5ACD),
                ]),
              ),
            ),
        ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: loginRepo.googleLoading ? CircularProgressIndicator() :
                    InkWell(
                      onTap: () {
                        loginRepo.googleSignIn(context).then((User? user) {
                          if(user != null){

                            print("user found, move to homescreen");
                            //find out if user is old or new

                            context.pushReplacement('/');
                          }else{
                            print("user not found, create new user");
                            context.pushReplacement('/createUserAccount');
                          }
                        });
                      },
                      child: Container(
                              width: size.width / 1.2,
                              height: size.height / 14,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(50),
                                  gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment(0.8, 1),
                                      colors: [
                                        Color(0xFFFBDA61),
                                        Color(0xFFFF5ACD),
                                      ])),
                              child: const Text(
                                "Log In with Google",
                                style: TextStyle(fontSize: 20),
                              )),
                    ),


                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: size.height/12,
                      width: size.width/1.2,
                      child: TextButton.icon(
                        style: const ButtonStyle(

                        ),
                        onPressed: (){

                        },
                        icon: const Icon(Icons.account_circle_rounded,color:   Color(0xFFFF5ACD),),
                        label: const Text("Create an account",style: TextStyle(color:  Color(0xFFFBDA61),fontSize: 17),),
                      ),
                    ),
                  ),
                ),


        ],
      )
    );
  }
}
