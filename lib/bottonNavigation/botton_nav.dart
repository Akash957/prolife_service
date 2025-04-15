import 'package:flutter/material.dart';
import '../home_page_view/all_categories.dart';
import '../home_page_view/home_screen.dart';
import '../profile_screen/profile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  var index = 0;
  List pagecontrooller = [
    HomeScreen(),
    AllCategories(),
    HomeScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pagecontrooller[index],
      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 15,
          backgroundColor: Colors.white,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(
                  Icons.home,
                  size: 30,
                )),
            BottomNavigationBarItem(
                label: 'Category',
                icon: Icon(
                  Icons.dashboard_customize_outlined,
                  size: 30,
                )),
            BottomNavigationBarItem(
                label: 'Booking',
                icon: Icon(
                  Icons.backpack,
                  size: 30,
                )),
            BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(
                  Icons.person,
                  size: 30,
                )),
          ]),
    );
  }
}
