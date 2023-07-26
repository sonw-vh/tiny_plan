import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User? get currentUser;

  Future<User> signInAnonymously();

  Future<String> setToken();

  Future<void> signOut();

  Stream<User?> authStateChanges();

  Future<User> signInWithGoogle();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late String _token;

  String get token => _token;

  ///Streams allow us to control all changes applied
  ///The stream is declare as follow final controller = StreamController();
  ///controller.sink.add() adds value to the stream
  ///controller.stream.listen gets the values.
  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  /// This code is used to get the current user after The User has Logged in
  @override
  User? get currentUser => _firebaseAuth.currentUser;

  ///Sign In Anonymously Method
  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user!;
  }

  ///Sign In with Google Method
  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return userCredential.user!;
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google Id Token',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  Future<String> setToken() async {
    try {
      await _firebaseMessaging.getToken().then((token) {
        _token = token!;
        print('Device Token: $_token');
      });
    } catch (e) {
      print(e);
    }
    return _token;
  }

  ///Sign Out Method from Firebase and Google
  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}

