import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_by_ym/login_screen.dart';
import 'package:wallpaper_by_ym/main_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController emailControllerForgot=TextEditingController();
  void dispose() {
  emailControllerForgot.dispose();
  super.dispose();
}

   String Email = "";
  String Password = "";

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Email = prefs.getString('Email') ?? "";
      Password = prefs.getString('Password') ?? "";
    });
  }
  final _formKey3=GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  bool isPasswordShow=false;
  forgotAuthentication(){
    if(Email == emailControllerForgot.text){
      setState(() {
        isPasswordShow=true;
      });
    }else{
      setState(() {
        isPasswordShow=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          Text("Forgot Password",style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key:_formKey3,
              child: Column(
              children: [
                 TextFormField(
                        validator: validateEmailForgot,
                        controller: emailControllerForgot,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          label: Text("Email"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Visibility(
                        visible: isPasswordShow,
                        child: Text("Password is:$Password")
                        ),
                      SizedBox(
                        height: 25,
                      ),
               //show password Button
                      InkWell(
                        onTap: () {
                          if(_formKey3.currentState!.validate()){
                             if(forgotAuthentication()){
                                 ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                                  content: Text("You can see passowrd on screen"),
                                ),
                              );
                             }
                          }else{
                             ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                                  content: Text("User not found!!"),
                                ),
                              );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          //show password box container
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Show Password",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //Dont have account got to login
                      Row(
                        mainAxisAlignment:  MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                          }, child: Text("Go to Login Page")),
                        ],
                      ),
              ],
            ),),
          ),
        ],
      )),
    );
  }

   String? validateEmailForgot(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Email";
    }
    if (!value.contains("@")) {
      return "Please Enter Valid Email";
    }

    // if(Email != emailControllerLogin.text){
    //   return "Please Enter Valid Email";
    // }
    return null;
  }
}