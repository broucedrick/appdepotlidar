import 'package:appdepotlidar/main.dart';
import 'package:flutter/material.dart';

class ManageAccount extends StatelessWidget {
  const ManageAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gérer mon compte'),
        elevation: 0,
      ),
      backgroundColor: Color(0xff2D2D2D),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20))),
              margin: const EdgeInsets.all(0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Palette.kToDark,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20))),
                child: Icon(
                  Icons.account_circle_rounded,
                  size: MediaQuery.of(context).size.width / 2,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'INFORMATIONS PERSONNELLES',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Palette.kToDark),
                      ),
                      Divider(color: Palette.kToDark, thickness: 1.5),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Nom',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 4,
                      ),
                      Text('SUPER MARKET',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54)),
                      SizedBox(
                        height: 8,
                      ),
                      Text('E-mail',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 4,
                      ),
                      Text('elieouonnebo@gmail.com',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54)),
                      SizedBox(
                        height: 8,
                      ),
                      Text('Numéro de téléphone',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 4,
                      ),
                      Text('+2250758854116',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54)),
                      SizedBox(
                        height: 8,
                      ),
                      Text('Adresse',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 4,
                      ),
                      Text('Yakro',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54)),
                      SizedBox(
                        height: 8,
                      ),
                      Text('Registre de commerce',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 4,
                      ),
                      Text('RCCM00002',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () {},
                      title: Text(
                        'MODIFIER NOM D\'UTILISATEUR',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      trailing: Icon(Icons.chevron_right_rounded),
                    ),
                    Divider(color: Palette.kToDark, thickness: 1.5, height: 1,),
                    ListTile(
                      onTap: () {},
                      title: Text(
                        'MODIFIER MOT DE PASSE',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      trailing: Icon(Icons.chevron_right_rounded),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
