import 'package:flutter/material.dart';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:todoish/repositories/login_respository.dart';
import 'package:todoish/repositories/task_respository.dart';
import 'package:todoish/screens/welcome_screen.dart';
import 'package:todoish/utils/shared_preferences.dart';
import 'package:todoish/screens/home_screen.dart';


import 'amplifyconfiguration.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'models/ModelProvider.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
      ChangeNotifierProvider(
        create: (_) =>
            LoginRepository.instance(),
        child: const MyApp(),
      ),

      );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<void> _configureAmplify() async {
    var loginRepo = context.read<LoginRepository>();
    try{


      await Amplify.addPlugins([
        AmplifyDataStore(modelProvider: ModelProvider.instance),
        AmplifyAuthCognito(),
        AmplifyAPI(),
        AmplifyStorageS3()
      ]);

      // Once Plugins are added, configure Amplify
      await Amplify.configure(amplifyconfig);
      if(Amplify.isConfigured){
        print('amplify configure');
       // changeSync();
        loginRepo.loadingAmplify = false;
      }else{
        print('amplify not configure');
        loginRepo.loadingAmplify = true;
      }


    } catch(e) {
      loginRepo.loadingAmplify = true;
      print('an error occured during amplify configuration: $e');



    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configureAmplify();

  }

  Future<void> changeSync() async {

    try {
      await Amplify.DataStore.clear();
    } on Exception catch (error) {
      print('Error clearing DataStore: $error');
    }

    try {
      await Amplify.DataStore.start();
    } on Exception catch (error) {
      print('Error starting DataStore: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    var loginRepo = context.watch<LoginRepository>();
    return MaterialApp(
      title: 'Todoish',

      theme: ThemeData(
      fontFamily: 'Montserrat',
       primaryColor: Color(0xFF264653),
          colorScheme:ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFe76f51))




      ),

     home: loginRepo.loadingAmplify ? const Center(child: CircularProgressIndicator(),) :
     MultiProvider(
       providers: [
         ChangeNotifierProvider(create: (BuildContext context) => SharedPrefsUtils.instance(),),
         ChangeNotifierProvider(create: (BuildContext context) => LoginRepository.instance(),),
         ChangeNotifierProvider(create: (BuildContext context) => TaskRepository.instance(),

         ),
       ],
       child: HomeScreen(),
     // child: WelcomeScreen(),
     ),



    );
  }
}

