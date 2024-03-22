import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

import '../repositories/login_respository.dart';
import '../utils/rounded_diagonal_path_clipper.dart';
import '../utils/shared_preferences.dart';


class WelcomeScreen extends StatefulWidget {


  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var sharedPrefs = context.watch<SharedPrefsUtils>();
    var loginRepo= context.watch<LoginRepository>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: size.height,
            width: size.width,
          ),

         Align(
           alignment: Alignment.topCenter,
           child:  Container(
             height: size.height/1.2,
             padding:EdgeInsets.only(left: 20,right: 20,top: 40),
             child:RotatedBox(
               quarterTurns: 2,
               child:  ClipShadowPath(
                 shadow: const Shadow(blurRadius: 20.0, color: Colors.black54),
                 clipper: RoundedDiagonalPathClipper(),
                 child: Container(color: Colors.orange),
               ),
             ),
           ),

         ),
          Container(
            height: size.height/5,
            padding:EdgeInsets.only(left: 20,right: 20),
            child:RotatedBox(
              quarterTurns: 4,
              child:  ClipShadowPath(
                shadow: const Shadow(blurRadius: 20.0, color: Colors.black54),
                clipper: RoundedDiagonalPathClipper(),
                child: Container(color: Colors.orange),
              ),
            ),
          ),
          Positioned(
            top: size.height/1.35,
              right: size.width/1.4,
              child: Container(
            height: 50,
            width: 50,
            padding: EdgeInsets.all(10),
                decoration:  BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.orange)
                ),

            child: SvgPicture.asset('assets/google.svg',height: 24,width: 24,color: Colors.white,),
          )),
          Positioned(
              top: size.height/1.27,
              right: size.width/2.2,
              child: Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(10),
                decoration:  BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.orange)
                ),

                child: SvgPicture.asset('assets/apple.svg',height: 24,width: 24,color: Colors.white,),
              )),
          Positioned(
              top: size.height/1.21,
              right: size.width/5,
              child: Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(10),
                decoration:  BoxDecoration(
                  shape: BoxShape.rectangle,
                 border: Border.all(color: Colors.orange)
                ),

                child: SvgPicture.asset('assets/facebook.svg',height: 24,width: 24,color: Colors.white,),
              )),
          Positioned(
              top: size.height/1.17,
              right: size.width/1.2,
              child: Container(
                height: 30,
                width: 30,



                child: SvgPicture.asset('assets/up.svg',height: 24,width: 24,color: Colors.white,),
              )),

          Positioned(
            top: size.height/1.06,
            right: size.width/2.8,

            child: const Text('Terms and Conditions',style: TextStyle(fontSize: 12,

                color: Colors.black,fontWeight: FontWeight.bold),),)

        ],
      )
          /*
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10,bottom: 10),

                width: size.width/1.2,
                height: size.height/18,


                child: ElevatedButton(

                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))

                  ),
                  onPressed: ()=> loginRepo.googleSignIn(context),


                  child:const Text('Sign up with email',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 17, color: Colors.white),),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      
                      width: size.width/6,
                      height: 2,
                    ),
                    Container(
                      child: Text('or use social sign up',style: TextStyle(fontSize: 15,color: Colors.white),),
                    ),
                    Container(
                      
                      width: size.width/6,
                      height: 2,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),

                width: size.width/1.2,
                height: size.height/18,

                child: ElevatedButton(

                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))

                    ),
                    onPressed: ()=> loginRepo.googleSignIn(context),


                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset('assets/google.svg',height: 24,width: 24,color: Colors.red,),
                        const Text('Continue with Google',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15, color: Colors.black),),
                      ],
                    )),
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account ?',style: TextStyle(fontWeight: FontWeight.bold),),
                    TextButton(

                        onPressed: (){}, child: Text('Log In',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),))
                  ],
                ),
              )
            ],
          ),
          */




    );



  }
}
