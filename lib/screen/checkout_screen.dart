import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../widget/loadin_mtn.dart';

class CheckoutScreen extends StatefulWidget {
  int montant;
  String numero;
  String reseau;
  CheckoutScreen({Key? key, required this.montant, required this.numero, required this.reseau}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> with WidgetsBindingObserver {

  bool switchValue = false;
  String payStatus = "nostate";
  bool push = false;

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
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xfffbcb04),
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
                              image: AssetImage('assets/images/mtnmomo.png'))),
                      // child: Image.asset('assets/images/wave.png', height: 1 ^                                 50, fit: B oxFit.fitHeight, width: 150)
                    ),
                    const                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            SizedBox(height: 30,),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white
                      ),
                      child:  Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.phone_android_rounded, color: Colors.grey,),
                          const SizedBox(width: 10,),
                          Text(widget.numero, style: const TextStyle(color: Colors.grey),)
                        ],
                      ),
                    )
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
                  Text(payStatus.toLowerCase().contains('nostate') ? 'chargement' :  payStatus.toLowerCase().contains('pending') ? 'en attente de confirmation' : payStatus.toLowerCase().contains('failed') ? 'opération échouée' : 'opération réussie', style: TextStyle(color: payStatus.toLowerCase().contains('nostate') ? Color(0xff005031) :  payStatus.toLowerCase().contains('pending') ? Color(0xff005031) : payStatus.toLowerCase().contains('failed') ? Colors.red : Colors.green, fontStyle: FontStyle.italic),),
                  const SizedBox(width: 10,),
                  payStatus.toLowerCase().contains('nostate') ? SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(

                      color: payStatus.toLowerCase().contains('nostate') ? const Color(0xff005031) :  payStatus.toLowerCase().contains('pending') ? Color(0xff005031) : payStatus.toLowerCase().contains('failed') ? Colors.red : Colors.green,
                    ),
                  ) :  payStatus.toLowerCase().contains('pending') ? SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(

                      color: payStatus.toLowerCase().contains('nostate') ? Color(0xff005031) :  payStatus.toLowerCase().contains('pending') ? Color(0xff005031) : payStatus.toLowerCase().contains('failed') ? Colors.red : Colors.green,
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
                                      checkoutSession(switchValue ? (widget.montant + ((widget.montant * 2)/100).ceil()).toInt() : (widget.montant - ((widget.montant * 2)/100).ceil()).toInt(), widget.numero);
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

    // Cancelling previous timer, if there was one, and creating a new one
    timer.cancel();
    timer = Timer.periodic(Duration(seconds: delaySeconds), (t) async {
      // Not sending a request, if waiting for response
      if (payStatus.toLowerCase().contains('pending')) {
        await checkPaySatus(ref);
      }
    });
  }

  Future<String> checkPaySatus(String ref) async {
    String msg = '';

    var uuid = const Uuid();

    try {
      String url = 'https://gateway.lidar-platform.com/api/mtn/auth.json';
      final res = await http.post(Uri.parse(url));
      // print(res.body);
      if (res.statusCode == 200) {
        String sessionObject = json.decode(res.body)['response']['access_token'].toString();

        var headers = {
          'Authorization': 'Bearer $sessionObject',
          'Content-Type': 'application/json'
        };
        var request = http.Request('GET', Uri.parse('https://gateway.lidar-platform.com/api/mtn/payinfo.json?refid=$ref'));

        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          msg = 'ok';
          var resp = json.decode(await response.stream.bytesToString())['response'];

          setState(() {
            payStatus = resp['status'];
          });

          log(resp.toString());

          setTimer(false, ref: ref);

        }
        else {
          msg = '${response.reasonPhrase}';
          print(response.reasonPhrase);
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

  Future<String> checkoutSession(int amount, String numero) async {
    String msg = '';

    var uuid = Uuid();

    try {
      String url = 'https://gateway.lidar-platform.com/api/mtn/auth.json';
      final res = await http.post(Uri.parse(url));
      print(res.statusCode);
      if (res.statusCode == 200) {
        String sessionObject = json.decode(res.body)['response']['access_token'].toString();

        var headers = {
          'Authorization': 'Bearer $sessionObject',
          'Content-Type': 'application/json'
        };
        var request = http.Request('POST', Uri.parse('https://gateway.lidar-platform.com/api/mtn/pay.json'));
        request.body = json.encode({
          "phone_id": 1,
          "amount": amount,
          "currency": "XOF",
          "externalId": uuid.v1(),
          "payer": {
            "partyIdType": "MSISDN",
            "partyId": "225$numero"
          },
          "payerMessage": "Test",
          "payeeNote": "Lidar"
        });

        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          msg = 'ok';
          String ref = json.decode(await response.stream.bytesToString())['ref'];

          // log(ref);

          checkPaySatus(ref);
        }
        else {
          msg = '${response.reasonPhrase}';
          print(response.reasonPhrase);
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
}
