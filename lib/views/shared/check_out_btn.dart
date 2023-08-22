import 'package:ant_design_flutter/ant_design_flutter.dart';

import 'appstyle.dart';

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({
    super.key,
    required this.label,
    this.onTap,
  });
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          height: 50,
          child: Center(
              child: Text(
            label,
            style: appstyle(20, Colors.white, FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
