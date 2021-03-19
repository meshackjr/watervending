import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvm/providers/data_provider.dart';
import 'package:mvm/providers/menu_provider.dart';
import 'package:mvm/screens/report_screen.dart';
import 'package:mvm/widgets/coins_widget.dart';
import 'package:mvm/widgets/level_widget.dart';
import 'package:provider/provider.dart';
import '../helper/colors.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) => (){});
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<DataProvider>(context).loadData();
  }

  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<MenuProvider>(context);
    return Scaffold(
      backgroundColor: CustomColor.mainGray,
       body: SafeArea(
         child: Column(
           children: <Widget>[
             Row(
               children: <Widget>[
                 IconButton(
                   icon: Icon(Icons.date_range),
                   onPressed: (){
                     Navigator.pushNamed(
                       context,
                       ReportScreen.routeName
                     );
                   },
                 ),
                 Container(
                  padding: EdgeInsets.all(0),
                  child: Text(
                      "Water Vending",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                //  IconButton(
                //    icon: Icon(Icons.exit_to_app),
                //    onPressed: (){
                //      auth.logout();
                //      Navigator.popAndPushNamed(context, Login.routName);
                //    },
                //  ),
               ],
             ),
             menu.coins?CoinsWidget():Container(),
             menu.level?LevelWidget():Container(),
             Container(
               margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10) ,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   GestureDetector(
                     onTap: (){
                       menu.selectCoins();
                     },
                     child: Container(
                       height: 80,
                       width: 80,
                       padding: EdgeInsets.all(15),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         shape: BoxShape.circle,
                         border: Border.all(
                           color: menu.coins?CustomColor.mainBlue:Colors.white,
                           width: 3,
                         ),
                       ),
                       child: Image.asset(menu.coins?'assets/images/coins_active.png':'assets/images/coins.png'),
                     ),
                   ),
                   GestureDetector(
                     onTap: (){
                       menu.selectLevel();
                     },
                     child: Container(
                       height: 80,
                       width: 80,
                       padding: EdgeInsets.all(15),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         shape: BoxShape.circle,
                         border: Border.all(
                           color: menu.level?CustomColor.mainBlue:Colors.white,
                           width: 3,
                         ),
                       ),
                       child: Image.asset(menu.level?'assets/images/level_active.png':'assets/images/level.png'),
                     ),
                   ),
                 ],
               ),
             ),
           ],
         ),
       ),
    );
  }
}
