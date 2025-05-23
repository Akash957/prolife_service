import 'package:flutter/material.dart';
import 'package:prolife_service/screens/booking_screen/my_booking_screen.dart';
import '../home_page_view/all_categories.dart';
import '../home_page_view/home_screen.dart';
import '../profile_screen/profile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const AllCategories(),
    const MyBookingScreen(),
     const ProfilePage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey,
            selectedFontSize: 14,
            unselectedFontSize: 13,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home_outlined, size: 28),
                activeIcon: Icon(Icons.home, size: 30),
              ),
              BottomNavigationBarItem(
                label: 'Category',
                icon: Icon(Icons.dashboard_customize_outlined, size: 28),
                activeIcon: Icon(Icons.dashboard_customize, size: 30),
              ),
              BottomNavigationBarItem(
                label: 'Booking',
                icon: Icon(Icons.backpack_outlined, size: 28),
                activeIcon: Icon(Icons.backpack, size: 30),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person_outline, size: 28),
                activeIcon: Icon(Icons.person, size: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
