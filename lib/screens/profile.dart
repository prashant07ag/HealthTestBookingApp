import 'package:digi_diagnos/screens/phone.dart';
import 'package:digi_diagnos/screens/user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digi_diagnos/provider/auth_provider.dart';

import 'adminScreen.dart';
import 'editProfile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (authProvider.isLoading)
                    Center(child: CircularProgressIndicator())
                  else if (authProvider.isSignedIn)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(authProvider.userModel.profilePic as String),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Name: ${authProvider.userModel.name ?? "N/A"}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Phone: ${authProvider.userModel.phoneNumber ?? "N/A"}',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Bio: ${authProvider.userModel.bio ?? "N/A"}',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Email: ${authProvider.userModel.email ?? "N/A"}',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        // Add more user details here

                        if (authProvider.userModel.role == 'admin')
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color(0xFF3E69FE)),
                            ),
                            onPressed: () {
                              // Navigate to the developer screen
                              Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) => const AdminScreen(),
                              ));
                            },
                            child: Text('Go to Developer Screen'),
                          ),
                        // Add a decorative button with the logic
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xFF3E69FE)),
                          ),
                          onPressed: () async {
                            // Trigger loading data from Firestore
                            await authProvider.getDataFromFirestore();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Data loaded from Firestore')),
                            );
                            Navigator.push(context, MaterialPageRoute (
                              builder: (BuildContext context) => const EditProfileScreen(),
                            ),);
                          },
                          child: Text('Edit Profile'),
                        ),
                      ],
                    )
                  else
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          // Trigger loading data from Firestore

                          await authProvider.getDataFromFirestore();
                        },
                        child: Text('Load Data from Firestore'),
                      ),
                    ),
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 6.0,
                        ),]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(Icons.place),
                            title: Text('Addresses'),
                            onTap: () {
                              // Add your settings logic here
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.electric_bolt),
                            title: Text('Electronic Health Records'),
                            onTap: () {
                              // Add your settings logic here
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.settings),
                            title: Text('Settings'),
                            onTap: () {
                              // Add your settings logic here
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.contact_emergency),
                            title: Text('Contact Us'),
                            onTap: () {
                              // Add your settings logic here
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.logout),
                            title: Text('LogOut'),
                            onTap: () {
                              // Add your settings logic here
                              // Call the AuthProvider method for user sign out
                              AuthProvider().userSignOut();
                              Navigator.of(context).pushReplacement(MaterialPageRoute (
                                builder: (BuildContext context) => const RegisterScreen(),
                              ),); // Navigate to login screen
                            },
                          ),
                          // Add more menu items here
                        ],

                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.facebook, size: 30),
                          Icon(Icons.email, size: 30),
                          Icon(Icons.whatshot, size: 30),
                          Icon(Icons.facebook, size: 30),
                          Icon(Icons.email, size: 30),
                          Icon(Icons.whatshot, size: 30),
                          // Add more social media icons here
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
