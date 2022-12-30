import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase/supabase.dart';
import 'package:utility_manager_flutter/utils/constants.dart';
import 'package:utility_manager_flutter/widgets/rounded_button.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  Future<void> _signin() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: error.toString());
    }
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          children: [
            Lottie.asset('assets/email.json'),
            // Text(
            //   'Sign in via the magic link with your email',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 20,
            //   ),
            // ),
            // SizedBox(height: 18),
            TextFormField(
              controller: _emailController,
              decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                hintText: 'Email',
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 18),
            TextFormField(
              controller: _passwordController,
              decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                hintText: 'Password',
              ),
              style: TextStyle(color: Colors.white),
            ),
            RoundedButtonWidget(
              buttonText: 'Sign in',
              width: MediaQuery.of(context).size.width * 0.80,
              onpressed: _signin,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/signup', (route) => false);
              },
              child: const Text('Create Account'),
            )
          ],
        ),
      ),
    );
  }
}
