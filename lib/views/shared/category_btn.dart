import 'package:app/views/shared/appstyle.dart';
import 'package:flutter/material.dart';

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({super.key, required this.label, required this.buttonClr});

  final String label;
  final Color buttonClr;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.255,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
                width: 1, color: buttonClr, style: BorderStyle.solid)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: Text(
              label,
              style: appstyle(15, buttonClr, FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
