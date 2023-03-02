import 'package:appdepotlidar/main.dart';
import 'package:appdepotlidar/screen/depot_espece.dart';
import 'package:appdepotlidar/screen/mtn_payment.dart';
import 'package:appdepotlidar/screen/wave_payment.dart';
import 'package:flutter/material.dart';

class Depotoption extends StatelessWidget {
  const Depotoption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dépôt d\'argent'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: const EdgeInsets.all(0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  color: Palette.kToDark,
                  child: const Text('Choissiez une option de rechargement', style: TextStyle(color: Colors.white),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 8,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage('assets/images/espece.png')
                              )
                          ),
                        ),
                        title: const Text('Rechargement en espèce'),
                        trailing: const Icon(Icons.arrow_right_rounded),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DepotEspece(),)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Mobile Money', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                              image: AssetImage('assets/images/mtnmomo.png')
                            )
                          ),
                        ),
                        title: const Text('MTN MONEY'),
                        trailing: const Icon(Icons.arrow_right_rounded),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MtnPayment(),)),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 8,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage('assets/images/wave.png')
                              )
                          ),
                        ),
                        title: const Text('WAVE'),
                        trailing: const Icon(Icons.arrow_right_rounded),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WavePayment(),)),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 8,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                  image: AssetImage('assets/images/orangemoney.png')
                              )
                          ),
                        ),
                        title: const Text('ORANGE MONEY'),
                        trailing: const Icon(Icons.arrow_right_rounded),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DepotEspece(),)),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 8,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage('assets/images/Moov_Africa_logo.png')
                              )
                          ),
                        ),
                        title: const Text('MOOV MONEY'),
                        trailing: const Icon(Icons.arrow_right_rounded),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DepotEspece(),)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
