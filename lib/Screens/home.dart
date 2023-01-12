import 'dart:async';

import 'package:bdix/Screens/not_working.dart';
import 'package:bdix/Screens/working.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../Utilities/ping_send.dart';
import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

enum CustomButtonState { init, loading, done }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NetworkHelper networkHelper = Get.find();
  int index = 0;
  CustomButtonState state = CustomButtonState.init;
  bool isAnimating = true;

  final colorizeColors = [
    material.Colors.purple,
    material.Colors.blue,
    material.Colors.yellow,
    material.Colors.red,
  ];

  var colorizeTextStyle = const TextStyle(
    fontSize: 50.0,
    fontFamily: 'Horizon',
  );
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

  final screens = [const Working(), const NotWorking()];

  @override
  Widget build(BuildContext context) {
    bool isStretched = isAnimating || state == CustomButtonState.init;
    bool isDone = state == CustomButtonState.done;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        WindowTitleBarBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MoveWindow(),
              ),
              const WindowButtons()
            ],
          ),
        ),
        SizedBox(
          width: 300.0,
          height: 50,
          child: AnimatedTextKit(
            pause: const Duration(milliseconds: 00),
            repeatForever: true,
            animatedTexts: [
              ColorizeAnimatedText(
                'BDIX Checker',
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
              ),
            ],
            isRepeatingAnimation: true,
          ),
        ),
        Obx(
          () => AnimatedPadding(
            curve: Curves.easeOutQuart,
            duration: const Duration(milliseconds: 500),
            padding:
                EdgeInsets.fromLTRB(0, networkHelper.paddingValue.value, 0, 2),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              width: state == CustomButtonState.init ? 200 : 55,
              onEnd: () => setState(() {
                isAnimating = !isAnimating;
              }),
              child: isStretched ? mainButton() : buildsmallButton(isDone),
            ),
          ),
        ),
        Visibility(
          visible: networkHelper.isVisible,
          child: Expanded(
            // flex: 10,
            child: ScaffoldPage(
              content: screens[index],
              bottomBar: BottomNavigation(
                index: index,
                onChanged: (i) => setState(() => index = i),
                items: const [
                  BottomNavigationItem(
                    icon: Icon(FluentIcons.accept),
                    selectedIcon: Icon(
                      FluentIcons.accept_medium,
                      size: 20,
                    ),
                    title: Text('Working'),
                  ),
                  BottomNavigationItem(
                    icon: Icon(FluentIcons.error_badge),
                    selectedIcon: Icon(FluentIcons.status_error_full),
                    title: Text('Not Working'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget mainButton() {
    return OutlinedButton(
      style: ButtonStyle(
          shape: ButtonState.all(
            const StadiumBorder(),
          ),
          padding: ButtonState.all(const EdgeInsets.symmetric(
            vertical: 10,
          )),
          // elevation: ButtonState.all(0),
          shadowColor: ButtonState.all(Colors.white)),
      child: const Text('SCAN NOW'),
      onPressed: () async {
        if (networkHelper.success.isEmpty && networkHelper.failed.isEmpty) {
          networkHelper.linkchecker();
          setState(() => state = CustomButtonState.loading);
          await Future.delayed(const Duration(seconds: 5));
          setState(() => state = CustomButtonState.done);
          await Future.delayed(const Duration(seconds: 1));
          setState(() => state = CustomButtonState.init);

          networkHelper.paddingValue.value = 20.0;
          await Future.delayed(const Duration(milliseconds: 500));
          setState(() => networkHelper.isVisible = true);
        } else {
          networkHelper.success.clear();
          networkHelper.failed.clear();
          // networkHelper.i = 0;
          networkHelper.linkchecker();
        }
      },
    );
  }

  Widget buildsmallButton(bool isDone) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDone ? Colors.successPrimaryColor : Colors.transparent),
      child: isDone
          ? const Icon(FluentIcons.accept_medium, color: Colors.white)
          : const ProgressRing(
              value: null,
              activeColor: Colors.black,
              backgroundColor: Colors.transparent,
              strokeWidth: 2,
            ),
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
