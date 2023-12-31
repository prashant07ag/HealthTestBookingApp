import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../model/booking_model.dart';
import '../model/labModal.dart';
import '../model/testModal.dart';
import '../model/user_model.dart';
import '../screens/otp.dart';
import '../utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;
  List<BookingModel> _bookings = [];
  List<TestModel> _tests = [];
  List<LabModel> _labs = [];
  List<TestModel> get tests => _tests;
  List<LabModel> get labs => _labs;
  List<BookingModel> get bookings => _bookings;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider() {
    checkSign();
  }


  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  // signin
  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(verificationId: verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  // verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        // carry our logic
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }


  // DATABASE OPERTAIONS
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
    await _firebaseFirestore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      print("USER EXISTS");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required File profilePic,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
        userModel.profilePic = value;
        userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      });
      _userModel = userModel;

      // uploading to database
      await _firebaseFirestore
          .collection("users")
          .doc(_uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future getDataFromFirestore() async {
    await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
        name: snapshot['name'],
        email: snapshot['email'],
        createdAt: snapshot['createdAt'],
        bio: snapshot['bio'],
        uid: snapshot['uid'],
        profilePic: snapshot['profilePic'],
        phoneNumber: snapshot['phoneNumber'],
        role: snapshot['role'],
      );
      _uid = userModel.uid;
    });
  }

  // STORING DATA LOCALLY
  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }

  Future bookAppointment({
    required String appointmentDate,
    required String appointmentTime,
    required String appointmentStatus,
    required String paymentStatus,
    required String preferredPathologist,
    required String gender,
  }) async {
    try {
      String bookingId = _firebaseFirestore.collection("bookings").doc().id;

      BookingModel booking = BookingModel(
        id: bookingId,
        userId: _uid!,
        appointmentDate: appointmentDate,
        appointmentTime: appointmentTime,
        appointmentStatus: appointmentStatus,
        paymentStatus: paymentStatus,
        preferredPathologist: preferredPathologist,
        gender: gender,
      );

      await _firebaseFirestore
          .collection("bookings")
          .doc(bookingId)
          .set(booking.toMap());

      _bookings.add(booking);
      notifyListeners();
    } catch (e) {
      print("Error booking appointment: $e");
    }
  }

  Future<List<BookingModel>> getBookings() async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection("bookings")
          .where('userId', isEqualTo: _uid)
          .get();

      List<BookingModel> bookings = querySnapshot.docs
          .map((doc) => BookingModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return bookings;
    } catch (e) {
      print("Error getting bookings: $e");
      throw e; // Re-throw the exception to propagate it to the caller
    }
  }

  Future<void> deleteBooking(String bookingId) async {
    try {
      await _firebaseFirestore.collection("bookings").doc(bookingId).delete();

      _bookings.removeWhere((booking) => booking.id == bookingId);
      notifyListeners();
    } catch (e) {
      print("Error deleting booking: $e");
    }
  }

  Future<void> updateBooking({
    required String bookingId,
    required String appointmentDate,
    required String appointmentTime,
    required String appointmentStatus,
    required String paymentStatus,
    required String preferredPathologist,
    required String gender,
  }) async {
    try {
      await _firebaseFirestore.collection("bookings").doc(bookingId).update({
        'appointmentDate': appointmentDate,
        'appointmentTime': appointmentTime,
        'appointmentStatus': appointmentStatus,
        'paymentStatus': paymentStatus,
        'preferredPathologist': preferredPathologist,
        'gender': gender,
      });

      final updatedBookingIndex =
      _bookings.indexWhere((booking) => booking.id == bookingId);
      if (updatedBookingIndex != -1) {
        _bookings[updatedBookingIndex] = BookingModel(
          id: bookingId,
          userId: _uid!,
          appointmentDate: appointmentDate,
          appointmentTime: appointmentTime,
          appointmentStatus: appointmentStatus,
          paymentStatus: paymentStatus,
          preferredPathologist: preferredPathologist,
          gender: gender,
        );
        notifyListeners();
      }
    } catch (e) {
      print("Error updating booking: $e");
    }
  }

  Future<void> updateUserInfo({
    required String name,
    required String email,
    required String bio,
    required File profilePic,
    required String role,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
        _userModel!.profilePic = value;
      });

      await _firebaseFirestore.collection("users").doc(_uid).update({
        'name': name,
        'email': email,
        'bio': bio,
        'profilePic': _userModel!.profilePic,
        'role':role,
      });

      _userModel = UserModel(
        name: name,
        email: email,
        bio: bio,
        uid: _uid!,
        profilePic: _userModel!.profilePic,
        phoneNumber: _userModel!.phoneNumber,
        createdAt: '',
        role: role,
      );

      notifyListeners();
    } catch (e) {
      print("Error updating user info: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> rescheduleBooking(String bookingId, String newAppointmentDate, String newAppointmentTime) async {
    try {
      await _firebaseFirestore.collection("bookings").doc(bookingId).update({
        'appointmentDate': newAppointmentDate,
        'appointmentTime': newAppointmentTime,
      });

      // Update the local list of bookings or fetch them again
      await getBookings();
      notifyListeners();
    } catch (e) {
      print("Error rescheduling appointment: $e");
      throw e;
    }
  }

  Future<List<TestModel>> fetchTests() async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore.collection('services').get();
      _tests = querySnapshot.docs
          .map((doc) => TestModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return _tests;
    } catch (e) {
      print("Error fetching tests: $e");
      throw e;
    }
  }

  Future<List<LabModel>> fetchLabs() async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore.collection('labs').get();
      _labs = querySnapshot.docs
          .map((doc) => LabModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return _labs;
    } catch (e) {
      print("Error fetching labs: $e");
      throw e;
    }
  }

  Future<List<LabModel>> fetchLabsForTest(List<String> labIds) async {
    try {
      List<LabModel> labs = [];

      // Fetch labs using labIds
      for (String labId in labIds) {
        DocumentSnapshot labSnapshot = await FirebaseFirestore.instance
            .collection('labs')
            .doc(labId)
            .get();

        if (labSnapshot.exists) {
          LabModel lab = LabModel.fromMap(labSnapshot.data() as Map<String, dynamic>);
          labs.add(lab);
        }
      }

      return labs;
    } catch (e) {
      print("Error fetching labs for test: $e");
      throw e;
    }
  }

  Future<List<LabTestModel>> fetchLabTests(String labId) async {
    try {
      // Assuming you have a 'tests' subcollection in each 'lab' document
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('labs')
          .doc(labId)
          .collection('tests')
          .get();

      List<LabTestModel> tests = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return LabTestModel(
          testName: data['testName'] ?? '', // Adjust the field names based on your actual data model
          testPrice: data['testPrice'] ?? 0.0,
        );
      }).toList();

      return tests;
    } catch (e) {
      print("Error fetching lab tests: $e");
      throw e;
    }
  }


  Future<Map<String, int>> fetchTestsAndPricesForLab(String labId) async {
    try {
      // Assuming you have a 'labs' collection and each lab document has a 'tests' map field
      DocumentSnapshot labDocument = await FirebaseFirestore.instance.collection('labs').doc(labId).get();

      // Check if the lab document exists
      if (!labDocument.exists) {
        throw Exception('Lab with ID $labId not found.');
      }

      // Get the 'tests' map from the lab document
      Map<String, dynamic> testsMap = labDocument.get('tests') ?? {};

      // Convert the dynamic values to int and create a map of tests and prices
      Map<String, int> testsAndPrices = testsMap.map((testName, testPrice) =>
          MapEntry(testName, testPrice is int ? testPrice : int.parse(testPrice.toString())));

      return testsAndPrices;
    } catch (e) {
      // Handle errors, e.g., print an error message
      print('Error fetching tests and prices: $e');
      throw e; // Rethrow the error if necessary
    }
  }



  Future<List<LabModel>> fetchLabsForTestService(String testServiceId) async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('labs')
          .where('tests.${testServiceId}', isGreaterThan: 0)
          .get();

      List<LabModel> labs = querySnapshot.docs
          .map((doc) => LabModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return labs;
    } catch (e) {
      print("Error fetching labs for test service: $e");
      throw e;
    }
  }


  Future<void> addLabToFirestore(LabModel lab) async {
    try {
      await _firebaseFirestore.collection('labs').add(lab.toMap());
      print('Lab added to Firestore: ${lab.name}');
    } catch (e) {
      print('Error adding lab to Firestore: $e');
      throw e;
    }
  }

  Future<void> addTestToFirestore(TestModel test) async {
    try {
      await _firebaseFirestore.collection('services').add(test.toMap());
      print('Test added to Firestore: ${test.name}');
    } catch (e) {
      print('Error adding test to Firestore: $e');
      throw e;
    }
  }

  Future<LabModel?> getLabFromFirestore(String labId) async {
    try {
      DocumentSnapshot docSnapshot =
      await _firebaseFirestore.collection('labs').doc(labId).get();

      if (docSnapshot.exists) {
        LabModel lab = LabModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
        print('Lab retrieved from Firestore: ${lab.name}');
        return lab;
      } else {
        print('Lab not found in Firestore');
        return null;
      }
    } catch (e) {
      print('Error getting lab from Firestore: $e');
      throw e;
    }
  }



}
