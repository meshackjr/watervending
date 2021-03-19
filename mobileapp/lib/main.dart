import 'package:flutter/material.dart';
import 'package:mvm/providers/auth_provider.dart';
import 'package:mvm/providers/data_provider.dart';
import 'package:mvm/providers/menu_provider.dart';
import 'package:mvm/screens/home_screen.dart';
import 'package:mvm/screens/login.dart';
import 'package:mvm/screens/login_screen.dart';
import 'package:mvm/screens/report_screen.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: MenuProvider(),
        ),
        ChangeNotifierProvider.value(
          value: DataProvider(),
        ),
        ChangeNotifierProvider.value(value: AuthProvider(),),
      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: {
          HomeScreen.routeName : (context)=>HomeScreen(),
          ReportScreen.routeName: (context)=>ReportScreen(),
          LoginScreen.routeName: (context)=>LoginScreen(),
          Login.routName: (context)=>Login(),
        },
      ),
    );
  }
}
