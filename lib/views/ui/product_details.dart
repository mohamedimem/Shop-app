import 'package:app/services/helper.dart';
import 'package:app/views/shared/appstyle.dart';
import 'package:app/views/shared/product_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../models/shoes_model.dart';
import '../shared/check_out_btn.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<Shoes> _men;
  final PageController pageController = PageController();
  final _cartBox = Hive.box('cart_box');

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    getShoes();
  }

  void getShoes() {
    if (widget.category == "Men's Running") {
      _men = Helper().getMaleShoesById(widget.id);
    } else if (widget.category == "Women's Running") {
      _men = Helper().getFemaleShoesById(widget.id);
    } else {
      _men = Helper().getKidsShoesById(widget.id);
    }
  }

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (context) {
      return FutureBuilder(
        future: _men,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final sneaker = snapshot.data;
            return Consumer<ProductNotifier>(
              builder: (context, productnotfier, child) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                productnotfier.shoeSizes.clear();
                                productnotfier.activePage = 0;
                              },
                              child: Icon(AntDesign.close),
                            ),
                            GestureDetector(
                              child: Icon(Ionicons.ellipsis_horizontal),
                            )
                          ],
                        ),
                      ),
                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery.of(context).size.height,
                      flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width,
                            child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sneaker!.imageUrl.length,
                                controller: _pageController,
                                onPageChanged: (page) {
                                  productnotfier.activePage = page;
                                },
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Positioned(
                                        top: 0,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.grey.shade300,
                                          child: CachedNetworkImage(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            imageUrl: sneaker.imageUrl[index],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          right: 20,
                                          child: Icon(
                                            AntDesign.hearto,
                                            color: Colors.grey,
                                          )),
                                      Positioned(
                                          bottom: 0,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2,
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional.center,
                                            child: Row(
                                                children: List<Widget>.generate(
                                                    sneaker!.imageUrl.length,
                                                    (index) => Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      4),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                productnotfier
                                                                            .activePage !=
                                                                        index
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .black,
                                                            radius: 5,
                                                          ),
                                                        ))),
                                          )),
                                    ],
                                  );
                                }),
                          ),
                          Positioned(
                              bottom: 0,
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.610,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            sneaker.name,
                                            style: appstyle(40, Colors.black,
                                                FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                sneaker.name,
                                                style: appstyle(20, Colors.grey,
                                                    FontWeight.w500),
                                              ),
                                              RatingBar.builder(
                                                initialRating: 4,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 22,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 1),
                                                itemBuilder: (context, index) {
                                                  return Icon(
                                                    Icons.star,
                                                    size: 18,
                                                  );
                                                },
                                                onRatingUpdate: (rating) {},
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$${sneaker.price}",
                                                style: appstyle(
                                                    20,
                                                    Colors.black,
                                                    FontWeight.w600),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Colors",
                                                    style: appstyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor:
                                                        Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor: Colors.red,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Select sizes",
                                                    style: appstyle(
                                                        20,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    "View size guide",
                                                    style: appstyle(
                                                        20,
                                                        Colors.grey,
                                                        FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              SizedBox(
                                                height: 40,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      child: ChoiceChip(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        60),
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .black,
                                                                width: 1,
                                                                style:
                                                                    BorderStyle
                                                                        .solid),
                                                          ),
                                                          label: Text(
                                                            productnotfier
                                                                    .shoeSizes[
                                                                index]['size'],
                                                          ),
                                                          labelStyle: appstyle(
                                                              18,
                                                              productnotfier.shoeSizes[
                                                                          index]
                                                                      [
                                                                      'isSelected']
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              FontWeight.bold),
                                                          onSelected:
                                                              (newState) {
                                                            productnotfier
                                                                .toogleCheck(
                                                                    index);
                                                          },
                                                          selectedColor: Colors
                                                              .grey.shade900,
                                                          selected: productnotfier
                                                                      .shoeSizes[
                                                                  index]
                                                              ['isSelected']),
                                                    );
                                                  },
                                                  itemCount: productnotfier
                                                      .shoeSizes.length,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Divider(
                                                indent: 10,
                                                endIndent: 10,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                child: Text(sneaker.title,
                                                    style: appstyle(
                                                        24,
                                                        Colors.black,
                                                        FontWeight.w700)),
                                              ),
                                              Text(
                                                sneaker.description,
                                                textAlign: TextAlign.justify,
                                                maxLines: 4,
                                                style: appstyle(
                                                    14,
                                                    Colors.black,
                                                    FontWeight.normal),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: CheckOutButton(
                                                  label: 'Add to Cart',
                                                  onTap: () async {
                                                    print('beginer');
                                                    _createCart({
                                                      'id': sneaker.id,
                                                      'name': sneaker.name,
                                                      'category':
                                                          sneaker.category,
                                                      'sizes':
                                                          sneaker.sizes.first,
                                                      'imageUrl':
                                                          sneaker.imageUrl,
                                                      'price': sneaker.price,
                                                      'qty': 1,
                                                    });
                                                  },
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ))),
                        ],
                      )),
                    )
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      );
    }));
  }
}
