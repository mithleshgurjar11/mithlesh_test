import 'package:demo/screen/auth/login_screen.dart';
import 'package:demo/screen/auth/signup/signup_screen.dart';
import 'package:demo/screen/home/home_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes{

  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const HomeScreen(),
      login: (context) => LoginScreen(),
      signup: (context) => const SignupScreen(),
    };
  }


  /*static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.audioCall:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => AudioCallScreen(
            channelName: args['channelName'],
            rtcToken: args['rtcToken'],
            callMaxTime: args['callMaxTime'],
            remoteUserImage: args['remoteUserImage'],
            profilePic: args['profilePic'],
            fullName: args['fullName'],
          ),
        );
      default:
        return null;
    }
  }*/

}

