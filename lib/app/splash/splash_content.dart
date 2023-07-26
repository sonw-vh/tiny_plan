import 'package:flutter/material.dart';
import 'package:tiny_plan/widgets/size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Safe kid",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(25),
                      color: Colors.indigo.shade400,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Image.asset('images/png/VNPT_Logo.png',
                      width: 36, height: 36),
                ],
              ),
              SizedBox(height: 8),
              Text(
                text,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.35),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Image.asset(
          image,
          height: getProportionateScreenHeight(220),
          width: getProportionateScreenWidth(135),
        ),
      ],
    );
  }
}
