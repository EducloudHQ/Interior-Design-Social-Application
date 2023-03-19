import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

import '../repositories/login_respository.dart';
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
      backgroundColor: const Color(0xFF264653),
      body: Column(

        children: [
          Expanded(
            child: Container(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/todo.svg',height: 50,width: 50,color: Color(0xFFe76f51),),
                  const Text("Todoish",style: TextStyle(fontFamily: 'Ultra-Regular',
                    fontSize: 40,color: Color(0xFFe76f51),),),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 50),
            child: SizedBox(
              width: size.width/1.4,
              height:50,

              child: ElevatedButton(

                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))

                  ),
                   onPressed: ()=> loginRepo.googleSignIn(context),
                  /*
                  onPressed: (){
                    loginRepo.signOutCurrentUser();
                    sharedPrefs.deleteAllKeys();
                  },

                   */



                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset('assets/google.svg',height: 24,width: 24,color: Colors.white),
                      const Text('Continue with Google',style: TextStyle(fontWeight:FontWeight.bold, color: Colors.white),),
                    ],
                  )),
            ),
          )

        ],
      ),
    );



  }
}
