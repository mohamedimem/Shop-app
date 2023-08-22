import 'package:app/views/shared/appstyle.dart';
import 'package:app/views/shared/check_out_btn.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});
  final _cartBox = Hive.box('cart_box');

  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  List<dynamic> cart = [];
  @override
  Widget build(BuildContext context) {
    final cartData = widget._cartBox.keys.map(
      (e) {
        final item = widget._cartBox.get(e);
        return {
          "key": e,
          "id": item['id'],
          "category": item['category'],
          "name": item['name'],
          "imageUrl": item['imageUrl'],
          "price": item['price'],
          "qty": item['qty'],
          "sizes": item["sizes"],
        };
      },
    ).toList();
    cart = cartData.reversed.toList();
    return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                    onTap: () {},
                    child: Icon(
                      AntDesign.close,
                      color: Colors.black,
                    )),
                Text(
                  "My Cart",
                  style: appstyle(36, Colors.black, FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final data = cart[index];
                        print(data['sizes']);

                        return Container(
                          padding: EdgeInsets.all(16),
                          child: ClipRRect(
                            child: Slidable(
                              key: ValueKey(0),
                              endActionPane:
                                  ActionPane(motion: ScrollMotion(), children: [
                                SlidableAction(
                                  icon: Icons.delete,
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.black,
                                  flex: 1,
                                  onPressed: (context) {
                                    widget._cartBox.deleteAt(0);
                                  },
                                ),
                              ]),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      spreadRadius: 5,
                                      blurRadius: 0.3,
                                      offset: Offset(0, 1),
                                    )
                                  ],
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: CachedNetworkImage(
                                        imageUrl: data['imageUrl'][0],
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 12, left: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  data['name'],
                                                  style: appstyle(
                                                      16,
                                                      Colors.black,
                                                      FontWeight.bold),
                                                ),
                                                Text(
                                                  data['category'],
                                                  style: appstyle(
                                                      16,
                                                      Colors.grey,
                                                      FontWeight.bold),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      data['price'],
                                                      style: appstyle(
                                                          16,
                                                          Colors.black,
                                                          FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      width: 24,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Size :",
                                                          style: appstyle(
                                                              16,
                                                              Colors.black,
                                                              FontWeight.w600),
                                                        ),
                                                        Text(
                                                          data['sizes']['size'],
                                                          style: appstyle(
                                                              16,
                                                              Colors.black,
                                                              FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(16))),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Icon(
                                                      AntDesign.minussquare,
                                                      size: 20,
                                                      color: Colors.grey,
                                                    ),
                                                    Text(
                                                      data['qty'].toString(),
                                                      style: appstyle(
                                                          12,
                                                          Colors.black,
                                                          FontWeight.normal),
                                                    ),
                                                    Icon(AntDesign.plussquare,
                                                        size: 20,
                                                        color: Colors.black),
                                                  ]),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                CheckOutButton(label: "Proceed to Checkout")
              ],
            )
          ],
        ));
  }
}
