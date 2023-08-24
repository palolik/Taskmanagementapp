import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:k9k10connect/drawer.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _emailController = TextEditingController();
  late String _currentUserId;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override void initState(){
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    _currentUserId = currentUser?.uid ?? '';
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(_currentUserId) // Replace with the user's document ID
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var userData = snapshot.data!.data() as Map<String, dynamic>?;

                if (userData != null) {
                  var firstName = userData['first name'] ?? '';
                  var lastName = userData['last name'] ?? '';
                  var phoneNo = userData['phone no.'] ?? '';
                  var location = userData['location'] ?? '';
                  var email = userData['email'] ?? '';

                  _nameController.text = '$firstName $lastName';
                  _phoneController.text = phoneNo;
                  _locationController.text = location;
                  _emailController.text = email;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment(-1, 1),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 170,
                              height: 170,
                              child: GestureDetector(
                                onTap: () {
                                  // Handle profile picture upload
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 80,
                                      backgroundImage: AssetImage(
                                          'assets/images/profile.jpg'),
                                      // Replace with the user's profile picture
                                      backgroundColor: Colors.grey[300],
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 10,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 4,
                                              color: Colors.white
                                          ),
                                          color: Color.fromARGB(
                                              255, 179, 179, 179),
                                        ),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20.0)),
                            ListTile(
                              title: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Name',
                                  hintText: 'Enter Your Name',
                                  icon: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                ),
                                controller: _nameController,
                              ),
                            ),
                            ListTile(
                              title: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Phone No',
                                  hintText: 'Enter Your Phone No.',
                                  icon: Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                  ),
                                ),
                                controller: _phoneController,
                              ),
                            ),
                            ListTile(
                              title: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Location',
                                  hintText: 'Enter Your Location',
                                  icon: Icon(
                                    Icons.location_pin,
                                    color: Colors.black,
                                  ),
                                ),
                                controller: _locationController,
                              ),
                            ),
                            ListTile(
                              title: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Email',
                                  hintText: 'Enter Your Email',
                                  icon: Icon(
                                    Icons.mail,
                                    color: Colors.black,
                                  ),
                                ),
                                controller: _emailController,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 50)
                            ),
                            ElevatedButton(
                              onPressed: _updateUserData,
                              child: Text('Update'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey[300],
                                onPrimary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.only(
                                  left: 30.0,
                                  right: 30.0,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  );
                }
              } else if (snapshot.hasError) {
                return Text('Error fetching user data');
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  void _updateUserData() {
    final name = _nameController.text;
    final phone = _phoneController.text;
    final location = _locationController.text;
    final email = _emailController.text;

    // Get the reference to the user document in Firebase
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUserId); // Replace with the user's document ID

        // .doc('N7GrFCOn0Hv8aTBwJxrQ'); // Replace with the user's document ID

    // Update the user data using the update method
    userRef.update({
      'email': email,
      'first name': name,
      'last name': '',
      'location': location,
      'phone no': phone,
    }).then((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('User details updated successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to update user details.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    });
  }
}

void _doNothing() {}

AppBar _buildAppBar() {
  return AppBar(
    centerTitle: true,
    title: Text('Profile'),
    actions: <Widget>[
      IconButton(onPressed: _doNothing, icon: Icon(Icons.notifications)),
    ],
  );
}


