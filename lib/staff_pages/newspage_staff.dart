import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k9k10connect/staff_pages/createnews.dart';
import 'package:k9k10connect/staff_pages/reportpage.dart';
import '../staffdrawer.dart';

class NewsStaffPage extends StatelessWidget {
  NewsStaffPage({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('news');

  //_reference.get()  ---> returns Future<QuerySnapshot>
  //_reference.snapshots()--> Stream<QuerySnapshot> -- realtime updates
  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: MyStaffDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Check error
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          //Check if data arrived
          if (snapshot.hasData) {
            //get the data
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            //Convert the documents to Maps
            List<Map> items = documents.map((e) => e.data() as Map).toList();

            //Display the list
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  //Get the item at this index
                  Map thisItem = items[index];
                  //REturn the widget for the list items
                  return ListTile(
                    title: Text('${thisItem['title']}'),
                    subtitle: Text('${thisItem['decription']}'),
                    textColor: Colors.black,
                    tileColor: Colors.grey[300],
                    // trailing: Text(formattedDate),
                    leading: Container(
                      height: 80,
                      width: 80,
                      child: thisItem.containsKey('image')
                          ? Image.network('${thisItem['image']}')
                          : Container(),
                    ),
                    // onTap: () {
                    //   _showDeleteConfirmationDialog(
                    //       context, snapshot.data!.docs[index].id);
                    // },

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              // UpdateStudentPage(
                              GetUserName(
                            id: snapshot.data!.docs[index].id,
                          ),
                        ),
                      );
                    },
                  );
                });
          }

          //Show loader
          return Center(child: CircularProgressIndicator());
        },
      ), //Display a list // Add a FutureBuilder
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreateNews()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _deleteNewsItem(String documentId) {
  FirebaseFirestore.instance.collection('news').doc(documentId).delete();
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
