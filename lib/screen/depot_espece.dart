import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../main.dart';

class DepotEspece extends StatefulWidget {
  const DepotEspece({Key? key}) : super(key: key);

  @override
  State<DepotEspece> createState() => _DepotEspeceState();
}

class _DepotEspeceState extends State<DepotEspece> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _ctrlNumero = TextEditingController();
  TextEditingController _ctrlPan = TextEditingController();
  TextEditingController _ctrlMontant = TextEditingController();

  String number = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF005031),
        title: const Text('Paiement par numéro de téléphone'),
      ),
      backgroundColor: Color(0xff2D2D2D),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      IntlPhoneField(
                        controller: _ctrlNumero,
                        showCountryFlag: false,
                        validator: (value) {
                          if (value!.number.isEmpty) {
                            return "Entrez votre numéro de téléphone";
                          }else if(value!.number.length != 10){
                            return 'Entrez un numéro à 10 chiffres';
                          }
                          return null;
                        },

                        disableLengthCheck: true,
                        style: const TextStyle(color: Colors.white),
                        dropdownIcon: Icon(Icons.arrow_drop_down_rounded, color: Colors.white),
                        dropdownTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 8.0),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Numéro de téléphone du bénéficiaire',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                        ),
                        initialCountryCode: 'CI',
                        onChanged: (phone) {
                          setState(() {
                            number = phone.completeNumber;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _ctrlPan,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Entrez le PAN de la carte';
                          } else if(value!.length != 16){
                            return 'Entrez un PAN de 16 chiffres';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          prefixIcon: Icon(Icons.credit_card_rounded,
                            color: Colors.white,),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'PAN de la du bénéficiaire',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _ctrlMontant,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Entrez le montant à recharger';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            prefixIcon: Icon(
                              Icons.monetization_on_rounded,
                              color: Colors.white,
                            ),
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Montant à recharger',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Résumé', style: TextStyle(color: Palette.kToDark),),
                                actions: [
                                  TextButton(onPressed: () {

                                  }, child: const Text('Confirmer')),
                                  TextButton(onPressed: () {
                                    Navigator.pop(context);
                                  }, child: const Text('Annuler'))
                                ],
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Numéro de téléphone du bénéficiaire',
                                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(_ctrlNumero.text,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54)),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Text('PAN de la carte du bénéficiaire',
                                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(_ctrlPan.text,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54)),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Text('Montant à recharger',
                                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(_ctrlMontant.text,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54)),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF005031))),
                      child: const Text('VALIDER')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}