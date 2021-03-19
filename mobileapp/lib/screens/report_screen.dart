import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvm/helper/colors.dart';
import 'package:mvm/providers/data_provider.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  static const routeName = '/report';
  ReportScreen({Key key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  var date = DateFormat.yMMMd().format(DateTime.now());
  bool first = true;
  
  @override
  Widget build(BuildContext context) {
    final double barwidth = 120;
    final double barheight = 80;
    final coin = Provider.of<DataProvider>(context);
    if (first) {
      coin.setDailyCoin();
      first =false;
    }
    return Scaffold(
        backgroundColor: CustomColor.mainGray,
       body: SafeArea(
         child: Container(

           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               BackButton(),
               Container(
                 padding: EdgeInsets.all(20),
                 child: Text(
                     "Days",
                   style: TextStyle(
                     fontSize: 25,
                     fontWeight: FontWeight.bold
                   ),
                 ),
               ),
               SizedBox(height: 10,),
               SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: Container(
                   padding: EdgeInsets.all(20),
                   child: Row(

                     children: [

                        GestureDetector(
                          onTap: (){
                            setState(() {
                              date = DateFormat.yMMMd().format(DateTime.now()).toString();
                            });
                            coin.loadDailyCoin(date);
                          },
                          child: Container(
                           height: barheight,
                           width: barwidth,
                            decoration: BoxDecoration(
                              color: CustomColor.mainBlue,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Center(
                              child: Text(
                                  DateFormat.yMMMd().format(DateTime.now()).toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                       ),
                        ),
                       SizedBox(width: 5,),
                       GestureDetector(
                         onTap: (){
                           setState(() {
                             date = DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: 1))).toString();
                           });
                           coin.loadDailyCoin(date);
                         },
                         child: Container(
                           height: barheight,
                           width: barwidth,
                           decoration: BoxDecoration(
                               color: CustomColor.mainBlue,
                               borderRadius: BorderRadius.all(Radius.circular(5))
                           ),
                           child: Center(
                             child: Text(
                               DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: 1))).toString(),
                               style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold
                               ),
                             ),
                           ),
                         ),
                       ),
                       SizedBox(width: 5,),
                       GestureDetector(
                         onTap: (){
                           setState(() {
                             date = DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: 2))).toString();
                           });
                           coin.loadDailyCoin(date);
                         },
                         child: Container(
                           height: barheight,
                           width: barwidth,
                           decoration: BoxDecoration(
                               color: CustomColor.mainBlue,
                               borderRadius: BorderRadius.all(Radius.circular(5))
                           ),
                           child: Center(
                             child: Text(
                               DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: 2))).toString(),
                               style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold
                               ),
                             ),
                           ),
                         ),
                       ),
                       SizedBox(width: 5,),
                       GestureDetector(
                         onTap: (){
                           setState(() {
                             date = DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: 3))).toString();
                           });
                           coin.loadDailyCoin(date);
                         },
                         child: Container(
                           height: barheight,
                           width: barwidth,
                           decoration: BoxDecoration(
                               color: CustomColor.mainBlue,
                               borderRadius: BorderRadius.all(Radius.circular(5))
                           ),
                           child: Center(
                             child: Text(
                               DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: 3))).toString(),
                               style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold
                               ),
                             ),
                           ),
                         ),
                       ),
                       SizedBox(width: 5,),
                       GestureDetector(
                         onTap: (){
                           setState(() {
                             date = DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: 4))).toString();
                           });
                           coin.loadDailyCoin(date);
                         },
                         child: Container(
                           height: barheight,
                           width: barwidth,
                           decoration: BoxDecoration(
                               color: CustomColor.mainBlue,
                               borderRadius: BorderRadius.all(Radius.circular(5))
                           ),
                           child: Center(
                             child: Text(
                               DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: 4))).toString(),
                               style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold
                               ),
                             ),
                           ),
                         ),
                       ),
                       SizedBox(width: 5,),
                       GestureDetector(
                         onTap: (){
                           setState(() {
                             date = DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: 5))).toString();
                           });
                           coin.loadDailyCoin(date);
                         },
                         child: Container(
                           height: barheight,
                           width: barwidth,
                           decoration: BoxDecoration(
                               color: CustomColor.mainBlue,
                               borderRadius: BorderRadius.all(Radius.circular(5))
                           ),
                           child: Center(
                             child: Text(
                               DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: 5))).toString(),
                               style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold
                               ),
                             ),
                           ),
                         ),
                       ),
                       SizedBox(width: 5,),
                       GestureDetector(
                         onTap: (){
                           setState(() {
                             date = DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: 6))).toString();
                           });
                           coin.loadDailyCoin(date);
                         },
                         child: Container(
                           height: barheight,
                           width: barwidth,
                           decoration: BoxDecoration(
                               color: CustomColor.mainBlue,
                               borderRadius: BorderRadius.all(Radius.circular(5))
                           ),
                           child: Center(
                             child: Text(
                               DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: 6))).toString(),
                               style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold
                               ),
                             ),
                           ),
                         ),
                       )
                     ],
                   ),
                 ),
               ),
               Container(
                 margin: EdgeInsets.all(20),
                 width: MediaQuery.of(context).size.width,
                 height: 200,
                 padding: EdgeInsets.all(20),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.all(Radius.circular(10))
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       "Total Sales At: "+date,
                       style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold
                       ),
                     ),

                     SizedBox(height: 40,),
                     Center(
                       child: Text(
                         coin.getDailyCoin(),
                         style: TextStyle(
                             fontSize: 40,
                             color: CustomColor.mainBlue,
                             fontWeight: FontWeight.bold
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ],
           ),
         ),
       ),
    );
  }
}