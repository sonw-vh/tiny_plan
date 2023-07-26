import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiny_plan/app/signin/sign_in_manager.dart';
import 'package:tiny_plan/controllers/services/auth.dart';
import 'package:tiny_plan/theme/theme.dart';
import 'package:tiny_plan/widgets/custom_raised_button.dart';
import 'package:tiny_plan/widgets/show_exeption_alert.dart';

class SignInPage extends StatelessWidget {
  SignInPage({
    Key? key,
    required this.manager,
    required this.isLoading,
  }) : super(key: key);
  final SignInManager manager;
  final bool isLoading;

  ///Here we had the provider wrapping the Sign in Page
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (_, manager, __) => SignInPage(
              manager: manager,
              isLoading: isLoading.value,
            ),
          ),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseAuthException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(context,
        title: 'Sign in Failed', exception: exception);
  }

  ///Future void Function called to Sign In Anonymously
  Future<void> _signInAnonymously(BuildContext context) async {
    print("SIGNIN =>");
    try {
      await manager.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  ///Future void Function called to Sign In with Google
  Future<void> _signInWithGoogle(BuildContext context) async {
    print("SIGNIN WITH GG =>");
    try {
      await manager.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 180.0, child: _buildHeader()),
            SizedBox(height: 28.0),
            CustomRaisedButton(
              color: Colors.white ?? ThemeColor.shadow,
              onPressed:  () => isLoading ? null : _signInWithGoogle(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('images/google_logo.png'),
                  Text(
                    'Sign In with Google',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Opacity(
                    opacity: 0.0,
                    child: Image.asset('images/google_logo.png'),
                  ),
                ],
              )
            ),
            SizedBox(height: 8.0),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Image.asset(
      'images/splash_svg/clip-sign-up.png',
    );
  }
}
