import 'package:digi_diagnos/screens/booking.dart';
import 'package:flutter/material.dart';

class OffersCard extends StatelessWidget {
  final String labName;
  final double rating;
  final String appointmentTimings;
  final AssetImage image;
  final String designation;
  final String fees;

  OffersCard({
    required this.labName,
    required this.rating,
    required this.appointmentTimings,
    required this.image,
    required this.designation,
    required this.fees,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      labName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      designation,
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.grey,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "$appointmentTimings",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.local_offer,
                          color: Colors.amber, // You can choose the appropriate color
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Special Discount!", // Highlight the discount section
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      fees,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // Add spacing between the content and buttons
            Divider(), // Add a divider for better separation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Add logic for reviewing the booking
                },
                style: ElevatedButton.styleFrom(primary: Color(0xFF3E69FE)),
                child: Text(
                  'Contact Lab',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              width: 16.0, // Adjust the space between buttons
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Add logic for rescheduling the booking
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(primary: Color(0xFF3E69FE)),
                child: Text(
                  'Make Booking',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ]),
          ],
        ),
      ),
    );
  }
}
