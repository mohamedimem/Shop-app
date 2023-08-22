import 'package:app/controllers/mainscreen_provider.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import 'bottom_nav_widget.dart';

class bottomNavBar extends StatelessWidget {
  const bottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(builder: (context, myPage, child) {
      return SafeArea(
          child: Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BottomNavWidget(
                      onTap: () {
                        myPage.SetPageIndex = 0;
                      },
                      icon: myPage.pageIndex == 0
                          ? CommunityMaterialIcons.home
                          : CommunityMaterialIcons.home_outline,
                    ),
                    BottomNavWidget(
                      onTap: () {
                        myPage.SetPageIndex = 1;
                      },
                      icon: Ionicons.search,
                    ),
                    BottomNavWidget(
                      onTap: () {
                        myPage.SetPageIndex = 2;
                      },
                      icon: myPage.pageIndex == 2
                          ? Ionicons.add
                          : Ionicons.add_circle_outline,
                    ),
                    BottomNavWidget(
                      onTap: () {
                        myPage.SetPageIndex = 3;
                      },
                      icon: myPage.pageIndex == 3
                          ? Ionicons.cart
                          : Ionicons.cart_outline,
                    ),
                    BottomNavWidget(
                      onTap: () {
                        myPage.SetPageIndex = 4;
                      },
                      icon: myPage.pageIndex == 4
                          ? Ionicons.person
                          : Ionicons.person_outline,
                    )
                  ],
                ),
              )));
    });
  }
}
