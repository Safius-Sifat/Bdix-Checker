import 'package:bdix/Screens/Favourites.dart';

import 'package:bdix/Screens/about.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'Screens/home.dart';
import 'Utilities/ping_send.dart';

void main() {
  runApp(const MyApp());

  doWhenWindowReady(() {
    const initialSize = Size(900, 650);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        // acrylicBackgroundColor: Colors.transparent,
        accentColor: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        typography: const Typography.raw(
          caption: TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  final ScrollController settingsController = ScrollController();
  final viewKey = GlobalKey();
  final NetworkHelper networkHelper = Get.put(NetworkHelper());
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      key: viewKey,
      pane: NavigationPane(
          size: const NavigationPaneSize(
            openMinWidth: 100,
            openMaxWidth: 300,
          ),
          selected: index,
          onChanged: (i) => setState(() => index = i),
          displayMode: PaneDisplayMode.compact,
          items: [
            PaneItem(
                icon: const Icon(FluentIcons.home),
                title: const Text('Home'),
                body: const Home()),
            PaneItem(
              icon: const Icon(FluentIcons.favorite_star),
              title: const Text('Favourites'),
              body: const Favourites(),
            ),
            PaneItem(
                icon: const Icon(FluentIcons.info),
                title: const Text('About'),
                body: const About()),
          ]),
      // content: navigationbody(
      //   index: index,
      //   // ignore: prefer_const_literals_to_create_immutables
      //   children: [
      //     const Home(),
      //     const Favourites(),
      //     const About(),
      //   ],
      // ),
    );
  }
}
