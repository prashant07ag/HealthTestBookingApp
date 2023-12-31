import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String labName;
  final String testName;
  final double testPrice;
  final String userId; // Assuming you want to associate the order with a user
  final DateTime timestamp; // Timestamp for the order
  final String timings; // Timings for the lab test
  final String paymentMethod; // Payment method used for the order
  final DateTime selectedDate; // Date for the lab test

  CartModel({
    required this.labName,
    required this.testName,
    required this.testPrice,
    required this.userId,
    required this.timestamp,
    required this.timings,
    required this.paymentMethod,
    required this.selectedDate,
  });

  // Factory method to create a CartModel from a Firestore document
  factory CartModel.fromFirestore(Map<String, dynamic> data) {
    return CartModel(
      labName: data['labName'] ?? '',
      testName: data['testName'] ?? '',
      testPrice: (data['testPrice'] ?? 0.0).toDouble(),
      userId: data['userId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      timings: data['timings'] ?? '',
      paymentMethod: data['paymentMethod'] ?? '',
      selectedDate: (data['selectedDate'] as Timestamp).toDate(),
    );
  }

  // Method to convert CartModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'labName': labName,
      'testName': testName,
      'testPrice': testPrice,
      'userId': userId,
      'timestamp': timestamp,
      'timings': timings,
      'paymentMethod': paymentMethod,
      'selectedDate': selectedDate,
    };
  }
}
