import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/labModal.dart'; // Import LabTestModel
import '../provider/auth_provider.dart';
import '../provider/cart_provider.dart';

class LabDetailPage extends StatelessWidget {
  final LabModel lab;
  final AuthProvider authProvider;

  LabDetailPage({
    required this.lab,
    required this.authProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lab.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: Color(0xFF3E69FE),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                    'assets/images/fever.jpg',
                    fit: BoxFit.cover,
                    height: 120,
                  ),
                  Positioned(
                    bottom: 0,
                    child: Column(
                      children: [
                        Text(
                          lab.name,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          "Timings: ${lab.timings}",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text("Address: ${lab.address}", style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.grey)),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Available Tests:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                // Wrap the Column with SingleChildScrollView and set scroll direction to horizontal
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (LabTestModel test in lab.tests)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                          child: Consumer<CartProvider>(
                            builder: (context, cartProvider, child) {
                              bool isInCart = cartProvider.isInCart(test); // Check if the item is in the cart

                              return Container(
                                width: 150, // Set a fixed width for each card
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Text(
                                  test.testName,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '\$${test.testPrice.toString()}',
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                                SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    if (isInCart) {
                                      // If the item is in the cart, remove it
                                      // cartProvider.removeFromCart(test);
                                    } else {
                                      // If the item is not in the cart, add it
                                      cartProvider.addToCart(test);
                                    }
                                  },
                                  // ... existing code
                                  child: Text(isInCart ? 'Remove from Cart' : 'Add to Cart'),
                                ),
                              ],),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
