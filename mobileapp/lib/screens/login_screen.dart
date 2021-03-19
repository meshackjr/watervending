import 'package:flutter/material.dart';
import 'package:mvm/animation/FadeAnimation.dart';
import 'package:mvm/helper/colors.dart';
import 'package:mvm/providers/auth_provider.dart';
import 'package:mvm/screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Future<void> setSession() async {
    Navigator.popAndPushNamed(context, HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    var idController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    auth.checkAuth();
    if (auth.getIsAuth()) {
      setSession();
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeAnimation(1, Text("Login", style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),)),
                      SizedBox(height: 20,),
                      FadeAnimation(1.2, Text("Login to your account", style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700]
                      ),)),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(1.2, makeInput(label: "Machine ID",controller: idController)),
                        FadeAnimation(1.3, makeInput(label: "Email",controller: emailController)),
                        FadeAnimation(1.4, makeInput(label: "Password", controller: passwordController,obscureText: true)),
                      ],
                    ),
                  ),
                  FadeAnimation(1.4, Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          // auth.loginUser(idController.text, emailController.text, passwordController.text);
                        },
                        color: CustomColor.mainBlue,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Text("Login", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          color: Colors.white,
                        ),),
                      ),
                    ),
                  )),
                  FadeAnimation(1.5, Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                    ],
                  ))
                ],
              ),
            ),
            FadeAnimation(1.2, Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget makeInput({label,controller, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }
}
