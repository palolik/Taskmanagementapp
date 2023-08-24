import 'package:flutter/material.dart';
import 'package:k9k10connect/drawer.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  void _doNothing() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildContainer(),
      drawer: MyDrawer(),
    );
  }


  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text('Status'),
      actions: <Widget>[
        IconButton(onPressed: _doNothing, icon: Icon(Icons.notifications)),
      ],
    );
  }

  Container buildContainer() {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: 'Search',
              ),
            ),
          ),
          ListTile(
            title: Text("Name: "),
            textColor: Colors.black,
            subtitle: Text("Location: \nCivil Damage: "),
            isThreeLine: true,
            tileColor: Colors.grey[300],
            trailing: const SizedBox(
              width: 100.0,
              height: 50.0,
              child: Card(
                  color: Color.fromARGB(255, 186, 151, 139),
                  child: Center(
                    child:
                    Text("Pending", style: TextStyle(color: Colors.black),),

                  )

                //: Text("Scheduled on 12/3/2023"),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text("Name: "),
            textColor: Colors.black,
            subtitle: Text("Location: \nCivil Damage: "),
            isThreeLine: true,
            tileColor: Colors.grey[300],
            trailing: const SizedBox(
              width: 100.0,
              height: 50.0,
              child: Card(
                  color: Color.fromARGB(255, 68, 11, 27),
                  child: Center(
                    child: Text("In-action",
                        style: TextStyle(color: Colors.white)),
                  )

                //: Text("Scheduled on 12/3/2023"),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text("Name: "),
            textColor: Colors.black,
            subtitle: Text("Location: \nCivil Damage: "),
            isThreeLine: true,
            tileColor: Colors.grey[300],
            trailing: const SizedBox(
              width: 100.0,
              height: 50.0,
              child: Card(
                  color: Color.fromARGB(180, 245, 245, 245),
                  child: Center(
                    child:
                    Text("Resolved", style: TextStyle(color: Colors.grey)),
                  )

                //: Text("Scheduled on 12/3/2023"),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text("Name: "),
            textColor: Colors.black,
            subtitle: Text("Location: \nCivil Damage: "),
            isThreeLine: true,
            tileColor: Colors.grey[300],
            trailing: const SizedBox(
              width: 100.0,
              height: 50.0,
              child: Card(
                  color: Color.fromARGB(255, 68, 11, 27),
                  child: Center(
                    child: Text("In-action",
                        style: TextStyle(color: Colors.white)),
                  )

                //: Text("Scheduled on 12/3/2023"),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text("Name: "),
            textColor: Colors.black,
            subtitle: Text("Location: \nCivil Damage: "),
            isThreeLine: true,
            tileColor: Colors.grey[300],
            trailing: const SizedBox(
              width: 100.0,
              height: 50.0,
              child: Card(
                  color: Color.fromARGB(255, 186, 151, 139),
                  child: Center(
                    child:
                    Text("Pending", style: TextStyle(color: Colors.black)),
                  )

                //: Text("Scheduled on 12/3/2023"),
              ),
            ),
          ),
        ],
      ),
      //decoration: BoxDecoration(color: Colors.blueGrey),
    );
  }
}

