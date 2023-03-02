import 'package:flutter/material.dart';

class Historique extends StatefulWidget {
  const Historique({Key? key}) : super(key: key);

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon historique'),
      ),
      backgroundColor: Color(0xff2D2D2D),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 30,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Row(
                  children: [
                    Text('Rechargement'),
                    // SizedBox(width: 5.0,),
                    // Expanded(child: Icon(Icons.check_circle_rounded, color: Colors.green, size: 15,))
                  ],
                ),
                subtitle: Text('Réf. TX1666027112'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('-5000'),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'lun. 17 oct. 2022 à 13:10',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
