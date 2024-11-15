import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:social_media/repositories/login_respository.dart';
import 'package:social_media/repositories/profile_repository.dart';
import 'package:social_media/repositories/post_respository.dart';
import 'package:social_media/screens/create_post_screen.dart';
import 'package:social_media/screens/create_user_account.dart';
import 'package:social_media/screens/home_screen.dart';
import 'package:social_media/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/screens/welcome_screen.dart';
import 'package:social_media/utils/shared_preferences.dart';
import 'amplifyconfiguration.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:provider/provider.dart';

import 'repositories/comments_repository.dart';
import 'screens/comments_screen.dart';
import 'models/Post.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

final AmplifyLogger _logger = AmplifyLogger('socialApp');
Future main() async {
  await dotenv.load(fileName: ".env");
  //timeDilation = 5.0;=';;
  runApp(
    ChangeNotifierProvider(
      create: (_) => LoginRepository.instance(),
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
  bool _isConfigured = false;

  Future<void> _configureAmplify() async {
    try {
      await Amplify.addPlugins([
        AmplifyAPI(),
        AmplifyAuthCognito(

          secureStorageFactory: AmplifySecureStorage.factoryFrom(
            macOSOptions:
                // ignore: invalid_use_of_visible_for_testing_member
                MacOSSecureStorageOptions(useDataProtection: false),
          ),
        ),
        AmplifyStorageS3(),
      ]);

      await Amplify.configure(amplifyconfig);
      setState(() {
        _isConfigured = true;
      });
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Interior Design Social App',
        theme: ThemeData(
          fontFamily: 'Syne-Regular',
        ),
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),

        //  themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        routerConfig: GoRouter(routes: [
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) =>
                MultiProvider(
                    providers: [
                  ChangeNotifierProvider(
                    create: (BuildContext context) =>
                        SharedPrefsUtils.instance(),
                  ),
                  ChangeNotifierProvider(
                    create: (BuildContext context) =>
                        LoginRepository.instance(),
                  ),
                  ChangeNotifierProvider(
                    create: (BuildContext context) => PostRepository.instance(),
                  ),
                ],
                    child: _isConfigured
                        ? HomeScreen()
                        : const Scaffold(
                      body:Center(
                        child: CircularProgressIndicator(),
                      )
                    )),
          ),
          GoRoute(
              name: 'createPost',
              path: '/post/:userId',
              builder: (context, state) {
                return CreatePostScreen(
                    userId: state.pathParameters['userId']!);
              }),
          GoRoute(
              name: 'createUserAccount',
              path: '/createUserAccount',
              builder: (context, state) {
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (_) => ProfileRepository.instance(),
                    ),
                    ChangeNotifierProvider(
                      create: (_) => SharedPrefsUtils.instance(),
                    ),
                  ],
                  child: CreateUserAccountScreen(),
                );
              }),
          GoRoute(
              name: 'welcomeScreen',
              path: '/welcomeScreen',
            builder: (context,state){
              return MultiProvider(providers: [
                ChangeNotifierProvider(create: (context) => LoginRepository.instance(),
                ),
                ChangeNotifierProvider(create: (context) => ProfileRepository.instance(),
                ),


              ],child: WelcomeScreen(),);
            }
          ),
          GoRoute(
              name: 'userProfile',
              path: '/profile/:userId',
              builder: (context, state) {
                return ProfileScreen(
                  userId: state.pathParameters['userId']!,
                );
              }),
          GoRoute(
              name: 'commentsScreen',
              path: '/post/:userId/comments',
              builder: (context, state) {
                Post postItem = state.extra as Post;
                return ChangeNotifierProvider(
                  create: (context) => CommentsRepository.instance(),
                  child: CommentsScreen(
                    postItem: postItem,
                    userId: state.pathParameters['userId']!,
                  ),
                );
              }),
        ]));
  }
}
