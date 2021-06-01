import 'package:alb/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alb/pages/accueil/article.dart';
import 'package:alb/pages/accueil/espace_redaction.dart';
import 'package:alb/pages/accueil/parametres.dart';
import 'package:alb/pages/accueil/tous_les_articles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Accueil extends StatefulWidget {
  Accueil({Key? key}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  bool? isAdmin = false;

  @override
  void initState() {
    super.initState();
    getAllSavedData();
  }

  getAllSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAdmin = prefs.getBool("modeAdmin");
    if (isAdmin == null) {
      isAdmin = false;
    } else
      print(isAdmin);
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Accueil',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 36,
                )),
            elevation: 3.0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Image(
                    image: AssetImage('assets/logos/person.png'),
                    width: 45,
                    height: 45,
                  ),
                  onPressed: () { Scaffold.of(context).openDrawer(); },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              }
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Parametres())),
                child: Image(
                  image: AssetImage('assets/logos/logo_alb.png'),
                  width: 45,
                  height: 45,
                ),
              ),
            ],
            bottom: PreferredSize(
                child: Container(
                  color: Colors.black,
                  height: 1.0,
                ),
                preferredSize: Size.fromHeight(4.0)),
          ),
          body: SingleChildScrollView(
            child: Container(
                child: Column(children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 320,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('article')
                          .orderBy('date', descending: true)
                          .limit(2)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: SizedBox(
                                height: 150,
                                child: Container(
                                    decoration: new BoxDecoration(
                                      color: Color.fromRGBO(56, 105, 162, 1.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromRGBO(10, 10, 10, 0.25),
                                          blurRadius: 2.0,
                                          spreadRadius: -4.0,
                                          offset: Offset(3.0, 5.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12, top: 8.0, right: 12),
                                            child: Text(
                                                document['titre'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24)),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, right: 15.0),
                                              child: Text(
                                                  document['texte'],
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, top: 8),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: SizedBox(
                                              height: 30,
                                              width: 120,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromRGBO(
                                                      255, 64, 0, 1.0),
                                                  onPrimary: Colors.white,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                ),
                                                onPressed: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Article(
                                                                titre: document
                                                                        [
                                                                    'titre']))),
                                                child: Text("Lire la suite",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 18.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 30,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(66, 66, 66, 1.0),
                        onPrimary: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                      ),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TousLesArticles())),
                      child: Text("Voir tous les articles",
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isAdmin!,
                child: Padding(
                  padding: const EdgeInsets.only(right: 18.0, bottom: 18),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: 30,
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(66, 66, 66, 1.0),
                          onPrimary: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                        ),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EspaceRedaction())),
                        child: Text("Espace rédaction",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                    ),
                  ),
                ),
              )
            ])
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Aéroclub Limoges Bellegarde'),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Se déconnecter'),
                onTap: () {
                  context.read<AuthenticationService>().signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
