import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        surfaceTintColor: Colors.black,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Row(
          children: [
            Text('Edit Profile'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 16),
            // Profile Picture Editing Section
            ProfilePictureEdit(),

            SizedBox(height: 16),
            // Edit Profile Form
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: EditProfileForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePictureEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 40,
              child: Icon(Icons.person,size: 40,)),
          SizedBox(height: 5),
          TextButton(
            onPressed: () {
              // Add logic to open a dialog or navigate to a screen for profile picture selection/editing
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Color(0xFF3E69FE)),
              backgroundColor: MaterialStateProperty.all(Colors.transparent)
            ),
            child: Text('Change Profile Picture',style: TextStyle(fontSize: 18),),
          ),
        ],
      ),
    );
  }
}

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({Key? key}) : super(key: key);

  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Example TextFormFields (customize based on your user details)
          Padding(padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Full Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Mobile No.'),
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Date of Birth'),
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          // Add more TextFormFields for other user details

          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Add logic to save the edited profile
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Profile updated successfully')),
                );
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
