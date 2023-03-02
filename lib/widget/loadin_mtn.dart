import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoadingMtn extends StatefulWidget {
  String reference;
  LoadingMtn({Key? key, required this.reference}) : super(key: key);

  @override
  State<LoadingMtn> createState() => _LoadingMtnState();
}

class _LoadingMtnState extends State<LoadingMtn> with WidgetsBindingObserver {

  late Timer timer;
  bool waitingForResponse = false;
  String status = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Adding an observer
    // setTimer(false);  // Setting a timer on init
  }

  @override
  void dispose() {
    timer.cancel();  // Cancelling a timer on dispose
    WidgetsBinding.instance.removeObserver(this); // Removing an observer
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setTimer(state != AppLifecycleState.resumed);
  }

  void setTimer(bool isBackground) {
    int delaySeconds = isBackground ? 5 : 3;

    // Cancelling previous timer, if there was one, and creating a new one
    timer.cancel();
    timer = Timer.periodic(Duration(seconds: delaySeconds), (t) async {
      // Not sending a request, if waiting for response
      if (!waitingForResponse) {
        waitingForResponse = true;
        await post();
        waitingForResponse = false;
      }
    });
  }

  // Async method returns Future<> object
  Future<void> post() async {
    String url = 'https://gateway.lidar-platform.com/api/mtn/auth.json';
    final res = await http.post(Uri.parse(url));

    if(res.statusCode == 200){
      var resp = json.decode(res.body)['response'];

      log(resp.toString());

      setState(() {
        status = resp['status'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20.0,),
          status.toLowerCase().contains('pending') ? CircularProgressIndicator() : status.toLowerCase().contains('failed') ? Icon(Icons.cancel_rounded, size: 45, color: Colors.red,) : Icon(Icons.check_circle_rounded, size: 45, color: Colors.green,),
          const SizedBox(height: 30.0,),
          status.toLowerCase().contains('pending') ? Text('Traitement de la transaction') : status.toLowerCase().contains('failed') ? Text('Echec de la transaction') : Text('Rechargement effectué'),
          const SizedBox(height: 20.0,),
        ],
      ),
    );
  }
}
