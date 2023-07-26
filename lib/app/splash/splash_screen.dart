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
      'text': 'The perfect tool to control apps and monitor the time\n'
          'Your kids spend on screen. Easy to use ! \n'
          'Start by setting up your device then set up\n your kid\'s phone',
      'image': ''
    },
    {
      'text': '  \n '
          ' \n . ',
      'image': ''
    },
    {
      'text':
          ".",
      'image': ''
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
                            height: 40,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          ThemeColor.shadow)),
                              onPressed: () {
                                SharedPreference().setVisitingFlag();
                                SharedPreference().setGuildMasterDevice();
                                print(
                                    'The page is set to Guild Master => now moving ......');
                                Navigator.of(context).pushReplacement(
                                    CupertinoPageRoute(
                                        builder: (context) => LandingScreen()));
                              },
                              child: Image.asset(
                                'assets/avatars/guildmaster.png'
                              )
                            ),
                          ),

                          ///-------------------------------------------------------------------
                          Container(
                            height: 40,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          ThemeColor.shadow)),
                              onPressed: () {
                                SharedPreference().setVisitingFlag();
                                SharedPreference().setAdventurerDevice();

                                print(
                                    'The page is set to Adventurer => now moving ......');
                                Navigator.of(context).pushReplacement(
                                    CupertinoPageRoute(
                                        builder: (context) => LandingScreen()));
                              },
                              child: Image.asset(
                                'assets/avatars/adventurer.png'
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
