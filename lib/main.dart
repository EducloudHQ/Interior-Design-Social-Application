import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:social_media/repositories/login_respository.dart';
import 'package:social_media/repositories/profile_repository.dart';
import 'package:social_media/repositories/task_respository.dart';
import 'package:social_media/screens/create_user_account.dart';
import 'package:social_media/screens/home_screen.dart';
import 'package:social_media/screens/profile_screen.dart';


import 'package:go_router/go_router.dart';
import 'package:social_media/utils/shared_preferences.dart';
import 'amplifyconfiguration.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:provider/provider.dart';

import 'models/ModelProvider.dart';

final AmplifyLogger _logger = AmplifyLogger('socialApp');
void main() {
  AmplifyLogger().logLevel = LogLevel.verbose;
  runApp(

      ChangeNotifierProvider(
        create: (_) =>
            LoginRepository.instance(),
        child: App(),
      ),

      );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _MyAppState();
}

class _MyAppState extends State<App> {

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
        child:HomeScreen()),
  ),
      GoRoute(
          name:'createUserAccount',
          path: '/users/:email',
          builder: (context, state) {
            return ChangeNotifierProvider(create:(_) =>ProfileRepository.instance(),
              child: CreateUserAccountScreen(email:state.pathParameters['email']!,)


            );


          }),

      GoRoute(
          name:'userProfile',
          path: '/profile',
          builder: (context, state) {
            return  ProfileScreen();





          }),
    ]);


  Future<void> _configureAmplify() async {
    try {
      await Amplify.addPlugins([
        AmplifyAPI(),
        AmplifyAuthCognito(
          // FIXME: In your app, make sure to remove this line and set up
          /// Keychain Sharing in Xcode as described in the docs:
          /// https://docs.amplify.aws/lib/project-setup/platform-setup/q/platform/flutter/#enable-keychain
          secureStorageFactory: AmplifySecureStorage.factoryFrom(
            macOSOptions:
            // ignore: invalid_use_of_visible_for_testing_member
            MacOSSecureStorageOptions(useDataProtection: false),
          ),
        ),
        AmplifyStorageS3(),
        AmplifyDataStore(
          modelProvider: ModelProvider.instance,
          errorHandler: ((error) => {
            if (kDebugMode) {print("Custom ErrorHandler received: $error")}
          }),
        )
      ]);

      await Amplify.configure(amplifyconfig);
      _logger.debug('Successfully configured Amplify');

      Amplify.Hub.listen(HubChannel.Auth, (event) {
        _logger.info('Auth Event: $event');
      });
    } on Exception catch (e, st) {
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

    return MaterialApp.router(
      title: 'Social App',

      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.light(),

      //  themeMode: ThemeMode.system,
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

