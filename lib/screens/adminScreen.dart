import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/labModal.dart';
import '../model/testModal.dart';
import '../provider/auth_provider.dart';
import '../utils/utils.dart';
import '../widgets/custom_button.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final labNameController = TextEditingController();
  final labAddressController = TextEditingController();
  final labTestsController = TextEditingController();
  final labTimingsController = TextEditingController();
  final testNameController = TextEditingController();
  final testDescriptionController = TextEditingController();
  final testPriceController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    labNameController.dispose();
    labAddressController.dispose();
    labTestsController.dispose();
    labTimingsController.dispose();
    testNameController.dispose();
    testDescriptionController.dispose();
    testPriceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: labNameController,
                decoration: InputDecoration(labelText: 'Lab Name'),
              ),
              TextField(
                controller: labAddressController,
                decoration: InputDecoration(labelText: 'Lab Address'),
              ),
              TextField(
                controller: labTestsController,
                decoration: InputDecoration(labelText: 'Lab Tests (comma-separated)'),
              ),
              TextField(
                controller: labTimingsController,
                decoration: InputDecoration(labelText: 'Lab Timings'),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Add Lab',
                onPressed: () => addLab(),
              ),
              const SizedBox(height: 20),
              // Add UI for adding tests
              TextField(
                controller: testNameController,
                decoration: InputDecoration(labelText: 'Test Name'),
              ),
              TextField(
                controller: testDescriptionController,
                decoration: InputDecoration(labelText: 'Test Description'),
              ),
              TextField(
                controller: testPriceController,
                decoration: InputDecoration(labelText: 'Test Price'),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Add Test',
                onPressed: () => addTest(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  void addTest() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Assuming you have a selected test name
    String testName = testNameController.text.trim();

    try {
      // Fetch a list of labs (you can adjust the query or fetch logic based on your requirements)
      List<LabModel> labs = await authProvider.fetchLabs();

      // Take the first 5 lab IDs (you can adjust the logic based on your requirements)
      List<String> labIds = labs.take(5).map((lab) => lab.id).toList();

      // Add the test to each lab
      TestModel test = TestModel(
        id: _firebaseFirestore.collection('services').doc().id, // You might want to generate a unique ID here
        labIds: labIds,
        name: testName,
        description: testDescriptionController.text.trim(),
        price: int.parse(testPriceController.text.trim()),
      );

      await authProvider.addTestToFirestore(test);

      showSnackBar(context, 'Test added successfully to selected labs!');
      // Clear the text controllers after adding the test
      testNameController.clear();
      testDescriptionController.clear();
      testPriceController.clear();
    } catch (error) {
      showSnackBar(context, 'Error adding test: $error');
    }
  }


  void addLab() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Extracting tests from the comma-separated string
    List<LabTestModel> testsList = labTestsController.text.split(',').map((test) {
      var parts = test.split(':');
      return LabTestModel(
          testName: parts[0].trim(), testPrice: double.parse(parts[1].trim()));
    }).toList();

    LabModel lab = LabModel(
      id: _firebaseFirestore.collection('labs').doc().id,
      // You might want to generate a unique ID here
      name: labNameController.text.trim(),
      address: labAddressController.text.trim(),
      tests: testsList,
      timings: labTimingsController.text.trim(),
    );

    authProvider.addLabToFirestore(lab).then((_) {
      showSnackBar(context, 'Lab added successfully!');
      // Clear the text controllers after adding the lab
      labNameController.clear();
      labAddressController.clear();
      labTestsController.clear();
      labTimingsController.clear();
    }).catchError((error) {
      showSnackBar(context, 'Error adding lab: $error');
    });
  }
}