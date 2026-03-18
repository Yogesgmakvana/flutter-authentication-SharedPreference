import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_by_ym/login_screen.dart';
import 'package:wallpaper_by_ym/main_screen.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController createPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void dispose() {
nameController.dispose();
emailController.dispose();
phoneController.dispose();
createPasswordController.dispose();
confirmPasswordController.dispose();
  super.dispose();
}

  bool isShowed = true;

  void setUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Name', nameController.text);
    await prefs.setString('Email', emailController.text);
    await prefs.setString('Phone', phoneController.text);
    await prefs.setString('Password', createPasswordController.text);
    await prefs.setString('confirmPassword',confirmPasswordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //textfild for fullname
                      TextFormField(
                        validator: validateName,
                        controller: nameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_2),
                          label: Text("Name"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      //Email textfield
                      TextFormField(
                        validator: validateEmail,
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          label: Text("Email"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      //phone textfield
                      TextFormField(
                        validator: validatePhone,
                        controller: phoneController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.call),
                          label: Text("Phone"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      //create password field
                      TextFormField(
                        validator: validateConfirmPassword,
                        obscureText: isShowed,
                        controller: createPasswordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password_rounded),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isShowed = !isShowed;
                              });
                            },
                            icon: Icon(
                              isShowed
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
                      SizedBox(height: 20),
                      //confirm password field
                      TextFormField(
                        validator: validateConfirmPassword,
                        obscureText: isShowed,
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password_rounded),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isShowed = !isShowed;
                              });
                            },
                            icon: Icon(
                              isShowed
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility,
                            ),
                          ),
                          label: Text("Confirm Password"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              //sign up button
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    setUserDetails();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Account Created Successfully"),
                      ),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Check Details")),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              //Dont have account got to login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account!"),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        }, child:Text("Login")),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
  

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Name";
    }
    if (value.length < 5) {
      return "Please Enter Full name";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Email";
    }
    if (!value.contains("@")) {
      return "Please Enter Valid Email";
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Phone";
    }
    if (value.length < 10) {
      return "Please Enter Full Number";
    }
    if (value.length > 10) {
      return "Please Enter Valid Number";
    }
    return null;
  }

  String? validateCreatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Password";
    }
    if (value.length < 8) {
      return "Password must be greter than character";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Password";
    }
    if (value.length < 8) {
      return "Password must be greter than character";
    }
    if (value != createPasswordController.text) {
      return "Confrim password must be same";
    }
    return null;
  }
}
