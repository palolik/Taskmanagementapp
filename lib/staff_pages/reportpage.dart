import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k9k10connect/pages/Circularprogress.dart';
import 'package:k9k10connect/staff_pages/editnews.dart';

class GetUserName extends StatefulWidget {
  final String id;
  const GetUserName({Key? key, required this.id}) : super(key: key);

  @override
  State<GetUserName> createState() => _GetUserNameState();
}

class _GetUserNameState extends State<GetUserName> {
  var cname = "";
  var tname = "";

  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final cnameController = TextEditingController();
  final tnameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    cnameController.dispose();
    tnameController.dispose();

    super.dispose();
  }

  clearText() {
    cnameController.clear();
    tnameController.clear();
  }

  CollectionReference students = FirebaseFirestore.instance.collection('news');

  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print('News Deleted'))
        .catchError((error) => print('Failed to Delete News: $error'));
  }

  Future<void> addUser() {
    return students
        .add({
          'cname': cname,
          'tname': tname,
        })
        .then((value) => print('Review Added'))
        .catchError((error) => print('Failed to Review user: $error'));
  }

  @override
  void initState() {
    // TODO: implement initState

    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('news');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.id).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          // return Text(
          //     "Full Name: ${data['coaching']} ${data['subject']} ${data['class']} ${data['address']}");
          return Scaffold(
            appBar: _buildAppBar(),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      // height: ,
                      color: const Color.fromARGB(255, 255, 255, 255),

                      // alignment: Alignment.topLeft,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Color.fromARGB(255, 223, 240, 255),
                              alignment: Alignment.center,
                              height: 250,
                              margin: const EdgeInsets.all(10.0),
                              width: double.infinity,
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 200,
                                              child: Image.network(
                                                  '${data['image']}')),
                                          Text(
                                            "${data['title']}",
                                            style: const TextStyle(
                                              fontSize: 17,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Raleway',
                                            ),
                                          ),
                                        ],
                                      ),
                                      flex: 2,
                                    ),
                                  ]),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text(
                                    "${data['description']}",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Raleway',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        {deleteUser(snapshot.data!.id)},
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditNewsPage(
                                              id: snapshot.data!.id),
                                        ),
                                      )
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ])
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          );

          // this bracket is the main braket
        }

        return const CircularProgress();
      },
    );
  }
}

AppBar _buildAppBar() {
  return AppBar(
    centerTitle: true,
    title: Text('News'),
    actions: <Widget>[
      IconButton(onPressed: null, icon: Icon(Icons.notifications)),
    ],
  );
}
