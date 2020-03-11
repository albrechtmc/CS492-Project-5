import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreateEntry extends StatefulWidget {
  @override
  _CreateEntryState createState() => _CreateEntryState();
}

class _CreateEntryState extends State<CreateEntry> {

File image;
final formKey = GlobalKey<FormState>();
int numberOfItems;

void takePhoto() async {
  image = await ImagePicker.pickImage(source: ImageSource.camera);
  setState( () {} );
}
void getPhoto() async {
  image = await ImagePicker.pickImage(source: ImageSource.gallery);
  setState( () {} );
}
//static double width = MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {

    if (image == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Wasteagram"),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  takePhoto();
                },
                child: Text("Take Photo"),
              ), 
              RaisedButton(
                onPressed: () {
                  getPhoto();
                },
                child: Text("Select Photo"),
              ), 
            ]
            ),
        )
      );
    }
    else {
      return StreamBuilder(
        stream: Firestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Wasteagram"),
            ),
            body: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height:10),
                  Expanded(child:Image.file(image)),
                  SizedBox(height: 10),
                  Text("Number of Items"),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Number of Items',
                        border: OutlineInputBorder()),
                      onSaved: (value) {
                        numberOfItems = value as int;
                      },
                      validator: (value) => validate(value),
                    ),
                    width: 250,
                  ),
                  SizedBox(height: 60),
                  RaisedButton(
                    onPressed: () {
                      /*Firestore.instance.collection('posts').add({
                        'date': DateTime.now().millisecondsSinceEpoch,
                        'items':
                        'latitude':
                        'longitude':
                        'photo':
                      })*/
                    },
                    child: SizedBox(
                      width: 300,
                      child: Center(child: Text("Upload")),
                      height: 100,
                      ),   
                    color: Colors.blue,               
                  ), 
                  SizedBox(height:25)
                ]
                ),
            ),
            resizeToAvoidBottomInset: false,
          );
        }
      );
      
    }
  }
  void uploadButton() {

  }
  String validate(value){
    if(value.length < 1)
    return "Please enter a number";
    else return null;
  }
}