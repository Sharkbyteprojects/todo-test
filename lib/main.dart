import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'conf_load.dart';
import 'routing.dart';
import 'world_of_elements/notify.dart';

late Map configData;
void main() async {
  configData = await ConfigD.loadAsset();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ListNotifier())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainApp createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  static const double _elemH = 46;
  int screenIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget navigate() {
    if (screenIndex < destinations.length) {
      return destinations[screenIndex].toEnter;
    }
    return Row(
      children: [
        const Icon(Icons.warning_rounded),
        Text((configData["404text"]) ?? "404"),
      ],
    );
  }

  Widget badgeOfHonor(BuildContext context, Widget ic) {
    final n = Provider.of<ListNotifier>(context).getAllYetTodo();
    return n > 0 ? Badge.count(count: n, child: ic) : ic;
  }

  @override
  Widget build(BuildContext context) {
    final String title = (configData["title"]) ?? " null";
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.primaries.first,
          title: SizedBox(
            height: _elemH,
            child: Row(
              children: [
                Image.asset("assets/logo.png", height: _elemH * 0.8),
                Text(" $title"),
              ],
            ),
          ),
          toolbarHeight: _elemH,
        ),
        body: navigate(),
        bottomNavigationBar: NavigationBar(
          selectedIndex: screenIndex,
          onDestinationSelected: (int index) {
            setState(() {
              screenIndex = index;
            });
          },
          destinations: destinations.map((DSTbar destination) {
            return NavigationDestination(
              label: destination.label,
              icon: destination.badge
                  ? badgeOfHonor(context, destination.icon)
                  : destination.icon,
              selectedIcon: destination.badge
                  ? badgeOfHonor(context, destination.selectedIcon)
                  : destination.selectedIcon,
              tooltip: destination.label,
            );
          }).toList(),
        ),
      ),
    );
  }
}
