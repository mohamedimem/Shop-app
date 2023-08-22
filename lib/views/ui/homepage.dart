import 'package:app/services/helper.dart';
import 'package:app/views/shared/product_card.dart';
import 'package:app/views/shared/product_provider.dart';
import 'package:app/views/shared/product_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:provider/provider.dart';

import '../../models/shoes_model.dart';
import '../shared/appstyle.dart';
import '../shared/man_shoes_widget.dart';
import '../shared/new_shoes.dart';
import '../shared/product_provider.dart';
import '../shared/product_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  late Future<List<Shoes>> _male;
  late Future<List<Shoes>> _female;
  late Future<List<Shoes>> _kids;

  void getMale() {
    _male = Helper().getMaleSneakers();
  }

  void getFemale() {
    _female = Helper().getFemaleSneakers();
  }

  void getKids() {
    _kids = Helper().getKidsSHoes();
  }

  @override
  void initState() {
    super.initState();
    getMale();
    getFemale();
    getKids();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              Container(
                child: Container(
                  padding: EdgeInsets.only(left: 8, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Athletics Shoes ',
                        style: appstyle(42, Colors.white, FontWeight.bold),
                      ),
                      Text(
                        'Collection',
                        style: appstyleWithHt(
                            42, Colors.white, FontWeight.bold, 1.5),
                      ),
                      TabBar(
                          padding: EdgeInsets.zero,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          controller: _tabController,
                          isScrollable: true,
                          labelColor: Colors.white,
                          labelStyle:
                              appstyle(24, Colors.white, FontWeight.bold),
                          unselectedLabelColor: Colors.grey.withOpacity(0.3),
                          tabs: const [
                            Tab(
                              child: Text('Men Shoes'),
                            ),
                            Tab(
                              child: Text('Women Shoes'),
                            ),
                            Tab(
                              child: Text('Kids Shoes'),
                            ),
                          ]),
                    ],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/top_image.png"),
                  fit: BoxFit.cover,
                )),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.265),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: TabBarView(controller: _tabController, children: [
                      MenShoesWidget(
                        male: _male,
                        index: 0,
                      ),
                      MenShoesWidget(
                        male: _female,
                        index: 1,
                      ),
                      MenShoesWidget(
                        male: _kids,
                        index: 2,
                      ),
                    ]),
                  )),
            ])));
  }
}
