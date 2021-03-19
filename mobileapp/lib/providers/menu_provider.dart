import 'package:flutter/material.dart';

class MenuProvider with ChangeNotifier{
  bool _temp = false;
  bool _coins = true;
  bool _level = false;

  bool get temp => _temp;

  bool get coins => _coins;

  bool get level => _level;

  void selectTemp()
  {
    _temp = true;
    _coins = false;
    _level = false;
    notifyListeners();
  }

  void selectCoins()
  {
    _temp = false;
    _coins = true;
    _level = false;
    notifyListeners();
  }

  void selectLevel()
  {
    _temp = false;
    _coins = false;
    _level = true;
    notifyListeners();
  }

}