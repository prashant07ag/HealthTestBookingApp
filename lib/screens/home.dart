import 'package:digi_diagnos/screens/testDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/labModal.dart';
import '../model/testModal.dart';
import '../provider/auth_provider.dart';
import '../widgets/labCard.dart';
import 'allLabs.dart';
import 'allServices.dart';

class HomeScreen extends StatelessWidget {
  List<String> services = [
    "Blood Test",
    "Urine Test",
    "HFT",
    "LFT",
    "Neurology",
    "Cardiology",
  ];

  List<String> packages = [
    "influenza respiratory",
    "iron deficiency",
    "fever",
    "pregnancy",
    "infertility for male",
    "infertility for female",
  ];
  List<String> tests = [
    "Dengue",
    "HIV",
    "Typhoid",
    "Pragnancy",
    "Xray",
    "Blood",
  ];
  List<String> labs = [
    "lab1",
    "Lab2",
  ];
  List<String> packages_imagePaths = [
    'assets/images/influenza.jpg',
    'assets/images/irontest.jpg',
    'assets/images/fever.jpg',
    'assets/images/influenza.jpg',
    'assets/images/irontest.jpg',
    'assets/images/fever.jpg',
    // Add more image paths as needed
  ];

  List<String> tests_imagePaths = [
    'assets/images/doctor4.jpg',
    'assets/images/doctor2.jpg',
    'assets/images/doctor3.jpg',
    'assets/images/doctor4.jpg',
    'assets/images/doctor2.jpg',
    'assets/images/doctor3.jpg',
    // Add more image paths as needed
  ];

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.grey,
        title: Text('DigiDiagnose',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
        ),
        ),
      ),
      drawer: Drawer(
        // Add your side menu content here
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFF3E69FE),
                    shape: BoxShape.rectangle,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(authProvider.userModel.profilePic ?? ""),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            authProvider.isSignedIn ? authProvider.userModel.name ?? "" : "Guest User",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            authProvider.isSignedIn ? authProvider.userModel.phoneNumber ?? "" : "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            authProvider.isSignedIn ? authProvider.userModel.email ?? "" : "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // ... Rest of your Drawer items
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.home),
                      SizedBox(width: 8,),
                      Text('Home',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                  onTap: () {
                    // Add action for menu item 1
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                Divider(
                  thickness: 2,
                  indent: 40,
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.search_rounded),
                      SizedBox(width: 8,),
                      Text('Search',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                  onTap: () {
                    // Add action for menu item 2
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                Divider(
                  thickness: 2,
                  indent: 40,
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.book_rounded),
                      SizedBox(width: 8,),
                      Text('Blogs',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                  onTap: () {
                    // Add action for menu item 2
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                Divider(
                  thickness: 2,
                  indent: 40,
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.calendar_month_outlined),
                      SizedBox(width: 8,),
                      Text('Bookings',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                  onTap: () {
                    // Add action for menu item 2
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                Divider(
                  thickness: 2,
                  indent: 40,
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.percent_sharp),
                      SizedBox(width: 8,),
                      Text('Offers',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                  onTap: () {
                    // Add action for menu item 2
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                Divider(
                  thickness: 2,
                  indent: 40,
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 8,),
                      Text('Profile',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                  onTap: () {
                    // Add action for menu item 2
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                Divider(
                  thickness: 2,
                  indent: 40,
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.contact_phone),
                      SizedBox(width: 8,),
                      Text('Contact Us',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                  onTap: () {
                    // Add action for menu item 2
                    Navigator.pop(context); // Close the drawer
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/doctor1.jpg"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Hello ',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'Hamza!',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_alert),
                    onPressed: () {
                      // Add your filter action here
                    },
                  ),
                ],
              ),
            ),
            // SizedBox(height: 5),
            SizedBox(height: 10), // Add some spacing
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search_rounded,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search services",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                      width:
                          10), // Add spacing between search bar and filter icon
                  IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () {
                      // Add your filter action here
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Services",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Add action to "See All" button
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AllTestsScreen()),
                          );
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(Color(0xFF3E69FE)),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          elevation: MaterialStateProperty.all(5),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "See All",
                              style: TextStyle(fontSize: 12),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder<List<TestModel>>(
                    future: authProvider.fetchTests(),
                    builder: (context, testSnapshot) {
                      if (testSnapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (testSnapshot.hasError) {
                        return Center(child: Text("Error: ${testSnapshot.error}"));
                      } else if (!testSnapshot.hasData || testSnapshot.data!.isEmpty) {
                        return Center(child: Text("No tests available."));
                      } else {
                        List<TestModel> tests = testSnapshot.data!;

                        return GridView.builder(
                          shrinkWrap: true,
                          controller: ScrollController(
                            keepScrollOffset: false,
                          ),
                          padding: EdgeInsets.only(top: 10.0),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3 items per row
                            mainAxisSpacing: 10.0, // Add vertical spacing
                            crossAxisSpacing: 10.0, // Add horizontal spacing
                          ),
                          itemCount: tests.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Add your logic here when a test is pressed
                                print('Test pressed: ${tests[index].name}');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => TestDetailsScreen(test: tests[index])
                                ));},
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF3E69FE),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.health_and_safety_rounded,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                    // Add your image here
                                    Container(
                                      padding: EdgeInsets.all(2.0),
                                      child: Text(
                                        tests[index].name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),


            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Labs",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Add action to "See All" button
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AllLabsScreen()),
                          );
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Set a circular border radius
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFF3E69FE)),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(5)),
                        child: Row(
                          children: [
                            Text(
                              "See All",
                              style: TextStyle(fontSize: 12),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  FutureBuilder<List<LabModel>>(
                    // Replace with the actual method to fetch the top 2 labs
                    future: authProvider.fetchLabs(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("Error: ${snapshot.error}"),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text("No top labs available."),
                        );
                      } else {
                        // Use the fetched list of top labs to create LabCard widgets
                        List<LabModel> topLabs = snapshot.data!;

                        return Column(
                          children: [
                            LabCard(lab: topLabs[0]),
                            SizedBox(height: 5),
                            LabCard(lab: topLabs[1]),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "LifeStyle Packages",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Set a circular border radius
                              ),
                            ),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          // Add action to "See All" button
                        },
                        child: Row(
                          children: [
                            Text("View All"),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ],
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10.0),
                    controller: ScrollController(
                      keepScrollOffset: false,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // 3 items per row
                      mainAxisSpacing: 10.0, // Add vertical spacing
                      crossAxisSpacing: 10.0, // Add horizontal spacing
                    ),
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          // color: Color(0xFF3E69FE)Accent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              packages_imagePaths[
                                  index], // Use dynamic image path
                              width: 80, // Adjust the width as needed
                              height: 60, // Adjust the height as needed
                            ),
                            SizedBox(
                                height:
                                    2), // Add spacing between image and text
                            Expanded(
                              child: Text(
                                packages[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors
                                      .black, // Set the text color to black
                                ),
                                textAlign: TextAlign.center,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular Test",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Set a circular border radius
                              ),
                            ),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          // Add action to "See All" button
                        },
                        child: Row(
                          children: [
                            Text("View All"),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            // color: Color(0xFF3E69FE)Accent,
                            // border: Border.all(width: 1),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Add your image here from assets
                              Image.asset(
                                tests_imagePaths[
                                    index], // Replace with your image asset path
                                width: 60, // Adjust the width as needed
                                height: 60, // Adjust the height as needed
                              ),
                              SizedBox(
                                  height:
                                      5), // Add spacing between image and text
                              Text(
                                tests[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular Profiles",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Set a circular border radius
                              ),
                            ),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          // Add action to "See All" button
                        },
                        child: Row(
                          children: [
                            Text("View All"),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            // border: Border.all(width: 1),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Add your image here from assets
                              Image.asset(
                                tests_imagePaths[
                                    index], // Replace with your image asset path
                                width: 60, // Adjust the width as needed
                                height: 60, // Adjust the height as needed
                              ),
                              // Add spacing between image and text
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFF3E69FE),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Not Sure About Your Test",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          child: TextButton(
                            onPressed: () {
                              // Add your action here
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20), // Set a circular border radius
                                  ),
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            child: Row(
                              children: [
                                Icon(Icons.call),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
