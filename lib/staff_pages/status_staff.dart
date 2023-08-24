import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k9k10connect/drawer.dart';

class StatusStaffPage extends StatelessWidget{
  const StatusStaffPage({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorSchemeSeed: Color(0xFFD7CCC8),
          useMaterial3: true
      ),
      home: const MyStatusPage(),
    );
  }
}

class MyStatusPage extends StatefulWidget{
  const MyStatusPage({super.key});

  @override
  State<MyStatusPage> createState()=> _MyStatusPageState();
}

class _MyStatusPageState extends State<MyStatusPage>{
  TextEditingController dateController = TextEditingController();

  @override
  void initState(){
    super.initState();
    dateController.text = "";
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              alignment: Alignment(1, 1),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  ListTile(
                    title: Text('Name: '),
                  ),
                  ListTile(
                    title: Text('Location: '),
                  ),
                  ListTile(
                    title: Text('Civil Damage: '),
                  ),
                  ListTile(
                    title: Text('Description: '),
                  ),
                  ListTile(
                    title: Text('Status: Pending'),
                  ),
                  ListTile(
                    title: Text('In action: '),
                  ),
                  SizedBox(
                    child: TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: "Enter Date"
                      ),
                      readOnly: true, // when true user cannot edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate: DateTime.now(), // not to allow to choose before today.
                          lastDate: DateTime(2101),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Color(0xFFD7CCC8),
                                  onPrimary: Colors.black,
                                  onSurface: Colors.black,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      primary: Colors.black,
                                    )
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if(pickedDate != null){
                          print(pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                          print(formattedDate); //formatted date output using intl package =>  16-03-2023

                          setState(() {
                            dateController.text = formattedDate;
                          });
                        } else{
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 80.0)),
                  ElevatedButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.blueGrey[50],
                              title: Container(
                                width: 250,
                                height: 50,
                                padding: EdgeInsets.only(
                                  left: 90,
                                  right: 90,
                                ),
                                child: Text('Saved'),
                              ),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.deepOrange[100],
                                        onPrimary: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.only(
                                          left: 50,
                                          right: 50,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          });
                    },
                    child: Text('Save'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange[100],
                      onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.only(
                        left: 30.0,
                        right: 30.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _doNothing(){}

AppBar _buildAppBar(){
  return AppBar(
    centerTitle: true,
    title: Text('Status'),
    actions: <Widget>[
      IconButton(onPressed: _doNothing, icon: Icon(Icons.notifications)),
    ],
  );
}