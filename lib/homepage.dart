import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k9k10connect/drawer.dart';
import 'package:k9k10connect/screens/signin_screen.dart';
import 'package:k9k10connect/pages/report.dart';
import 'package:k9k10connect/pages/newspage.dart';
import 'package:k9k10connect/pages/profile.dart';
import 'package:k9k10connect/pages/status.dart';
import 'package:k9k10connect/staff_pages/newspage_staff.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorSchemeSeed: Color(0xff6750a4), useMaterial3: true
          // primarySwatch: Colors.blue,
          ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late User? currentUser;
  String? displayName; 

  @override
  void initState(){
    super.initState();
    getCurrentUser();
    getUserDisplayName();
  }

  void getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    print('Current user: $user');
    setState(() {
      currentUser = user;
    });
  }

  void getUserDisplayName() async{
    print('Fetching display name');
    if (currentUser != null) {
      String uid = currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
      String? firstName = snapshot.data()?['first name'];
      String? lastName = snapshot.data()?['last name'];
      String? displayName = '$firstName $lastName';
      setState(() {
        this.displayName = displayName;
        print('Updated display name: $displayName');
      });
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    getCurrentUser();
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => signOut(),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Hello! \n${displayName ?? ""}',
              style: TextStyle(
                fontSize: 65,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 150,
                    color: Color.fromARGB(255, 211, 214, 227),   
                    child: const Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    child: IconButton(
                      icon: const Icon(Icons.person),
                      iconSize: 30,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfilePage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 150,
                // color: Colors.green,
                color: Color.fromARGB(255, 201, 203, 187),
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      right: 55,
                      child: IconButton(
                        icon: const Icon(Icons.pending_actions),
                        // color: Colors.white,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StatusPage()),
                          );
                        },
                      ),
                    ),
                    const Positioned(
                      child: Center(
                        child: Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 20,
                            //color: Colors.white,
                           // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 150,
                    // color: Colors.lightBlue,
                    color: Color.fromARGB(255, 232, 208, 180),
                    child: const Center(
                      child: Text(
                        'Report',
                        style: TextStyle(
                          //color: Colors.white,
//fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    child: IconButton(
                      icon: const Icon(Icons.report),
                      // color: Colors.white,
                      iconSize: 30,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const report()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 150,
                // color: Colors.grey,
                color: Color.fromARGB(255, 71, 18, 42),
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      right: 55,
                      child: IconButton(
                        icon: const Icon(Icons.article),
                        color: Color.fromARGB(255, 201, 203, 187),

                        // color: Colors.white,

                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsStaffPage()),
                          );
                        },
                      ),
                    ),
                    const Positioned(
                      child: Center(
                        child: Text(
                          'News',
                          style: TextStyle(
                            color: Color.fromARGB(255, 201, 203, 187),
                            // fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}