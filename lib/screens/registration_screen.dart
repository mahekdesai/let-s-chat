import 'package:flutter/material.dart';
import 'package:letschat/my_button.dart';
import 'package:letschat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
  static const String id = 'RegistrationScreen';
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool spinner=false;
  final _auth = FirebaseAuth.instance;
  String email='';
  String pswd='';
  bool obscuredText=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                style: TextStyle(
                  color: Colors.black54,
                ),
                decoration: kTextFieldDecoration,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: obscuredText,
                onChanged: (value) {
                  pswd = value;
                },
                style: TextStyle(
                  color: Colors.black54,
                ),
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Password',
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      obscuredText=!obscuredText;
                    });
                  },
                      icon: Icon(obscuredText? Icons.visibility_off : Icons.visibility)
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              myButton(
                buttonColor: Colors.lightBlueAccent,
                buttonText: 'Register',
                onPress: () async {
                  setState(() {
                    spinner = true;
                  });
                  try{
                  final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: pswd);
                  if(newUser != null){
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    spinner = false;
                  });
                  }
                  catch(e){
                    print(e);
                    setState(() {
                      spinner = false;
                    });
                  }
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}