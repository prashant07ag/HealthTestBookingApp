import 'package:digi_diagnos/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../provider/cart_provider.dart';
import 'appointment_screen.dart';
import 'cart.dart';
import 'home.dart';
import 'offers.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int selectedIndex = 0;
  final screens = [
    HomeScreen(),
    AllBookingsScreen(),
    SpecialOffers(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        height: 60,
        child: BottomNavigationBar(
          elevation: 5,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF3E69FE),
          unselectedItemColor: Colors.black54,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: "Schedule",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.percent_sharp),
              label: "Offers",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity),
              label: "Profile",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add navigation logic to go to the cart screen
          Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(cartProvider: cartProvider),));
        },
        child: Icon(Icons.shopping_cart),
        backgroundColor: Color(0xFF3E69FE)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}
