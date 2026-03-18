import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditprofileScreen extends StatefulWidget {
  const EditprofileScreen({super.key});

  @override
  State<EditprofileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  TextEditingController nameControlleEdit = TextEditingController();
  TextEditingController emailControllerEdit= TextEditingController();
  TextEditingController phoneControllerEdit= TextEditingController();
  TextEditingController createPasswordControllerEdit= TextEditingController();
  TextEditingController confirmPasswordControllerEdit= TextEditingController();

  @override
void dispose() {
  nameControlleEdit.dispose();
  emailControllerEdit.dispose();
  phoneControllerEdit.dispose();
  createPasswordControllerEdit.dispose();
  confirmPasswordControllerEdit.dispose();
  super.dispose();
}

  bool isShowed = true;
  final _formKey4=GlobalKey<FormState>();
  
  String NameEdit="";
  String PhoneEdit="";
  String EmailEdit= "";
  String PasswordEdit= "";
  String ConfirmPasswordEdit="";


  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailControllerEdit.text= prefs.getString('Email') ?? "";
      createPasswordControllerEdit.text= prefs.getString('Password') ?? "";
      nameControlleEdit.text=prefs.getString('Name')??"";
      phoneControllerEdit.text=prefs.getString('Phone')??"";
      confirmPasswordControllerEdit.text=prefs.getString('confirmPassword')??"";
    });
   


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  setUserDetailsEdit()async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
       await prefs.setString('Name',nameControlleEdit.text);
       await prefs.setString('Email',emailControllerEdit.text);
       await prefs.setString('Phone',phoneControllerEdit.text);
       await prefs.setString('Password',createPasswordControllerEdit.text);
       await prefs.setString('confirmPassword',confirmPasswordControllerEdit.text);
     
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
                "",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey4,
                  child: Column(
                    children: [
                      //textfild for fullname
                      TextFormField(
                        validator: validateName,
                        controller: nameControlleEdit,
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
                        controller: emailControllerEdit,
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
                        controller: phoneControllerEdit,
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
                        controller: createPasswordControllerEdit,
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
                        controller: confirmPasswordControllerEdit,
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
                  if (_formKey4.currentState!.validate()) {
                    setUserDetailsEdit();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Details Edited Succsessfully!!"),
                      ),
                    );

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginScreen()),
                    // );
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
                        "Edit Profile",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
          ],
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
  //45120012078

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
    // if (value != createPasswordController.text) {
    //   return "Confrim password must be same";
    // }
    return null;
  }
}