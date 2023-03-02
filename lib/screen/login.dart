import 'package:flutter/material.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool checkbox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe9e9e9),
      appBar: AppBar(
        title: Text('Connexion'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/logo_itm.png')),
                      ),
                  // child: Center(child: Text('214x214', style: TextStyle(color: Color(0xff9c9c9c)),)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 40),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffe9e9e9),
                                  focusColor: Colors.black,
                                  hoverColor: Colors.black,
                                  prefixIcon: Icon(Icons.mail_rounded),
                                  hintText: 'johndoe@mail.com',
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(200)),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffe9e9e9),
                                  focusColor: Colors.black,
                                  hoverColor: Colors.black,
                                  prefixIcon: Icon(Icons.lock_rounded),
                                  hintText: '********',
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(200)),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: checkbox,
                                          activeColor: Color(0xff07cbcb),
                                          onChanged: (value) {
                                            setState(() {
                                              checkbox = !checkbox;
                                            });
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)
                                          ),
                                        ),
                                        Expanded(child: Text('Se souvenir de moi')),
                                      ],
                                    ),
                                  ),
                                  TextButton(child: Text('Mot de passe oublié ?', style: TextStyle(color: Colors.blueAccent)),
                                    onPressed: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPassword()));
                                  },
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Accueil(),));
                                  },
                                  child: Text('Se connecter',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  style: const ButtonStyle(
                                      padding: MaterialStatePropertyAll(
                                          EdgeInsets.symmetric(vertical: 15.0)),
                                      elevation: MaterialStatePropertyAll(0),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.blueAccent),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.horizontal(
                                                  left: Radius.circular(200.0),
                                                  right: Radius.circular(200.0))))),
                                ),
                              ),
                              // const SizedBox(
                              //   height: 10.0,
                              // ),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width,
                              //   child: ElevatedButton(
                              //     onPressed: () {},
                              //     child: Text('Register',
                              //         style: TextStyle(
                              //             fontSize: 16.0,
                              //             color: Colors.white,
                              //             fontWeight: FontWeight.bold)),
                              //     style: const ButtonStyle(
                              //         padding: MaterialStatePropertyAll(
                              //             EdgeInsets.symmetric(vertical: 15.0)),
                              //         elevation: MaterialStatePropertyAll(0),
                              //         backgroundColor: MaterialStatePropertyAll(
                              //             Color(0xfffeb220)),
                              //         shape: MaterialStatePropertyAll(
                              //             RoundedRectangleBorder(
                              //                 borderRadius: BorderRadius.horizontal(
                              //                     left: Radius.circular(200.0),
                              //                     right: Radius.circular(200.0))))),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Vous n\'avez pas de compte ?'),
                TextButton(child: Text('S\'inscrire !', style: TextStyle(color: Colors.blueAccent)),
                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => const Register()));
                  },)
              ],
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
