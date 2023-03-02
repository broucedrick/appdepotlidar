import 'dart:convert';

import 'package:appdepotlidar/screen/checkout_wave.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class WavePayment extends StatefulWidget {
  const WavePayment({Key? key}) : super(key: key);

  @override
  State<WavePayment> createState() => _WavePaymentState();
}

class _WavePaymentState extends State<WavePayment> {

  TextEditingController _ctrlMontant = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              color: const Color(0xff1dc8ff),
              elevation: 10,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 5,
                        height: MediaQuery.of(context).size.width / 5,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage('assets/images/wave.png'))),
                        // child: Image.asset('assets/images/wave.png', height: 150, fit: BoxFit.fitHeight, width: 150)
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      // const Text(
                      //   'ENTREZ UN MONTANT',
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 13),
                      // ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _ctrlMontant,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 50, color: Color(0xff0c647c)),
                              cursorColor: const Color(0xffef8014),
                              decoration: const InputDecoration(
                                hintText: 'Montant',
                                  hintStyle: TextStyle(fontSize: 18),
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffef8014),
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutWave(montant: int.parse(_ctrlMontant.text)),));
                                    },
                                    child: const Text('VALIDER', style: TextStyle(color: Colors.white)),
                                  // style: ,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // bouton : #040505 ou #ef8014

  // mtn button : #2596be, card : #fbcb04, field border and cursor : #08455e


}

/*

{
id: cos-1ctffam6023r0,
amount: 200,
checkout_status: open,
client_reference: null,
currency: XOF,
error_url: https://pay.lidar-platform.com/#/error,
last_payment_error: null,
business_name: Lidar,
payment_status: processing,
success_url: https://pay.lidar-platform.com/#/success,
wave_launch_url: https://pay.wave.com/c/cos-1ctffam6023r0?a=200&c=XOF&m=Lidar,
when_completed: null,
when_created: 2023-02-07T09:25:46Z,
when_expires: 2023-02-07T09:55:46Z
}

 */
