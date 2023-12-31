import 'package:flutter/material.dart';
import '../model/labModal.dart';

class CartProvider with ChangeNotifier {
  List<LabTestModel> _cartItems = [];
  String? _appliedCoupon;
  double _totalAmount = 0.0;
  Map<LabTestModel, int> _itemQuantities = {};

  List<LabTestModel> get cartItems => _cartItems;
  String? get appliedCoupon => _appliedCoupon;
  double get totalAmount => _totalAmount;

  bool isInCart(LabTestModel test) {
    return _cartItems.contains(test);
  }

  void addToCart(LabTestModel test) {
    if (_itemQuantities.containsKey(test)) {
      _itemQuantities[test] = _itemQuantities[test]! + 1;
    } else {
      _itemQuantities[test] = 1;
      _cartItems.add(test);
    }
    _totalAmount += test.testPrice;
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    _itemQuantities.clear();
    _totalAmount = 0.0;
    _appliedCoupon = null;
    notifyListeners();
  }


  void removeFromCart(LabTestModel test) {
    if (_itemQuantities.containsKey(test)) {
      _itemQuantities[test] = _itemQuantities[test]! - 1;
      if (_itemQuantities[test]! == 0) {
        _itemQuantities.remove(test);
        _cartItems.remove(test);
      }
      _totalAmount -= test.testPrice;
      notifyListeners();
    }
  }

  void incrementItem(LabTestModel test) {
    addToCart(test);
  }

  void decrementItem(LabTestModel test) {
    removeFromCart(test);
  }

  int getItemCount(LabTestModel test) {
    return _itemQuantities.containsKey(test) ? _itemQuantities[test]! : 0;
  }

  double getTotalAmount() {
    return _totalAmount;
  }

  void applyCoupon(String couponCode) {
    // Add logic to check the validity of the coupon code
    // Update the total amount accordingly
    // For simplicity, let's assume a 10% discount for the applied coupon
    if (_appliedCoupon == null) {
      _appliedCoupon = couponCode;
      _totalAmount *= 0.9; // 10% discount
      notifyListeners();
    }
  }
}
