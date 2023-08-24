import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNewsPage extends StatefulWidget {
  final String id;
  EditNewsPage({Key? key, required this.id}) : super(key: key);

  @override
  _EditNewsPageState createState() => _EditNewsPageState();
}

class _EditNewsPageState extends State<EditNewsPage> {
  final _formKey = GlobalKey<FormState>();

  // Updaing Student
  CollectionReference news = FirebaseFirestore.instance.collection('news');

  Future<void> updateUser(id, title, description) {
    return news
        .doc(id)
        .update({
          'title': title,
          // 'createdAt': createdAt,
          'description': description
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('news')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var title = data!['title'];
              // var createdAt = data['createdAt'];
              var description = data['description'];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: title,
                        autofocus: false,
                        onChanged: (value) => title = value,
                        decoration: InputDecoration(
                          labelText: 'Title: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {}
                          return null;
                        },
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 10.0),
                    //   child: TextFormField(
                    //     initialValue: createdAt,
                    //     autofocus: false,
                    //     onChanged: (value) => createdAt = value,
                    //     decoration: InputDecoration(
                    //       labelText: 'createdAt: ',
                    //       labelStyle: TextStyle(fontSize: 20.0),
                    //       border: OutlineInputBorder(),
                    //       errorStyle:
                    //           TextStyle(color: Colors.redAccent, fontSize: 15),
                    //     ),
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {}
                    //       return null;
                    //     },
                    //   ),
                    // ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: description,
                        autofocus: false,
                        onChanged: (value) => description = value,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'description: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {}
                          return null;
                        },
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState!.validate()) {
                                updateUser(widget.id, title, description);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )),
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
