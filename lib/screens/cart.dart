import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/labModal.dart';
import '../provider/cart_provider.dart';

class CartScreen extends StatelessWidget {
  final CartProvider cartProvider;

  CartScreen({
    required this.cartProvider,
  });

  @override
  Widget build(BuildContext context) {
    double totalAmount = cartProvider.getTotalAmount();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                LabTestModel test = cartProvider.cartItems[index];

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(test.testName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\$${test.testPrice.toString()}'),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cartProvider.incrementItem(test);
                                  },
                                  icon: Icon(Icons.add),
                                ),
                                Text('${cartProvider.getItemCount(test)}'),
                                IconButton(
                                  onPressed: () {
                                    cartProvider.decrementItem(test);
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Enter Coupon Code'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    String couponCode =
                        'YOUR_COUPON_CODE'; // Replace with actual coupon code
                    cartProvider.applyCoupon(couponCode);
                  },
                  child: Text('Apply Coupon'),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Assuming you have a function to process the payment
                bool paymentSuccessful = processPayment(cartProvider.getTotalAmount());

                if (paymentSuccessful) {
                  // Show a success message or navigate to a success screen
                  showSuccessDialog(context);

                  // Clear the cart after successful payment
                  cartProvider.clearCart();
                } else {
                  // Show an error message or handle the failure
                  showErrorDialog(context);
                }
              },
              child: Text('Proceed to Payment'),
            ),

          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}


bool processPayment(double totalAmount) {
  // Replace this with your actual payment processing logic
  // Return true if payment is successful, false otherwise
  // For simplicity, we're assuming all payments are successful
  return true;
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Payment Successful'),
        content: Text('Thank you for your purchase!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void showErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Payment Error'),
        content: Text('There was an error processing your payment. Please try again.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
