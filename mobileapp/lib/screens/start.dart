import 'package:flutter/material.dart';
import 'package:mvm/helper/colors.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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
