import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../widget/loadin_mtn.dart';

class CheckoutWave extends StatefulWidget {
  int montant;
  CheckoutWave({Key? key, required this.montant}) : super(key: key);

  @override
  State<CheckoutWave> createState() => _CheckoutWaveState();
}

class _CheckoutWaveState extends State<CheckoutWave> with WidgetsBindingObserver {

  bool switchValue = false;
  String payStatus = "nostate";
  bool push = false;

  String opId = "";

  Timer timer = Timer.periodic(Duration(seconds: 0), (timer) { });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Résumé'),
        centerTitle: true,
        foregroundColor: const Color(0xff005031),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.width / 1.5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff1dc8ff),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 5.5,
                      height: MediaQuery.of(context).size.width / 5.5,
                      decoration: const BoxDecoration(
                        // shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage('assets/images/wave.png'))),
                      // child: Image.asset('assets/images/wave.png', height: 1 ^                                 50, fit: B oxFit.fitHeight, width: 150)
                    ),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                SizedBox(height: 30,),
                    // Container(
                    //   padding: const EdgeInsets.all(8.0),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(100),
                    //       color: Colors.white
                    //   ),
                    //   child:  Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       const Icon(Icons.phone_android_rounded, color: Colors.grey,),
                    //       const SizedBox(width: 10,),
                    //       Text(widget.numero, style: const TextStyle(color: Colors.grey),)
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Montant à recharger'),
                    Text('${widget.montant} FCFA', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Frais lidar (2%)'),
                    Text('${((widget.montant * 2)/100).ceil()} FCFA', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Montant total'),
                    Text('${switchValue ? widget.montant + ((widget.montant * 2)/100).ceil() : widget.montant - ((widget.montant * 2)/100).ceil()} FCFA', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Payer les frais'),
                    Switch(
                      activeColor: const Color(0xff005031),
                      activeTrackColor: const Color(0xff005031).withOpacity(0.4),
                      // inactiveTrackColor: Colors.grey,
                      inactiveThumbColor: const Color(0xfffbcb04),
                      value: switchValue,
                      onChanged: (value) => setState(() {
                        this.switchValue = value;
                      }),)
                  ],
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20.0,),
          Visibility(
            visible: push,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text(payStatus.toLowerCase().contains('nostate') ? 'chargement' :  payStatus.toLowerCase().contains('processing') ? 'en attente de confirmation' : payStatus.toLowerCase().contains('failed') ? 'opération échouée' : 'opération réussie', style: TextStyle(color: payStatus.toLowerCase().contains('nostate') ? Color(0xff005031) :  payStatus.toLowerCase().contains('pending') ? Color(0xff005031) : payStatus.toLowerCase().contains('failed') ? Colors.red : Colors.green, fontStyle: FontStyle.italic),),
                  const SizedBox(width: 10,),
                  payStatus.toLowerCase().contains('nostate') ? SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(

                      color: payStatus.toLowerCase().contains('nostate') ? const Color(0xff005031) :  payStatus.toLowerCase().contains('processing') ? Color(0xff005031) : payStatus.toLowerCase().contains('failed') ? Colors.red : Colors.green,
                    ),
                  ) :  payStatus.toLowerCase().contains('processing') ? SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(

                      color: payStatus.toLowerCase().contains('nostate') ? Color(0xff005031) :  payStatus.toLowerCase().contains('processing') ? Color(0xff005031) : payStatus.toLowerCase().contains('failed') ? Colors.red : Colors.green,
                    ),
                  ) : payStatus.toLowerCase().contains('failed') ? Icon(Icons.info_rounded, color: Colors.red,) : Icon(Icons.check_circle_sharp, color: Colors.green,)
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(push ? Colors.grey.withOpacity(0.5) : Color(0xff005031)),
                      foregroundColor: MaterialStatePropertyAll(push ? Colors.grey : Colors.white)
                  ),
                  onPressed: () {
                    if (!push) {
                      setState(() {
                        push = true;
                      });
                      checkoutSession(switchValue ? (widget.montant + ((widget.montant * 2)/100).ceil()).toInt().toString() : (widget.montant - ((widget.montant * 2)/100).ceil()).toInt().toString());
                    }
                    null;
                  }, child: Text('CONFIRMER')),
            ),
          ),
          const SizedBox(height: 20.0,),
          Image.asset(
            'assets/images/lidar_logo.png',
            height: MediaQuery.of(context).size.width / 15,
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(height: 20.0,)
        ],
      ),
    );
  }

  void setTimer(bool isBackground, {String ref = ""}) {
    int delaySeconds = isBackground ? 5 : 3;
    log("timer");
    getId().then((value){
      timer.cancel();
      timer = Timer.periodic(Duration(seconds: delaySeconds), (t) async {
        // Not sending a request, if waiting for response

        if (payStatus.toLowerCase().contains('processing')) {
          await checkPaySatus(value);
        }
      });
    });
    // Cancelling previous timer, if there was one, and creating a new one

  }

  Future<void> rechargementLidar(int senderId, int receiverId, int montant) async {

    var request = http.Request('POST', Uri.parse('https://stageapi.lidar-platform.com/v1.4/operations.json'));
    request.body = json.encode({
      "statut": 1,
      "level": 0,
      "service_id": 28,
      "source": "app lidar 2pai",
      "montant": 1000000,
      "description": "Rechargement en monnaie électronique",
      "operation_sender": {
        "carte_id": 1
      },
      "operation_receiver": {
        "carte_id": 58
      }
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      /*
      {
        "balance": 0,
        "currencyCode": "string"
      }
       */
      var stream = json.decode(await response.stream.bytesToString());

    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future<String> checkPaySatus(String id) async {
    String msg = '';

    // var uuid = const Uuid();

    try {
      var body = {
        "identifiant": id,
      };

      // log(body.toString());

      String url = 'https://gateway.lidar-platform.com/api/wave/checkstatut.json';
      final res = await http.post(Uri.parse(url), body: body);
      // log(res.body);
      if (res.statusCode == 200) {
        var sessionObject = json.decode(res.body)['response'];
        setState(() {
          payStatus = sessionObject['payment_status'];

        });
        log(payStatus);

        if(payStatus == "successful"){

        }
        // final prefs = await SharedPreferences.getInstance();

        setTimer(false, ref: id);
      } else {
        msg = "server";
        log('Erreur : ${res.body}');
      }
    } on Exception catch (e) {
      msg = "no internet";
      print('e : $e');
    }

    return msg;
  }

  Future<String> checkoutSession(String amount) async {
    String msg = '';

    try {
      // var headers = {'Authorization': '', 'Content-Type': 'application/json'};

      var body = {
        "amount": amount,
        "currency": "XOF",
        "phone_id": "1"
      };

      String url = 'https://gateway.lidar-platform.com/api/wave/checkout.json';
      final res = await http.post(Uri.parse(url), body: body);
      // print(res.body);
      if (res.statusCode == 200) {
        var sessionObject = json.decode(res.body)['response'];
        if (!sessionObject.toString().contains('code')) {
          msg = "ok";
          _launchUrl(sessionObject['wave_launch_url']);
          setState(() {
            opId = sessionObject['id'];
          });
          storeId(sessionObject['id']);
          checkPaySatus(sessionObject['id']);


        } else {
          msg = "token";
        }
        // print(res.body);
      } else {
        msg = "server";
        print('Erreur : ${res.body}');
      }
    } on Exception catch (e) {
      msg = "no internet";
      print('e : $e');
    }

    return msg;
  }

  Future<void> storeId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('opId', id);
    await prefs.commit();
  }

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    log(prefs.getString('opId')!);
    return prefs.getString('opId')!;
  }

  Future<void> _launchUrl(String url) async {
    if(await canLaunchUrl(Uri.parse(url))){
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }else{
      throw Exception('Could not launch $url');
    }
  }
}

/*

{"id": "cos-1ctffam6023r0", "amount": "200", "checkout_status": "expired", "client_reference": null, "currency": "XOF", "error_url": "https://pay.lidar-platform.com/#/error", "last_payment_error": null, "business_name": "Lidar", "payment_status": "cancelled", "success_url": "https://pay.lidar-platform.com/#/success", "wave_launch_url": "https://pay.wave.com/c/cos-1ctffam6023r0?a=200&c=XOF&m=Lidar", "when_completed": null, "when_created": "2023-02-07T09:25:46Z", "when_expires": "2023-02-07T09:55:46Z"}

 */
