// Replace with the actual import path
import 'package:flutter/material.dart';

import '../model/labModal.dart';
import '../provider/auth_provider.dart';
import '../screens/details.dart';

class LabCard extends StatelessWidget {
  final LabModel lab;

  LabCard({required this.lab});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFF3E69FE),
              radius: 30,
              child: Text(
                lab.name.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lab.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("Address: ${lab.address}"),
                  Text("Timings: ${lab.timings}"),
                ],
              ),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    Text("4.5"),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle booking button click
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LabDetailPage(lab: lab,authProvider: AuthProvider(),)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF3E69FE),
                  ),
                  child: Text("Book Now"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
