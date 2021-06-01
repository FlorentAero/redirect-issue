import 'package:alb/authentication_service.dart';
import 'package:alb/landing_page.dart';
import 'package:alb/pages/accueil/accueil.dart';
import 'package:alb/pages/avions/avions.dart';
import 'package:alb/pages/copilote/copilote.dart';
import 'package:alb/pages/preparation/preparation.dart';
import 'package:alb/pages/securite/securite.dart';
import 'package:alb/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ALB());
}

class ALB extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),

        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
          initialData: null
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'Roboto',
        ),
        home: AuthenticationWrapper(),
      )
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key? key,
  }) : super(key : key);

  @override 
  Widget build(BuildContext context) {
    return StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasData) {
        return Navigation();
      } else
        return LandingPage();
    });
  }
}

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = [
    Accueil(),
    Avions(),
    Securite(),
    Copilote(),
    Preparation()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: SizedBox(
            height: 70,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset('assets/logos/home.png',
                      height: 40, width: 40),
                  label: 'Accueil',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/logos/plane.png',
                      height: 40, width: 40),
                  label: 'Avions',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/logos/danger.png',
                      height: 40, width: 40),
                  label: 'Sécurité',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/logos/copilote.png',
                      height: 40, width: 40),
                  label: 'Copilote',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/logos/link.png',
                      height: 40, width: 40),
                  label: 'Préparation',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTap,
            )));
  }
}
