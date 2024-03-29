// import 'package:fluent_ui/fluent_ui.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final _url = Uri.parse('mailto:safiussifat1122@gmail.com');
  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        WindowTitleBarBox(
          child: Row(
            children: [
              Expanded(
                child: MoveWindow(),
              ),
              const WindowButtons()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/me.png',
                height: 100,
                width: 100,
              ),
              const Text(
                'Safius Sifat',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 40.0,
                  color: Color(0xff6f4aa2),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'FLUTTER DEVELOPER',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  color: Colors.purple.shade100,
                  fontSize: 20.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.purple.shade100,
                ),
              ),
              Container(
                width: 500,
                child: Card(
                    color: const Color(0xff6f4aa2),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 25.0),
                    child: Material(
                      child: Ink(
                        color: const Color(0xff6f4aa2),
                        child: InkWell(
                          onTap: () async {
                            if (!await launchUrl(
                                Uri.parse('https://github.com/Safius-Sifat'))) {
                              throw 'Could not launch https://github.com/Safius-Sifat';
                            }
                          },
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            leading: Image.asset('images/github.png'),
                            title: const Text(
                              'Safius-Sifat',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
              Container(
                width: 500,
                child: Card(
                  color: const Color(0xff6f4aa2),
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: Material(
                    child: Ink(
                      color: const Color(0xff6f4aa2),
                      child: InkWell(
                        onTap: () async {
                          if (!await launchUrl(_url)) {
                            throw 'Could not launch $_url';
                          }
                        },
                        child: const ListTile(
                          leading: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          title: Text(
                            'safiussifat1122@gmail.com',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontFamily: 'Source Sans Pro'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final buttonColors = WindowButtonColors(
  iconNormal: const Color.fromARGB(255, 17, 13, 7),
  mouseOver: const Color.fromARGB(255, 204, 203, 202),
  mouseDown: const Color.fromARGB(255, 136, 136, 136),
  iconMouseOver: const Color.fromARGB(255, 0, 0, 0),
  iconMouseDown: const Color.fromARGB(255, 0, 0, 0),
);

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color.fromARGB(255, 0, 0, 0),
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
