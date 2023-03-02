import 'package:appdepotlidar/main.dart';
import 'package:appdepotlidar/screen/historique.dart';
import 'package:appdepotlidar/screen/mainScreen.dart';
import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'manage_account.dart';

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {


  final drawerController = AwesomeDrawerBarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AwesomeDrawerBar(
        controller: drawerController,
        type: StyleState.scaleRight,
        menuScreen: menuScreen(),
        mainScreen: MainScreen(awesomeDrawerBar: drawerController,),
        borderRadius: 24.0,
        showShadow: true,
        angle: 0.0,
        backgroundColor: Colors.grey[300]!,
        slideWidth: MediaQuery.of(context).size.width * .75,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
      ),
    );
  }



  Widget menuScreen() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/lidar_logo.png',
              height: MediaQuery.of(context).size.width / 5,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(height: 30,),
            Divider(
              height: 1,
            ),
            ListTile(
              leading: Icon(Icons.home_rounded),
              title: Text('Dashboard'),
              onTap: () {
                drawerController.toggle!();
              },
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text('Gérer mon compte'),
              onTap: () {
                drawerController.toggle!();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageAccount(),));
              },
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              leading: Icon(Icons.history_rounded),
              title: Text('Mon historique'),
              onTap: () {
                drawerController.toggle!();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Historique(),));
              },
            ),
            Divider(
              height: 1,
            ),
            SizedBox(height: 50,),
            ListTile(
              leading: Icon(Icons.logout_rounded),
              title: Text('Me déconnecter'),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }

}
