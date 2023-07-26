import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tiny_plan/app/adventurer/adventurer_home.dart';
import 'package:tiny_plan/app/guild_master/guildmaster_home.dart';
import 'package:tiny_plan/app/signin/sign_in_screen.dart';
import 'package:tiny_plan/services/auth.dart';
import 'package:tiny_plan/services/database.dart';
import 'package:tiny_plan/services/geo_locator_service.dart';
import 'package:tiny_plan/services/shared_preferences.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late bool _isGuildMaster;
  late GeoLocatorService geoService;

  ///In order to pass this value auth declared in the [STATE] for Stateful classes
  ///to the actual LandingPage widget
  ///we need to use the key word [widget.auth]
  @override
  void initState() {
    setFlagAdventurerOrGuildMaster();
    geoService = Provider.of<GeoLocatorService>(context, listen: false);
    super.initState();
  }

  ///Function to set sharedPreference On [Parent or Child] devices
  Future<void> setFlagAdventurerOrGuildMaster() async {
    var isGuildMaster = await SharedPreference().getAdventurerOrGuildMaster();
    setState(() {
      _isGuildMaster = isGuildMaster;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User?>(

        ///auth.authStateChanges is the stream  declared in the [auth.dart] class
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return SignInPage.create(context);
            }

            /// Here we have added a provider [Database] as a parent of the Parent
            /// Page
            switch (_isGuildMaster) {
              /// THIS CASE SET THE APP AS A PARENT APP
              case true:
                return Provider<Database>(
                    create: (_) => FirestoreDatabase(uid: user.uid),

                    ///Here the ShowCaseWidget triggers the Showcase view and passes the context
                    child: FutureProvider(
                      initialData: null,
                      create: (context) => geoService.getInitialLocation(),
                      child: ShowCaseWidget(
                        builder: Builder(
                            builder: (context) =>
                                GuildMasterHome.create(context, auth)),
                        autoPlay: false,

                        //autoPlayDelay: Duration(seconds: 3),
                        // autoPlayLockEnable: true,
                      ),
                    ));
              case false:

                return Provider<Database>(
                  create: (_) => FirestoreDatabase(uid: user.uid),

                  ///Here the ShowCaseWidget triggers the Showcase view and passes the context
                  child: FutureProvider(
                    initialData: null,
                    create: (context) => geoService.getInitialLocation(),
                    child: ShowCaseWidget(
                      builder: Builder(
                          builder: (context) =>
                              AdventurerHome.create(context, auth)),
                      autoPlay: false,

                      //autoPlayDelay: Duration(seconds: 3),
                      // autoPlayLockEnable: true,
                    ),
                  ));
              default:
                return CircularProgressIndicator();
            }
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}