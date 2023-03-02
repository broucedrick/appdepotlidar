import 'package:appdepotlidar/screen/depotoption.dart';
import 'package:appdepotlidar/screen/manage_account.dart';
import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../main.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key, required this.awesomeDrawerBar})
      : super(key: key);
  AwesomeDrawerBarController awesomeDrawerBar;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool scroll = false;

  ScrollController _listCtrl = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageAccount(),));
              },
              child: Container(
                padding: const EdgeInsets.only(
                    top: 2.0, bottom: 2.0, right: 8, left: 2),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(50), right: Radius.circular(50))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.account_circle_rounded),
                    SizedBox(
                      width: 5,
                    ),
                    Text('SUPER MARKET')
                  ],
                ),
              ))
        ],
        elevation: 0,
        leading: InkWell(
          onTap: () => widget.awesomeDrawerBar.toggle!(),
            child: Icon(Icons.menu_rounded)),
      ),
      backgroundColor: Color(0xff2D2D2D),
      body: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height / 2,
        maxHeight: MediaQuery.of(context).size.height,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Palette.kToDark,
        onPanelOpened: () {
          setState(() {
            scroll = true;
          });
        },
        onPanelClosed: () {
          setState(() {
            scroll = false;
          });
          _listCtrl.jumpTo(0);
        },
        panel: Column(
          children: [
            SizedBox(
              height: 12.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('HISTORIQUE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      TextButton(child: Text('VOIR PLUS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)), onPressed: () {},)
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(
              height: 12.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView.builder(
                  controller: _listCtrl,
                  physics: scroll
                      ? BouncingScrollPhysics()
                      : NeverScrollableScrollPhysics(),
                  itemCount: 4,
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
            ),
          ],
        ),
        body: Column(
          children: [
            Card(
                elevation: 5,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20))),
                margin: const EdgeInsets.all(0),
                color: Color(0xff005031),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: RefreshIndicator(
                    onRefresh: _pullRefresh,
                    displacement: 5,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'MON SOLDE',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.refresh_rounded,
                                color: Colors.white,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '25/11/2022 à 18:00',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '300 000',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'FCFA',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Depotoption(),));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 30.0),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(50),
                                            right: Radius.circular(50))),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.arrow_circle_down_rounded),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Dépôt d\'argent')
                                      ],
                                    ),
                                  )),
                              // TextButton(
                              //     onPressed: () {
                              //       Navigator.push(context, MaterialPageRoute(builder: (context) => const Depotoption(),));
                              //     },
                              //     child: Container(
                              //       padding: const EdgeInsets.symmetric(
                              //           vertical: 10.0, horizontal: 30.0),
                              //       decoration: const BoxDecoration(
                              //           color: Colors.white,
                              //           shape: BoxShape.circle,),
                              //       child: Row(
                              //         mainAxisSize: MainAxisSize.min,
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         crossAxisAlignment: CrossAxisAlignment.center,
                              //         children: const [
                              //           Icon(Icons.qr_code_2_rounded, size: 60,),
                              //         ],
                              //       ),
                              //     )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Image.asset(
              'assets/images/lidar_logo.png',
              height: MediaQuery.of(context).size.width / 15,
            )
            // Expanded(
            //   child: Card(
            //     elevation: 5,
            //     shape: RoundedRectangleBorder(
            //         borderRadius:
            //         BorderRadius.vertical(top: Radius.circular(20))),
            //     margin: const EdgeInsets.all(0),
            //     color: Color(0xff005031),
            //     child: Column(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            //           child: Row(
            //             children: [
            //               Expanded(child: Text('Mon historique', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold))),
            //               Icon(Icons.chevron_right_rounded, color: Colors.white,)
            //             ],
            //           ),
            //         ),
            //         Divider(height: 1, color: Colors.white,),
            //         SizedBox(
            //           height: 5,
            //         ),
            //         Expanded(
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //             child: ListView.builder(
            //               itemCount: 5,
            //               itemBuilder: (context, index) {
            //                 return Card(
            //                   child: ListTile(
            //
            //                     title: Row(
            //                       children: [
            //                         Text('Rechargement'),
            //                         // SizedBox(width: 5.0,),
            //                         // Expanded(child: Icon(Icons.check_circle_rounded, color: Colors.green, size: 15,))
            //                       ],
            //                     ),
            //                     subtitle: Text('Réf. TX1666027112'),
            //                     trailing: Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       crossAxisAlignment: CrossAxisAlignment.end,
            //                       children: [
            //                         Text('-5000'),
            //                         SizedBox(height: 5.0,),
            //                         Text('lun. 17 oct. 2022 à 13:10', style: TextStyle(fontSize: 10),)
            //                       ],
            //                     ),
            //                   ),
            //                 );
            //               },
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    print('refresh');
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }
}
