import 'package:alb/authentication_service.dart';
import 'package:alb/signin.dart';
import 'package:alb/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200.0, bottom: 25.0),
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Image(
                    image: AssetImage('assets/logos/logo_alb.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(222, 232, 246, 1.0),
                      onPrimary: Color.fromRGBO(55, 55, 55, 1.0),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                    ),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignInPage())),
                    child: Text("Se connecter", style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(222, 232, 246, 1.0),
                      onPrimary: Color.fromRGBO(55, 55, 55, 1.0),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                    ),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage())),
                    child: Text("S'inscrire", style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
