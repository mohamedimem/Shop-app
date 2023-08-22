import 'package:app/views/shared/stagger_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../models/shoes_model.dart';
import '../ui/product_details.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required Future<List<Shoes>> male,
  }) : _male = male;

  final Future<List<Shoes>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _male,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final male = snapshot.data;
          return StaggeredGridView.countBuilder(
            staggeredTileBuilder: (index) => StaggeredTile.extent(
                (index % 2 == 0) ? 1 : 1,
                (index % 4 == 1 || index % 4 == 3)
                    ? MediaQuery.of(context).size.height * 0.35
                    : MediaQuery.of(context).size.height * 0.3),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 20,
            itemBuilder: (context, index) {
              final shoes = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(
                                id: snapshot.data![index].id,
                                category: snapshot.data![index].category)));
                  },
                  child: StaggerTile(
                      imageUrl: shoes.imageUrl[1],
                      name: shoes.name,
                      price: shoes.price),
                ),
              );
            },
            itemCount: male!.length,
            scrollDirection: Axis.vertical,
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
