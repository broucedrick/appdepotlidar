import 'package:appdepotlidar/screen/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LidarMPay',
      theme: ThemeData(
        primarySwatch: Palette.kToDark,
      ),
      home: const Accueil(),
    );
  }
}

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xff005031, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff00482c),//10%
      100: Color(0xff004027),//20%
      200: Color(0xff003822),//30%
      300: Color(0xff00301d),//40%
      400: Color(0xff002819),//50%
      500: Color(0xff002014),//60%
      600: Color(0xff00180f),//70%
      700: Color(0xff00100a),//80%
      800: Color(0xff000805),//90%
      900: Color(0xff000000),//100%
    },
  );
}