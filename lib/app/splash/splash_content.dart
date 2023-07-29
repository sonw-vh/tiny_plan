import 'package:flutter/material.dart';
import 'package:tiny_plan/widgets/size_config.dart';
import 'package:tiny_plan/theme/theme.dart';

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
                    "Tiny Plan",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(25),
                      color: ThemeColor.shadow,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "@unihackervjppro",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                      color: ThemeColor.shadow,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                text,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.35),
                    fontSize: 13,
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
