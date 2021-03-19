import 'package:flutter/material.dart';
import 'package:mvm/helper/colors.dart';
import 'package:mvm/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class Login extends StatefulWidget {
  static const routName = 'logins';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _idController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _load = false;

  Future<void> setSession({context}) async {
    Navigator.popAndPushNamed(context, HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    auth.checkAuth();
    Future.delayed(Duration(seconds: 5)).then((value) {
      if (auth.getIsAuth()) {
        setSession(context: context);
      }
      else{
        setState(() {
          _load =true;
        });
      }

    });
    return Scaffold(
      body: SafeArea(
        child: _load?form(auth: auth):start(context: context),
      ),
    );
  }

  Widget form({auth}){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Login", style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),),
          ),
          makeInput(label: "Machine ID",controller: _idController),
          makeInput(label: "Email",controller: _emailController),
          makeInput(label: "Password", controller: _passwordController,obscureText: true),
          MaterialButton(
            minWidth: double.infinity,
            height: 60,
            onPressed: () {
              auth.loginUser(_idController.text, _emailController.text, _passwordController.text);
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
        ],
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

  Widget start({context}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: Text(
            '',
            style: TextStyle(
              fontSize: 30,
              color: CustomColor.mainBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Image.asset('assets/images/milk.png',fit: BoxFit.fitWidth,),
        )
      ],
    );
  }
}
