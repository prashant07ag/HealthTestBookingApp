import 'package:digi_diagnos/provider/cart_provider.dart';
import 'package:digi_diagnos/screens/welcomScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import '../provider/auth_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCQ_OV4WSC3P-o1dOV6NhWjpJ-Wmpsh-Cw",
      appId: "1:2035463667:android:d24799d7963133c9620e86",
      messagingSenderId: "2035463667",
      projectId: "healthtest-35b89",
      storageBucket: "healthtest-35b89.appspot.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
        title: "Health_Diagnose",
        theme: ThemeData(
          primaryColor: Color(0xFF3E69FE), // Set the primary color
          textTheme: GoogleFonts.openSansTextTheme(), // Set the font using Google Fonts
    appBarTheme: AppBarTheme(
    color: Color(0xFF3E69FE), // Set the appbar background colo
    ),
        ),
      ),
    );
  }
}
