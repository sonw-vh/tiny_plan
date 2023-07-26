import 'package:tiny_plan/services/auth.dart';
import 'package:tiny_plan/services/firestore_service.dart';
import 'package:tiny_plan/services/geo_locator_service.dart';

abstract class Database {
 
}

// String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({
    required this.uid,
    this.auth,
  }) : assert(uid != null);

  final String uid;
  final AuthBase? auth;

  final _service = FirestoreService.instance;
  GeoLocatorService geo = GeoLocatorService();
}