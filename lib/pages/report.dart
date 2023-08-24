import 'package:flutter/material.dart';
import 'package:k9k10connect/drawer.dart';

class report extends StatefulWidget {
  const report({Key? key}) : super(key: key);

  @override
  _reportState createState() => _reportState();
}

class _reportState extends State<report> {
  String? _categoryValue;

  void _submitReport() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Submitted'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: MyDrawer(),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Location'),
          ),
          ListTile(
            title: TextField(
              decoration: InputDecoration(
                hintText: 'Enter location',
              ),
            ),
          ),
          ListTile(
            title: Text('Damage Category'),
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('Civil damage'),
                    value: 'Civil damage',
                    groupValue: _categoryValue,
                    onChanged: (value) {
                      setState(() {
                        _categoryValue = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('Electrical damage'),
                    value: 'Electrical damage',
                    groupValue: _categoryValue,
                    onChanged: (value) {
                      setState(() {
                        _categoryValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('Furniture damage'),
                    value: 'Furniture damage',
                    groupValue: _categoryValue,
                    onChanged: (value) {
                      setState(() {
                        _categoryValue = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('Others'),
                    value: 'Others',
                    groupValue: _categoryValue,
                    onChanged: (value) {
                      setState(() {
                        _categoryValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Description'),
          ),
          ListTile(
            title: TextField(
              decoration: InputDecoration(
                hintText: 'Enter description',
              ),
            ),
          ),
          ListTile(
            title: Text('Damage Photos'),
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.attach_file),
                    label: Text('Add file'),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: ElevatedButton(
              onPressed: _submitReport,
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  void _doNothing() {}

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text('Report'),
      actions: <Widget>[
        IconButton(onPressed: _doNothing, icon: Icon(Icons.notifications)),
      ],
    );
  }
}
