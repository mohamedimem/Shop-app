import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  int _activePage = 0;
  List<dynamic> _shoesSize = [];

  int get activePage => _activePage;
  set activePage(int newIndex) {
    _activePage = newIndex;
    notifyListeners();
  }

  List<dynamic> get shoeSizes => _shoesSize;
  set shoesSizes(List<dynamic> newSizes) {
    _shoesSize = newSizes;
    notifyListeners();
  }

  void toogleCheck(int index) {
    for (int i = 0; i < _shoesSize.length; i++) {
      if (i == index) {
        _shoesSize[i]['isSelected'] = !_shoesSize[i]['isSelected'];
      }
    }
    notifyListeners();
  }
}
