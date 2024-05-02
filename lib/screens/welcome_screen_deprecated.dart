import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../repositories/login_respository.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../models/User.dart';
import '../repositories/profile_repository.dart';


class WelcomeScreenDeprecated extends StatefulWidget {


  @override
  State<WelcomeScreenDeprecated> createState() => _WelcomeScreenDeprecatedState();
}

class _WelcomeScreenDeprecatedState extends State<WelcomeScreenDeprecated> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LoginRepository loginRepo = context.watch<LoginRepository>();
    ProfileRepository profileRepo = context.watch<ProfileRepository>();
    return Scaffold(

      body: Stack(

        children: [
          Container(
            height: size.height,
            width: size.width,
          ),

          Positioned(
              top: size.height/3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset("assets/avatars/Image.jpg",width: 40,height: 40,fit: BoxFit.cover,),
              )),
          Positioned(
              top: size.height/2,
              left: size.width/4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset("assets/avatars/Image-1.jpg",width: 90,height: 90,fit: BoxFit.cover,),
              )),
          Positioned(
              top: size.height/2.5,
              left: size.width/2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset("assets/avatars/Image-71.jpg",width: 70,height: 70,fit: BoxFit.cover,),
              )),
          Positioned(
              top: size.height/2.5,
              left: size.width/8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset("assets/avatars/Image-61.jpg",width: 70,height: 70,fit: BoxFit.cover,),
              )),
          Positioned(
              top: size.height/4.2,
              left: size.width/3.7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset("assets/avatars/Image-6.jpg",width: 120,height: 120,fit: BoxFit.cover,),
              )),
          Positioned(
              top: size.height/3.7,
              left: size.width/1.4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset("assets/avatars/Image-8.jpg",width: 70,height: 70,fit: BoxFit.cover,),
              )),
          Positioned(
              top: size.height/10,
              left: size.width/2.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset("assets/avatars/Image-7.jpg",width: 70,height: 70,fit: BoxFit.cover,),
              )),


          Positioned(
              top: size.height/7,
              left: size.width/8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset("assets/avatars/Image-3.jpg",width: 50,height: 50,fit: BoxFit.cover,),
              )),

          Positioned(
              top: size.height/6,
              right: size.width/6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset("assets/avatars/Image-4.jpg",width: 70,height: 70,fit: BoxFit.cover,),
              )),
          Positioned(
              top: size.height/2.3,
              right: size.width/20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset("assets/avatars/Image-9.jpg",width: 50,height: 50,fit: BoxFit.cover,),
              )),
          Positioned(
              top: size.height/1.9,
              right: size.width/8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset("assets/avatars/Image-10.jpg",width: 50,height: 50,fit: BoxFit.cover,),
              )),

          Positioned(
              top: size.height/1.5,
              right: size.width/2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset("assets/avatars/Image-31.jpg",width: 100,height: 100,fit: BoxFit.cover,),
              )),
          Positioned(
              top: size.height/1.6,
              right: size.width/1.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset("assets/avatars/Image-41.jpg",width: 50,height: 50,fit: BoxFit.cover,),
              )),
          Positioned(
              top: size.height/1.6,
              right: size.width/5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset("assets/avatars/Image-51.jpg",width: 70,height: 70,fit: BoxFit.cover,),
              )),

          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: loginRepo.googleLoading ? CircularProgressIndicator() : SizedBox(
                height: size.height/18,
                width: size.width/1.2,
                child: ElevatedButton(

                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                      backgroundColor: MaterialStateProperty.all(Colors.red)
                  ),
                  onPressed: () {
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

                  child: const Text("Login with Google",style: TextStyle(fontSize: 15,color: Colors.white,
                  ),),
                ),
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
                  icon: const Icon(Icons.account_circle_rounded,),
                  label: const Text("Create an account",),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
