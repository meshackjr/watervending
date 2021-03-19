import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DataProvider with ChangeNotifier{
  String _temp="Fetching...";
  String _volume = "Fetching..";
  String _lev = "";
  String _coin = "Fetching..";
  String _dailyCoin = "Fetching..";


  String getTemp(){
    return _temp;
  }
  String getLev(){
    return _lev;
  }
  String getCoin(){
    return _coin;
  }
  String getVolume(){
    return _volume;
  }
  String getDailyCoin(){
    return _dailyCoin;
  }
  void setDailyCoin(){
    _dailyCoin = "Fetching..";
//    notifyListeners();
  }


  Future<void> loadDailyCoin (var dataDate) async {

    _dailyCoin = "Fetching ..";
    notifyListeners();
    const baseUrl = 'https://watervending-12e73-default-rtdb.firebaseio.com/';
    const  coinDataUrl = baseUrl+'sensor.json';
    final coinDataResponse = await http.get(coinDataUrl);


    final coinData = json.decode(coinDataResponse.body) as Map<String,dynamic>;
    int sum = 0;
    String date;
    coinData.forEach((key, data) {

      date = DateFormat.yMMMd().format
      (DateTime.fromMillisecondsSinceEpoch(data['timestamp']));

      if(
        date == dataDate
        // && data['coin'] ==500
      ){
        sum += data['coin'];
      } else {
        sum = 0;
      }

    });

    _dailyCoin = 'Tsh '+sum.toString();
    notifyListeners();
  }

  Future<void> loadData () async {
    const baseUrl = 'https://watervending-12e73-default-rtdb.firebaseio.com/';
    // DHT11/Temperature = Coin Data
    const  currentCoinUrl = baseUrl+'DHT11.json';
    const  currentDepthUrl = baseUrl+'ULTRA.json';
    // ULTRA/Distance = Depth data
    const  coinDataUrl = baseUrl+'sensor.json';

    try{
      final currentCoinResponse = await http.get(currentCoinUrl);
      final currentDepthResponse = await http.get(currentDepthUrl);
      final coinDataResponse = await http.get(coinDataUrl);

      final currentCoinData = json.decode(currentCoinResponse.body) as Map<String,dynamic>;
      final currentDepthData = json.decode(currentDepthResponse.body) as Map<String,dynamic>;
      final coinData = json.decode(coinDataResponse.body) as Map<String,dynamic>;
      
      final distance = currentDepthData['Distance'];
      // final volume = (20-distance)*0.25;
      _volume = distance.toString()+" L";

      int sum = 0;
      String date;
      coinData.forEach((key, data) {
        date = DateFormat.yMMMd().format
        (DateTime.fromMillisecondsSinceEpoch(data['timestamp']));
        if(
          date == DateFormat.yMMMd().format(DateTime.now())
          // && data['coin'] ==500
        ){
          sum += data['coin'];
        }
      });

      _coin = 'Tsh '+sum.toString();
      if(_dailyCoin == "Fetching..")
        _dailyCoin = _coin;
      _temp = currentCoinData['Temperature'].toString();
      
      notifyListeners();
    }
    catch(e){
      throw(e);
    }
  }

}

