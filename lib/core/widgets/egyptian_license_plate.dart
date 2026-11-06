import 'package:flutter/material.dart';

/// Authentic Egyptian Vehicle License Plate Component
/// Matching Figma Node `21:4791` & `21:4792`
class EgyptianLicensePlateWidget extends StatelessWidget {
  final String letters;
  final String numbers;
  final double width;
  final double height;

  const EgyptianLicensePlateWidget({
    super.key,
    this.letters = 'س ق د',
    this.numbers = '٦ ٩ ٤',
    this.width = 130,
    this.height = 54,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF1E293B), width: 1.8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x15000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Blue Egyptian Bar
          Container(
            height: height * 0.35,
            decoration: const BoxDecoration(
              color: Color(0xFF0284C7), // Egyptian Standard Blue
              borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'مصر',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                Text(
                  'EGYPT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          // Plate Numbers and Letters Row
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Arabic Letters
                    Text(
                      letters,
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        letterSpacing: 1.5,
                      ),
                    ),
                    // Divider
                    Container(
                      width: 1.2,
                      height: 18,
                      color: const Color(0xFFCBD5E1),
                    ),
                    // Arabic Numbers
                    Text(
                      numbers,
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
