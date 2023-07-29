import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_plan/app/landing_screen.dart';
import 'package:tiny_plan/app/splash/splash_content.dart';
import 'package:tiny_plan/widgets/size_config.dart';
import 'package:tiny_plan/controllers/services/shared_preferences.dart';
import 'package:tiny_plan/theme/theme.dart';

class SplashScreen extends StatefulWidget {
  final BuildContext? context;

  const SplashScreen({Key? key, this.context}) : super(key: key);

  static Widget create(BuildContext context) {
    return SplashScreen(context: context);
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;

  List<Map<String, String>> splashData = [
    {
      'text': 'Vui tung tăng hớn hở, em làm kế hoạch nhỏ\n'
          'Lượm giấy trồng cây chi đội ta có ngay \n'
          'Giấy thu về đây ơi là bao bướm bay\n',
      'image': 'assets/splash/splash1.png'
    },
    {
      'text': 'Như con ong chăm chỉ, như chim non vui vẻ\n'
          'Em làm kế hoạch nhỏ\n'
          'Bắt tay vào việc, em càng vui càng say \n',
      'image': 'assets/splash/splash2.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    image: splashData[index]['image']!,
                    text: splashData[index]['text']!,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: <Widget>[
                      Spacer(flex: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 100,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          ThemeColor.dust)),
                              onPressed: () {
                                SharedPreference().setVisitingFlag();
                                SharedPreference().setAdventurerDevice();

                                print(
                                    'The page is set to Adventurer => now moving ......');
                                Navigator.of(context).pushReplacement(
                                    CupertinoPageRoute(
                                        builder: (context) => LandingScreen()));
                              },
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(fit: BoxFit.fitHeight, image: AssetImage('assets/avatars/adventurer.png')),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    'Adventurer',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ThemeColor.shadow,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  )
                                ],
                              )
                            ),
                          ),

                          ///-------------------------------------------------------------------
                          Container(
                            height: 100,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          ThemeColor.dust)),
                              onPressed: () {
                                SharedPreference().setVisitingFlag();
                                SharedPreference().setGuildMasterDevice();
                                print(
                                    'The page is set to Guild Master => now moving ......');
                                Navigator.of(context).pushReplacement(
                                    CupertinoPageRoute(
                                        builder: (context) => LandingScreen()));
                              },
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(fit: BoxFit.fitHeight, image: AssetImage('assets/avatars/guildmaster.png')),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    'Guild Master',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ThemeColor.shadow,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  )
                                ],
                              )
                            ),
                          ),
                        ],
                      ),
                      Spacer(flex: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ? ThemeColor.leaf
            : ThemeColor.sand,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
