import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k9k10connect/drawer.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: buildContainer(context),
      drawer: MyDrawer(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu),
        color: Colors.black,
        onPressed: () {},
      ),
      title: Text('News'),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          color: Colors.black,
          onPressed: () {},
        ),
      ],
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('news').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> data =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  Timestamp? timestamp = data['timestamp'];

                  DateTime dateTime;
                  String formattedDate;

                  if (timestamp != null) {
                    dateTime = timestamp.toDate();
                  } else {
                    dateTime = DateTime.now();
                  }

                  formattedDate =
                      '${dateTime.day}/${dateTime.month}/${dateTime.year}';

                  return ListTile(
                    leading: Image.asset('assets/images/Screenshot1.png'),
                    title: Text(data['title']),
                    subtitle: Text(data['description']),
                    textColor: Colors.black,
                    tileColor: Colors.grey[300],
                    trailing: Text(formattedDate),
                    onTap: () {
                      _showDeleteConfirmationDialog(
                          context, snapshot.data!.docs[index].id);
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete News'),
          content: Text('Are you sure you want to delete?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                _deleteNewsItem(documentId);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteNewsItem(String documentId) {
    FirebaseFirestore.instance.collection('news').doc(documentId).delete();
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text('News'),
      actions: <Widget>[
        IconButton(onPressed: null, icon: Icon(Icons.notifications)),
      ],
    );
  }
}
