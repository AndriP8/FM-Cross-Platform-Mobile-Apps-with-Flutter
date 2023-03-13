import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/oderpage.dart';
import 'package:flutter_application_1/pages/offerspage.dart';
import 'package:flutter_application_1/pages/menupage.dart';

import 'datamanager.dart';

void main() {
  runApp(const MyApp());
}

class Greet extends StatefulWidget {
  const Greet({Key? key}) : super(key: key);

  @override
  State<Greet> createState() => _GreetState();
}

class _GreetState extends State<Greet> {
  var name = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Hello $name"),
          ],
        ),
        TextField(
            onChanged: (value) => setState(() {
                  name = value;
                }))
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Master',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  // int _currentIndex = 0;
  DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    Widget currentWidgetPage = const Text("!!!!");

    switch (selectedIndex) {
      case 0:
        currentWidgetPage = MenuPage(
          dataManager: dataManager,
        );
        break;
      case 1:
        currentWidgetPage = const OffersPage();
        break;
      case 2:
        currentWidgetPage = OrderPage(
          dataManager: dataManager,
        );
        break;
    }

    return Scaffold(
        appBar: AppBar(
          title: Image.asset("images/logo.png"),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (newIndex) => {
                  setState(() {
                    selectedIndex = newIndex;
                  })
                },
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Colors.yellow.shade400,
            unselectedItemColor: Colors.brown.shade50,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.coffee), label: "Menu"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_offer), label: "Offers"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_checkout_outlined),
                  label: "Order"),
            ]),
        body: currentWidgetPage);
  }
}
