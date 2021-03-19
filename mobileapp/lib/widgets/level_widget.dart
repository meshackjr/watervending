import 'package:flutter/material.dart';
import 'package:mvm/helper/colors.dart';
import 'package:mvm/providers/data_provider.dart';
import 'package:provider/provider.dart';

class LevelWidget extends StatefulWidget {

  @override
  _LevelWidgetState createState() => _LevelWidgetState();
}

class _LevelWidgetState extends State<LevelWidget> {

  @override
  Widget build(BuildContext context) {
    final lv = Provider.of<DataProvider>(context);
    return Container(
      height: 220,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 50),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: lv.getLev()=="Low Level"? Colors.red: CustomColor.mainBlue,
                  width: 15,
                )
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    lv.getVolume(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    lv.getLev(),
                    style: TextStyle(
                      fontSize: 16,
                      color: lv.getLev()=="Low Level"? Colors.red: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Text(
              'Water level left',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
