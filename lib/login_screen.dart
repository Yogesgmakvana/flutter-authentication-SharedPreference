import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_by_ym/forgot_password_screen.dart';
import 'package:wallpaper_by_ym/main_screen.dart';
import 'package:wallpaper_by_ym/signup_screeb.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String Email = "";
  String Password = "";
  bool isDarkMode=isDark;
  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Email = prefs.getString('Email') ?? "";
      Password = prefs.getString('Password') ?? "";
      isDarkMode=prefs.getBool('isDarkModeOn') ?? false;
    });
    
  }

 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  final _formKey2 = GlobalKey<FormState>();
  //controller
  TextEditingController emailControllerLogin = TextEditingController();
  TextEditingController passwprdControllerLogin = TextEditingController();

  //dispose controller
  void dispose() {
  emailControllerLogin.dispose();
  passwprdControllerLogin.dispose();
  super.dispose();
}

  bool isShowed1 = true;

  Future<void> saveLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  await prefs.setBool('isDarkModeOn',isDarkMode);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Login",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey2,
                child: Column(
                  children: [
                    TextFormField(
                      validator: validateEmailLogin,
                      controller: emailControllerLogin,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        label: Text("Email"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    //password
                    
                    TextFormField(
                      maxLines: 1,
                      maxLength:10,
                      minLines:2,
                      validator: validateConfirmPasswordLogin,
                      obscureText: isShowed1,
                      controller: passwprdControllerLogin,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_rounded),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isShowed1 = !isShowed1;
                            });
                          },
                          icon: Icon(
                            isShowed1
                                ? Icons.visibility_off_rounded
                                : Icons.visibility,
                          ),
                        ),
                        label: Text("Create Password"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    //login Button
                    InkWell(
                      onTap: () {
                        if (_formKey2.currentState!.validate()) {
                          if (loginAuthentication()) {
                            saveLoginStatus();//login Saved
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Login Successfully"),
                              ),
                            );

                            //navigate next page
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Invalid Cridentials!"),
                              ),
                            );
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        //login box container
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                        }, child:Text("Sign Up")),
                        TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
                        }, child: Text("Forgot Password")),
                      ],
                    ),
                  ],
                ),
              ),                     
            ),
          ],
        ),
      ),
    );
  }

  String? validateConfirmPasswordLogin(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Password";
    }
    if (value.length < 8) {
      return "Password must be greter than character";
    }
    // if(value != Password){
    //   return "Confrim password must be same";
    // }
    return null;
  }

  String? validateEmailLogin(String? value) {
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

  loginAuthentication() {
    if (Email == emailControllerLogin.text &&
        Password == passwprdControllerLogin.text) {
      return true;
    } else {
      return false;
    }
  }
}
