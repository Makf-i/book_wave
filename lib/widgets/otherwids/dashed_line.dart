import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({
    super.key,
    required this.qty,
    required this.mrg,
    required this.dashHeight,
    required this.dashWidth,
    this.color = Colors.grey,
  });

  final int qty;
  final double mrg; //space between the generated small line
  final double dashHeight;
  final double dashWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(
      children: List.generate(qty, (index) {
        return Container(
          width: dashWidth,
          height: dashHeight,
          color: color,
          margin: EdgeInsets.symmetric(horizontal: mrg),
        );
      }),

      // List.generate(30, (index) {
      //   return Container(
      //     width: 2.0,
      //     height: 1.0,
      //     color: Colors.grey,
      //     margin: EdgeInsets.symmetric(horizontal: 1),
      //   );
      // }
    ));
  }
}
