import 'package:bdix/Utilities/ping_send.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:url_launcher/url_launcher.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  NetworkHelper networkHelper = Get.find();
  int index = 0;
  List<String> newSaved = [];
  @override
  void initState() {
    super.initState();
    networkHelper.isFirstTime().then((isFirstTime) {
      if (isFirstTime) {
        networkHelper.saveList();
        networkHelper.useTheList();
        print(isFirstTime);
      } else {
        networkHelper.useTheList();
        print(isFirstTime);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> newSaved = networkHelper.saved.toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
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
        Text(
          'Favourites',
          style: TextStyle(
            fontFamily: 'Horizon',
            color: Colors.purple.shade500,
            fontSize: 50,
          ),
        ),
        Expanded(
          child: fluent.ScaffoldPage(
            content: ListView.builder(
              itemCount: newSaved.length,
              itemBuilder: (BuildContext context, int index) {
                return Material(
                  child: Ink(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () async {
                        if (!await launchUrl(Uri.parse(newSaved[index]))) {
                          throw 'Could not launch url';
                        }
                      },
                      child: ListTile(
                        title: newSaved.isEmpty
                            ? const Text('No Favourites')
                            : Text('${index + 1}.  ${newSaved[index]}'),
                      ),
                    ),
                  ),
                );
              },
            ),
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
