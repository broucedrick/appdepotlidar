import 'dart:convert';

import 'package:appdepotlidar/screen/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../widget/loadin_mtn.dart';

class MtnPayment extends StatefulWidget {
  const MtnPayment({Key? key}) : super(key: key);

  @override
  State<MtnPayment> createState() => _MtnPaymentState();
}

class _MtnPaymentState extends State<MtnPayment> {

  TextEditingController _ctrlPhone = TextEditingController();
  TextEditingController _ctrlMontant = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              color: const Color(0xfffbcb04),
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
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 5.5,
                        height: MediaQuery.of(context).size.width / 5.5,
                        decoration: const BoxDecoration(
                            // shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage('assets/images/mtnmomo.png'))),
                        // child: Image.asset('assets/images/wave.png', height: 150, fit: BoxFit.fitHeight, width: 150)
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      // const Text(
                      //   'ENTREZ UN MONTANT',
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 13),
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _ctrlPhone,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return 'Entrez un numéro valide';
                                  }else if(value.length != 10){
                                    return 'Entrez un numéro de 10 chiffres';
                                  }else if(!value.startsWith('05')){
                                    return 'Entrez un numéro valide MTN';
                                  }
                                  return null;
                                },
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontSize: 16, color: Color(0xff0c647c)),
                                cursorColor: const Color(0xff2596be),
                                decoration: const InputDecoration(
                                  hintText: 'Numéro de téléphone',
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                              const Divider(color: Colors.grey, height: 1,),
                              TextFormField(
                                controller: _ctrlMontant,
                                validator: (value) {
                                  RegExp _regExp = RegExp(r'^[0-9]+$');

                                  if(value!.isEmpty){
                                    return 'entrez un montant ';
                                  }else if(!_regExp.hasMatch(value)){
                                    return 'entrez un montant valide';
                                  }else if(int.parse(value) < 100){
                                    return 'le montant doit être supérieur ou égal à 100';
                                  }
                                  return null;
                                },
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 16, color: Color(0xff0c647c)),
                                cursorColor: const Color(0xff2596be),
                                decoration: const InputDecoration(
                                  hintText: '0 XOF',
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xff2596be),
                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {

                                        // checkoutSession(_ctrlMontant.text, _ctrlPhone.text);

                                        Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(montant: int.parse(_ctrlMontant.text), numero: _ctrlPhone.text, reseau: "mtn"),));
                                      }
                                    },
                                    child: const Text('VALIDER', style: TextStyle(color: Colors.white)),
                                    // style: ,
                                  ),
                                ),
                              )
                            ],
                          ),
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

  Future<String> checkoutSession(String amount, String numero) async {
    String msg = '';

    var uuid = Uuid();

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
        var request = http.Request('POST', Uri.parse('https://gateway.lidar-platform.com/api/mtn/pay.json'));
        request.body = json.encode({
          "phone_id": 1,
          "amount": int.parse(amount),
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
          
          showDialog(context: context,
              barrierDismissible: false,
              builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: LoadingMtn(reference: ref,)
            );
          });
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
