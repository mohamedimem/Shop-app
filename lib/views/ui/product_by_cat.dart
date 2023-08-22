import 'package:app/views/shared/category_btn.dart';
import 'package:app/views/shared/customer_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

import '../../models/shoes_model.dart';
import '../../services/helper.dart';
import '../shared/appstyle.dart';
import '../shared/lastest_shoes.dart';

class ProdcutByCat extends StatefulWidget {
  ProdcutByCat({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  State<ProdcutByCat> createState() => _ProdcutByCatState();
}

class _ProdcutByCatState extends State<ProdcutByCat>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this, initialIndex: widget.tabIndex);

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

  double _value = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/top_image.png"),
                  fit: BoxFit.cover,
                )),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            AntDesign.close,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            filter();
                          },
                          icon: Icon(
                            FontAwesome.sliders,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    TabBar(
                        padding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.transparent,
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Colors.white,
                        labelStyle: appstyle(24, Colors.white, FontWeight.bold),
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
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.175,
                    left: 16,
                    right: 12),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: TabBarView(controller: _tabController, children: [
                    LatestShoes(male: _male),
                    LatestShoes(male: _female),
                    LatestShoes(male: _kids),
                  ]),
                ),
              ),
            ],
          )),
    );
  }

  Future<dynamic> filter() {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.82,
            // width: MediaQuery.of(context).size.width * 0.955,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 5,
                  width: 40,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(children: [
                    const CustomerSpacer(
                      height: 25,
                    ),
                    Text(
                      "Filter",
                      style: appstyle(40, Colors.black, FontWeight.bold),
                    ),
                    const CustomerSpacer(
                      height: 25,
                    ),
                    Text(
                      "Gender",
                      style: appstyle(20, Colors.black, FontWeight.bold),
                    ),
                    const Row(
                      children: [
                        CategoryBtn(label: 'Men', buttonClr: Colors.black),
                        CategoryBtn(label: 'Women', buttonClr: Colors.grey),
                        CategoryBtn(label: 'Kids', buttonClr: Colors.grey)
                      ],
                    ),
                    const CustomerSpacer(
                      height: 25,
                    ),
                    Text(
                      "Category",
                      style: appstyle(20, Colors.black, FontWeight.bold),
                    ),
                    const Row(
                      children: [
                        CategoryBtn(label: 'Shoes', buttonClr: Colors.grey),
                        CategoryBtn(
                            label: 'Appararels', buttonClr: Colors.black),
                        CategoryBtn(
                            label: 'Accessories', buttonClr: Colors.grey)
                      ],
                    ),
                    const CustomerSpacer(height: 20),
                    Text(
                      "Price",
                      style: appstyle(20, Colors.black, FontWeight.bold),
                    ),
                    Slider(
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey,
                      thumbColor: Colors.black,
                      max: 500,
                      divisions: 50,
                      value: _value.toDouble(),
                      label: _value.toString(),
                      secondaryTrackValue: 200,
                      onChanged: (newValue) {
                        setState(() {
                          _value = newValue;
                          print('value is ${_value}');
                        });
                      },
                    )
                  ]),
                )
              ],
            ),
          );
        });
  }
}
