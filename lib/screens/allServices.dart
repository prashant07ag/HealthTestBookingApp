import 'package:digi_diagnos/screens/testDetails.dart';
import 'package:flutter/material.dart';
import '../model/testModal.dart'; // Replace with the actual import path
import '../provider/auth_provider.dart';
import 'allLabs.dart'; // Replace with the actual import path

class AllTestsScreen extends StatelessWidget {
  final AuthProvider testProvider = AuthProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Tests'),
      ),
      body: FutureBuilder<List<TestModel>>(
        future: testProvider.fetchTests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty ?? true) {
            return Center(
              child: Text("No tests available."),
            );
          } else {
            // Display the list of tests
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                TestModel test = snapshot.data![index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(test.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description: ${test.description}'),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Price: \$${test.price.toString()}'),
                            ElevatedButton(
                              onPressed: () {
                                // Add booking logic
                                print('Book Now: ${test.name}');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TestDetailsScreen(test: test)));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF3E69FE),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text('Book Now'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      // Add navigation to test details screen or perform any action
                      // when a test is tapped
                      print('Test tapped: ${test.name}');
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
