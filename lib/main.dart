import 'package:flutter/material.dart';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:social_media/repositories/login_respository.dart';
import 'package:social_media/repositories/profile_repository.dart';
import 'package:social_media/repositories/task_respository.dart';
import 'package:social_media/screens/create_user_account.dart';
import 'package:social_media/screens/home_screen.dart';
import 'package:social_media/screens/welcome_screen.dart';

import 'package:go_router/go_router.dart';
import 'package:social_media/utils/shared_preferences.dart';
import 'amplifyconfiguration.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:provider/provider.dart';

final AmplifyLogger _logger = AmplifyLogger('socialApp');
void main() {
  AmplifyLogger().logLevel = LogLevel.verbose;
  runApp(

      ChangeNotifierProvider(
        create: (_) =>
            LoginRepository.instance(),
        child: MyApp(),
      ),

      );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  static final _router = GoRouter(
    routes: [
    GoRoute(
    path: '/',
    builder: (BuildContext _, GoRouterState __) =>
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (BuildContext context) => SharedPrefsUtils.instance(),),
            ChangeNotifierProvider(create: (BuildContext context) => LoginRepository.instance(),),
            ChangeNotifierProvider(create: (BuildContext context) => TaskRepository.instance(),

            ),
          ],
        child:WelcomeScreen()),
  ),
      GoRoute(
          name:'createUserAccount',
          path: '/users/:email',
          builder: (context, state) {
            return ChangeNotifierProvider(create:(_) =>ProfileRepository.instance(),
              child: CreateUserAccountScreen(email:state.pathParameters['email']!,)


            );


          }),
    ]);


  Future<void> _configureAmplify() async {
   // var loginRepo = context.read<LoginRepository>();
    try{


      await Amplify.addPlugins([

        AmplifyAuthCognito(),
        AmplifyAPI(),
        AmplifyStorageS3()
      ]);

      await Amplify.configure(amplifyconfig);
      _logger.debug('Successfully configured Amplify');

      Amplify.Hub.listen(HubChannel.Auth, (event) {
        _logger.info('Auth Event: $event');
      });/*
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

*/
    }on Exception catch (e, st) {
    //  loginRepo.loadingAmplify = true;
      print('an error occured during amplify configuration: $e');
      _logger.error('Configuring Amplify failed', e, st);



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
   // var loginRepo = context.watch<LoginRepository>();
    return MaterialApp.router(
      title: 'Social App',


      theme: ThemeData(

 appBarTheme: const AppBarTheme(

   backgroundColor: Color(0xFFe76f51),
 ),
      fontFamily: 'Montserrat',
       primaryColor: const Color(0xFF264653),
          colorScheme:ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFe76f51))




      ),
     debugShowCheckedModeBanner: false,
     routerConfig: _router

/*
     home:_router

    // loginRepo.loadingAmplify ? const Center(child: CircularProgressIndicator(),) :
     MultiProvider(
       providers: [
         ChangeNotifierProvider(create: (BuildContext context) => SharedPrefsUtils.instance(),),
         ChangeNotifierProvider(create: (BuildContext context) => LoginRepository.instance(),),
         ChangeNotifierProvider(create: (BuildContext context) => TaskRepository.instance(),

         ),
       ],

       child: WelcomeScreen(),

     ),
*/


    );
  }
}

