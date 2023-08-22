import 'package:flutter/material.dart';

import '../shared/appstyle.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('SearchPage',
            style: appstyle(40, Colors.black, FontWeight.bold)),
      ),
    );
  }
}
