import 'package:flutter/material.dart';
import 'package:text_2_speech/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: mainColor,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle _optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.translate_rounded),
      label: 'Translate',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.history_rounded),
      label: 'History',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_rounded),
      label: 'Settings',
    ),
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Translate',
      style: _optionStyle,
    ),
    Text(
      'Index 1: History',
      style: _optionStyle,
    ),
    Text(
      'Index 2: Settings',
      style: _optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_items[_selectedIndex].label ?? 'Translate'),
        bottom: _tabBar(),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        items: _items,
        currentIndex: _selectedIndex,
        selectedItemColor: mainColor,
        onTap: _onItemTapped,
      );

  PreferredSizeWidget _tabBar() => PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabItem(Icons.keyboard, "Text"),
            _tabItem(Icons.camera, "Camera"),
            _tabItem(Icons.mic, "Voice"),
          ],
        ),
      ));

  Widget _tabItem(IconData icon, String title) => InkWell(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [Icon(icon), Text(title)],
          ),
        ),
        onTap: () {},
      );

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  
}
