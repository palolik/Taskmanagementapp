import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../staffdrawer.dart';
import 'newspage_staff.dart';

class CreateNews extends StatefulWidget {
  CreateNews({Key? key}) : super(key: key);

  @override
  CreateNewsInsertState createState() => CreateNewsInsertState();
}

class CreateNewsInsertState extends State<CreateNews> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  CollectionReference _reference = FirebaseFirestore.instance.collection('news');

  String imageUrl = '';


  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: MyStaffDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Text(
              'Create news ',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: _margin(),
            padding: EdgeInsets.symmetric(),
            child: TextFormField(
              controller: _titleController,
              enableInteractiveSelection: false,
              keyboardType: TextInputType.text,
              validator: (val) => val!.isEmpty ? 'Invalid' : null,
              decoration: kinputDecoration('Title', null),
            ),
          ),
          Container(
            margin: _margin(),
            child: TextFormField(
              controller: _descController,
              enableInteractiveSelection: false,
              keyboardType: TextInputType.text,
              validator: (val) => val!.isEmpty ? 'Invalid' : null,
              decoration: InputDecoration(
                labelText: 'Description',
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.only(left: 10, bottom: 150),
                border: const OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton.icon(
                onPressed: () async {
                  //Step 1:Pick image/
                    //Install image_picker
                    //Import the corresponding library

                    ImagePicker imagePicker = ImagePicker();
                    XFile? file =
                        await imagePicker.pickImage(source: ImageSource.gallery);
                    print('${file?.path}');

                    if (file == null) return;
                    //Import dart:core
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    //Step 2: Upload to Firebase storage/
                    //Install firebase_storage
                    //Import the library

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('news');
                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child('name');

                    //Handle errors/success
                    try {
                      //Store the file
                      await referenceImageToUpload.putFile(File(file!.path));
                      //Success: get the download URL
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                    } catch (error) {
                      //Some error occurred
                    }
                },
                icon: Icon(
                  color: Colors.brown,
                  Icons.upload_file,
                  size: 30,
                ),
                label: Text(
                  'Upload',
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 270),
            child: ElevatedButton(
              onPressed: () async{        

                if(imageUrl.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please upload an image')));
                return;
                }
               // if(key.currentState!.validate()){
                  String title = _titleController.text;
                  String description = _descController.text;

                  //create a map of data
                  Map<String, String> dataToSend = {
                    'title': title,
                    'decription': description,
                    'image': imageUrl,
                 };
                  //ADD A NEW ITEM
                  _reference.add(dataToSend);
                  deleteFormData(); // Call the delete function after posting
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => NewsStaffPage()));
                //}
              },
              child: Text('POST'),
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
            ),
          )
        ],
      ),
    );
  }

  Future<void> createNews(String title, String description) async {
    await FirebaseFirestore.instance.collection('news').add({
      'title': title,
      'description': description,
    });
  }

  Future<void> deleteFormData() async {
    _titleController.clear();
    _descController.clear();
  }

  InputDecoration kinputDecoration(String label, SuffixIcon) {
    return InputDecoration(
      suffixIcon: SuffixIcon,
      labelText: label,
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.all(15),
      border: const OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
    );
  }

  EdgeInsetsGeometry _margin() {
    return EdgeInsets.only(left: 20, right: 20, top: 10);
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text('News'),
      actions: <Widget>[
        IconButton(onPressed: null, icon: Icon(Icons.notifications)),
     ],);}}