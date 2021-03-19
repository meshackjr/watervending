import 'package:flutter/material.dart';
import 'package:mvm/providers/data_provider.dart';
import 'package:provider/provider.dart';
import '../helper/colors.dart';

class CoinsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coin = Provider.of<DataProvider>(context);
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
                color: CustomColor.mainBlue,
                width: 15,
              )
            ),
            child: Center(
              child: Text(
                coin.getCoin(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              'Total Collected',
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
