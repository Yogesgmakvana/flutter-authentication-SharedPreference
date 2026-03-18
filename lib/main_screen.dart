import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_by_ym/editprofile_screen.dart';
import 'package:wallpaper_by_ym/login_screen.dart';
import 'package:wallpaper_by_ym/wallpaper_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

bool isDark=false;

String EmailM="";
String NameM="";
String PhoneM="";

class _MainScreenState extends State<MainScreen> {
   void getData()async{
     SharedPreferences prefs=await SharedPreferences.getInstance();
    setState((){
    EmailM=prefs.getString('Email')??"";
    NameM=prefs.getString('Name')??"";
    PhoneM=prefs.getString('Phone')??"";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }

  //logout using isLoggedIn variables
  Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);
  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>LoginScreen()),);
   await prefs.setBool('isDarkModeOn',isDark);
  }


  Colors? color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark? Colors.black54:Colors.white,
      appBar: AppBar(
        title: Text("Main Screen"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(accountName: Text(NameM),
             accountEmail: Text(EmailM),),

           InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>EditprofileScreen()));
            },
             child: ListTile(
              leading:Icon(Icons.settings),
              title:Text("Edit Profile"),
             ),
           ),  

           ListTile(
            leading:Switch(value:isDark,
             onChanged:(value) {
               setState(() {
                 isDark=!isDark;
               });
             },),
            title:Text("Dark mode"),
           ), 
          //logout using set bool as false
           InkWell(
            onTap: (){
             logout();
            },
             child: ListTile(
              leading:Icon(Icons.logout_outlined),
              title:Text("Log out"),
             ),
           ), 
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            
            Center(
              child: TextButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>WallpaperScreen()));
              }, child: Text('Wallpaper set')),
            ),
          ],
        ),
      ),
    );
  }
}