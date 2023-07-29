import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiny_plan/controllers/config/screen_controller.dart';
import 'package:tiny_plan/firebase_options.dart';
import 'package:tiny_plan/controllers/services/auth.dart';
import 'package:tiny_plan/controllers/services/geo_locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthBase>(create: (context) => Auth()),
        Provider<GeoLocatorService>(create: (context) => GeoLocatorService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final geoService = Provider.of<GeoLocatorService>(context, listen: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: Future.wait([
            geoService.getInitialLocation(),
            //  apps.getAppUsageService(),
          ]),
          builder: (context, _) => ScreensController()),
    );
  }
}
