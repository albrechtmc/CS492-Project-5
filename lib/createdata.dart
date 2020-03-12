import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';

class CreateEntry extends StatefulWidget {
  @override
  _CreateEntryState createState() => _CreateEntryState();
}

class _CreateEntryState extends State<CreateEntry> {

File image;
//String url;
final formKey = GlobalKey<FormState>();
int numberOfItems;
LocationData locationData;

void initState() {
  super.initState();
  retrieveLocation();
}

void retrieveLocation() async {
  var locationService = Location();
  locationData = await locationService.getLocation();
  setState(() {});
}

void takePhoto() async {
  image = await ImagePicker.pickImage(source: ImageSource.camera);
  setState( () {} );
}
void getPhoto() async {
  image = await ImagePicker.pickImage(source: ImageSource.gallery);
  setState( () {} );
}

Future uploadImage(currentData) async {
  StorageReference storageReference = FirebaseStorage.instance.ref().child('${DateTime.now().millisecondsSinceEpoch}.jpg');
  StorageUploadTask uploadTask = storageReference.putFile(image);
  await uploadTask.onComplete;
  String url = await storageReference.getDownloadURL();
  print("URL is:" + url);
  //Firestore.instance.collection('wasteList').add({'photo': url});
  currentData.updateData({'photo': url});
}
/*Future<String> getURL() async {
  String url = await uploadImage();
  return (url);
}*/
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
        stream: Firestore.instance.collection('wasteList').snapshots(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Wasteagram"),
            ),
            body: Form(
              key: formKey,
              child: Center(
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
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: 'Number of Items',
                          border: OutlineInputBorder()),
                        onSaved: (value) {
                          numberOfItems = int.parse(value);
                        },
                        validator: (value) => validate(value),
                      ),
                      width: 250,
                    ),
                    SizedBox(height: 60),
                    RaisedButton(
                      onPressed: () {
                        print("HELLO");
                        if (formKey.currentState.validate()){
                          formKey.currentState.save();
                          DocumentReference currentData = Firestore.instance.collection('wasteList').document();
                          currentData.setData({
                            'date': DateTime.now().millisecondsSinceEpoch,
                            'items': numberOfItems,
                            'latitude': locationData.latitude,
                            'longitude': locationData.longitude,
                            'photo': "filler",
                          });
                          
                          uploadImage(currentData);
                          /*currentData.updateData({
                            //'date': DateTime.now().millisecondsSinceEpoch,
                            'items': numberOfItems,
                            //'latitude':
                            //'longitude':
                            //'photo':
                          });*/
                          Navigator.of(context).pop();
                        }
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
    if(value.isEmpty)
    return "Please enter a number";
    else return null;
  }
}