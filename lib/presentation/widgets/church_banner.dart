import 'package:flutter/material.dart';

class ChurchBanner extends StatelessWidget {
  const ChurchBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/church.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}