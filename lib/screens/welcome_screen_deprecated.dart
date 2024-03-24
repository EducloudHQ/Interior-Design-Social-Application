import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

import '../repositories/login_respository.dart';
import '../utils/rounded_diagonal_path_clipper.dart';
import '../utils/shared_preferences.dart';
import '../utils/validations.dart';


class WelcomeScreenDeprecated extends StatefulWidget {


  @override
  State<WelcomeScreenDeprecated> createState() => _WelcomeScreenDeprecatedState();
}

class _WelcomeScreenDeprecatedState extends State<WelcomeScreenDeprecated> {


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var sharedPrefs = context.watch<SharedPrefsUtils>();
    var loginRepo= context.watch<LoginRepository>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
     key: _scaffoldKey,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [


          Container(
            height: size.height,
            width: size.width,
            color: Colors.orange,
          ),

         Align(
           alignment: Alignment.topCenter,
           child:  Container(
             height: size.height/1.35,
             padding:EdgeInsets.only(left: 20,right: 20,top: 40),
             child:RotatedBox(
               quarterTurns: 2,
               child:  ClipShadowPath(
                 shadow: const Shadow(blurRadius: 20.0, color: Colors.black54),
                 clipper: RoundedDiagonalPathClipper(),
                 child: Container(color: Colors.white),
               ),
             ),
           ),

         ),
          Container(
            height: size.height/4,
            padding:EdgeInsets.only(left: 20,right: 20,bottom: 20),
            child:RotatedBox(
              quarterTurns: 4,
              child:  ClipShadowPath(
                shadow: const Shadow(blurRadius: 20.0, color: Colors.black54),
                clipper: RoundedDiagonalPathClipper(),
                child: Container(color: Colors.white),
              ),
            ),
          ),

          Positioned(
            top: size.height/4,
            child: Container(
              width: size.width/1.3,
              child:  Form(
                key: loginRepo.formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: loginRepo.emailController,
                        style: const TextStyle(color: Colors.orange),
                        onChanged: (String value) {
                          String? response =
                          Validations.validateEmail(context, value);
                          if (response == null) {
                            loginRepo.isValidEmail = true;
                          } else {
                            loginRepo.isValidEmail = false;
                          }
                        },
                        decoration: InputDecoration(
                          filled: false,
                          suffixIcon: loginRepo.isValidEmail
                              ? const Icon(
                            Icons.check_circle,
                            color: Colors.orange,
                          )
                              : const Icon(
                            Icons.check_circle,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.orange, width: 1),

                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.orange),

                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.orange,
                                ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.orange, width: 1),

                          ),

                          labelText: 'Email Address',
                          labelStyle: TextStyle(color: Colors.orange),
                          hintText: "Email Address",
                          hintStyle: const TextStyle(
                            color: Colors.orange,

                          ),
                        ),
                        validator: (value) =>
                            Validations.validateEmail(context, value!),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(

                        style: const TextStyle(color: Colors.orange),
                        validator: (value) {
                          if (value!.length < 3) {
                            return "Password has to be atleast 4 characters";
                          } else {
                            return null;
                          }
                        },
                        controller: loginRepo.passwordController,
                        obscureText: loginRepo.obscureText,
                        onChanged: (String value) {
                          String? response =
                          Validations.validateEmail(context, value);
                          if (response == null) {
                            loginRepo.isValidEmail = true;
                          } else {
                            loginRepo.isValidEmail = false;
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            color: Colors.white,
                            icon: Icon(
                              loginRepo.obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              loginRepo.obscureText =
                              !loginRepo.obscureText;
                            },
                          ),
                          filled: false,

                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.orange,),

                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.orange),

                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                            ),

                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.orange),

                          ),

                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.orange),
                          hintText: "Password",
                          hintStyle: const TextStyle(
                            color: Colors.orange,

                          ),
                        ),

                      ),
                    ),

                  ],
                ),
              ),

            ),),
          Positioned(
            top: size.height/1.9,
            right: size.width/1.7,

            child: const Text('forgot password ?',style: TextStyle(fontSize: 12,

                color: Colors.grey,fontWeight: FontWeight.bold),),),
          Positioned(
              top: size.height/1.8,
              left: size.width/2.7,
              child: Container(
                width: size.width/2,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    backgroundColor: MaterialStateProperty.all(Colors.orange)
                  ),
                  onPressed: () {  },
                            child: Text("Log In",style: TextStyle(fontSize: 15,color: Colors.white),),

                          ),
              )),
          Positioned(
            top: size.height/1.5,
              right: size.width/1.4,
              child: Container(
            height: 50,
            width: 50,
            padding: EdgeInsets.all(10),
                decoration:  BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.white)
                ),

            child: SvgPicture.asset('assets/google.svg',height: 24,width: 24,color: Colors.white,),
          )),
          Positioned(
              top: size.height/1.4,
              right: size.width/2.2,
              child: Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(10),
                decoration:  BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.white)
                ),

                child: SvgPicture.asset('assets/apple.svg',height: 24,width: 24,color: Colors.white,),
              )),
          Positioned(
              top: size.height/1.32,
              right: size.width/5,
              child: Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(10),
                decoration:  BoxDecoration(
                  shape: BoxShape.rectangle,
                 border: Border.all(color: Colors.white)
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
