import 'dart:convert';

import 'package:app/models/shoes_model.dart';
import 'package:flutter/services.dart' as the_bundle;

class Helper {
  Future<List<Shoes>> getMaleSneakers() async {
    //Load json files as string
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
//Strings to List of Shes

    final dataList =
        List<Shoes>.from(json.decode(data).map((x) => Shoes.fromJson(x)));
    return dataList;
  }

  Future<List<Shoes>> getFemaleSneakers() async {
    //Load json files as string
    final data =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");

//Strings to List of Shes

    final dataList =
        List<Shoes>.from(json.decode(data).map((x) => Shoes.fromJson(x)));
    return dataList;
  }

  Future<List<Shoes>> getKidsSHoes() async {
    //Load json files as string
    final data =
        await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

//Strings to List of Shes

    final dataList =
        List<Shoes>.from(json.decode(data).map((x) => Shoes.fromJson(x)));
    return dataList;
  }

  Future<Shoes> getMaleShoesById(String id) async {
    //Load json files as string
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");

//Strings to List of Shes

    final dataList =
        List<Shoes>.from(json.decode(data).map((x) => Shoes.fromJson(x)));
    final sneaker = dataList.firstWhere((element) => element.id == id);
    return sneaker;
  }

  Future<Shoes> getFemaleShoesById(String id) async {
    //Load json files as string
    final data =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");

//Strings to List of Shes

    final dataList =
        List<Shoes>.from(json.decode(data).map((x) => Shoes.fromJson(x)));
    final sneaker = dataList.firstWhere((element) => element.id == id);
    return sneaker;
  }

  Future<Shoes> getKidsShoesById(String id) async {
    //Load json files as string
    final data =
        await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

//Strings to List of Shes

    final dataList =
        List<Shoes>.from(json.decode(data).map((x) => Shoes.fromJson(x)));
    final sneaker = dataList.firstWhere((element) => element.id == id);
    return sneaker;
  }
}
