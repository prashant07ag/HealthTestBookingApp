import 'package:digi_diagnos/screens/details.dart';
import 'package:flutter/material.dart';
import '../model/testModal.dart';
import '../model/labModal.dart';
import '../provider/auth_provider.dart';
import 'booking.dart';

class TestDetailsScreen extends StatefulWidget {
  final TestModel test;

  TestDetailsScreen({
    required this.test,
  });

  @override
  _TestDetailsScreenState createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends State<TestDetailsScreen> {
  List<LabModel> labs = [];

  @override
  void initState() {
    super.initState();
    fetchLabsForTest();
  }

  void fetchLabsForTest() async {
    try {
      // Assuming widget.test.labIds contains the list of lab IDs associated with the test
      List<LabModel> fetchedLabs = await AuthProvider().fetchLabsForTest(widget.test.labIds);

      setState(() {
        labs = fetchedLabs;
      });
    } catch (error) {
      print("Error fetching labs for test: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.test.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description: ${widget.test.description}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Price: \$${widget.test.price}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Labs Offering this Test:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              if (labs.isNotEmpty)
                Column(
                  children: labs.map((lab) {
                    return LabtestCard(
                      lab: lab,
                      onBookNowPressed: () {
                        // Implement your book now logic here
                        // You can use lab.id, lab.name, or any other lab details
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BookingScreen()));
                      },
                    );
                  }).toList(),
                )
              else
                Text(
                  "No labs available for this test.", // Update with appropriate message or UI
                  style: TextStyle(fontSize: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class LabtestCard extends StatelessWidget {
  final LabModel lab;
  final VoidCallback onBookNowPressed;

  LabtestCard({
    required this.lab,
    required this.onBookNowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/fever.jpg', // Replace with the actual image path
            fit: BoxFit.cover,
            height: 120,
            width: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lab.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Timings: ${lab.timings}",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Address: ${lab.address}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF3E69FE),
                  ),
                  onPressed: onBookNowPressed,
                  child: Text("Book Now"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
