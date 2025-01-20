import 'package:flearn/my_store_firebase/views/screens/home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flearn/my_store_firebase/views/screens/bottomNav_screens/acount_screen.dart';
import 'package:flearn/my_store_firebase/views/screens/bottomNav_screens/favorite_screen.dart';
import 'package:flearn/my_store_firebase/views/screens/bottomNav_screens/stores_screen.dart';
import 'package:flearn/my_store_firebase/views/screens/bottomNav_screens/cart_product_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;

  List<Widget> pages = [
    HomeScreen(),
    FavoriteScreen(),
    StoresScreen(),
    CartScreenProduct(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        currentIndex: pageIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white.withOpacity(0.95),
            icon: Image.asset(
              'assets/icons/home.png',
              width: 25,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/love.png',
              width: 25,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/mart.png',
              width: 25,
            ),
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/cart.png',
              width: 25,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/user.png',
              width: 25,
            ),
            label: 'Account',
          ),
        ],
      ),
      body: pages[pageIndex],
    );
  }
}
