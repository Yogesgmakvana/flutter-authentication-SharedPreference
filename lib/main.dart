import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_by_ym/login_screen.dart';
import 'package:wallpaper_by_ym/main_screen.dart';



void main()async{
   WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  bool isDarkMode=prefs.getBool('isDarkModeOn') ?? false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.isLoggedIn});
 final bool isLoggedIn;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home:isLoggedIn? MainScreen() : LoginScreen(),
    );
  }
}

