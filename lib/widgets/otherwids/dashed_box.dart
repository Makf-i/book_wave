import 'package:flutter/material.dart';

class DashedBox extends StatelessWidget {
  const DashedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: IntrinsicWidth(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top dashed line
                Row(
                  children: List.generate(
                    30,
                    (index) {
                      return Container(
                        width: 2.0,
                        height: 1.0,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                      );
                    },
                  ),
                ),
                // Middle part of the box
                Expanded(
                  child: Row(
                    children: [
                      // Left dashed line
                      Column(
                        children: List.generate(
                          30,
                          (index) {
                            return Container(
                              width: 1.0,
                              height: 2.0,
                              color: Colors.grey,
                              margin: const EdgeInsets.symmetric(vertical: 1),
                            );
                          },
                        ),
                      ),
                      // Empty space inside the box
                      const Expanded(
                        child: SizedBox.shrink(),
                      ),
                      // Right dashed line
                      Column(
                        children: List.generate(
                          30,
                          (index) {
                            return Container(
                              width: 1.0,
                              height: 2.0,
                              color: Colors.grey,
                              margin: const EdgeInsets.symmetric(vertical: 1),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Bottom dashed line
                Row(
                  children: List.generate(
                    30,
                    (index) {
                      return Container(
                        width: 2.0,
                        height: 1.0,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
