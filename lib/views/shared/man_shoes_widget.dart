import 'package:app/views/shared/new_shoes.dart';
import 'package:app/views/shared/product_card.dart';
import 'package:app/views/shared/product_provider.dart';
import 'package:app/views/ui/product_by_cat.dart';
import 'package:app/views/ui/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:provider/provider.dart';

import '../../models/shoes_model.dart';
import 'appstyle.dart';

class MenShoesWidget extends StatelessWidget {
  const MenShoesWidget({
    super.key,
    required Future<List<Shoes>> male,
    required this.index,
  }) : _male = male;

  final Future<List<Shoes>> _male;

  final int index;
  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);

    return Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.405,
            child: FutureBuilder(
              future: _male,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final male = snapshot.data;
                  return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final shoes = male[index];
                        return GestureDetector(
                          onTap: () {
                            productNotifier.shoesSizes = shoes.sizes;
                            print(shoes.sizes);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                        id: shoes.id,
                                        category: shoes.category)));
                          },
                          child: ProdcutCard(
                              price: '\$${shoes.price}',
                              category: shoes.category,
                              id: shoes.id,
                              name: shoes.name,
                              image: shoes.imageUrl[0]),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            )),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lastest',
                    style: appstyle(24, Colors.black, FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProdcutByCat(
                                    tabIndex: index,
                                  )));
                    },
                    child: Row(
                      children: [
                        Text(
                          'Show all',
                          style: appstyle(22, Colors.black, FontWeight.w500),
                        ),
                        Icon(
                          AntDesign.caretright,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.123,
              child: FutureBuilder(
                future: _male,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final male = snapshot.data;
                    return ListView.builder(
                        itemCount: male!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductPage(
                                            id: snapshot.data![index].id,
                                            category: snapshot
                                                .data![index].category)));
                              },
                              child: NewShoes(
                                  imageUrl: snapshot.data![index].imageUrl[1]),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
