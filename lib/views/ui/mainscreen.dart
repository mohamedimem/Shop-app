import 'package:app/controllers/mainscreen_provider.dart';
import 'package:app/views/ui/product_details.dart';
import 'package:app/views/ui/screens.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:provider/provider.dart';

import '../shared/bottom_nav_bar.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  void changePage(index, context) {}

  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    CartPage(),
    CartPage(),
    ProfilePage(),
  ];
  int pageIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(builder: (context, myPage, chile) {
      return Scaffold(
        body: pages[myPage.pageIndex],
        bottomNavigationBar: const bottomNavBar(),
      );
    });
  }
}
