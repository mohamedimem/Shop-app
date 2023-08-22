import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomerSpacer extends StatelessWidget {
  const CustomerSpacer({super.key, required this.height});

  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
