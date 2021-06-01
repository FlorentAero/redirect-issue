import 'package:alb/authentication_service.dart';
import 'package:alb/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Mot de passe",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                openSignIn(context);
                context.read<AuthenticationService>().signUp(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(), 
                );
              },
              child: Text("S'inscrire")
            )
          ],
        ),
      )
    );
  }
}

openSignIn(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) =>
            SignInPage()
    )
  );
}