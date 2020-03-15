import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'dateconvert.dart';
//import 'viewentry.dart';
import 'models/postEntry.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  LocationData locationData;

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState( () {} );
  }
  int _counter = 0;

  /*void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return wasteScaffold();
  }
  
    Widget locationText() {
    if (locationData == null){
      return Center(child: CircularProgressIndicator());
    } else {
      return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Latitude: ${locationData.latitude}'),
          Text('Longitude: ${locationData.longitude}'),
        ],
      ),
      );
    }
  }
  Widget wasteScaffold() {
    return StreamBuilder(
      
      stream: Firestore.instance.collection('wasteList').orderBy('date', descending: true).snapshots(),
      builder: (content, snapshot) {
        if(snapshot.data.documents.length > 0) {
                    return Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Center(child: Text(widget.title + "${snapshot.data.documents.length.toString()}")),
            ),
            body: Container(
              child: LayoutBuilder(builder: (context, constraints) {
                return ListView.builder(itemCount: snapshot.data.documents.length, 
                  itemBuilder: (context, index) {
                    var post = snapshot.data.documents[index];
                    print(DateTime.now().millisecondsSinceEpoch);
                    return ListTile(
                      leading: Column(mainAxisAlignment: MainAxisAlignment.center, 
                      children:[Text(convertDate(post['date'])),]),
                      trailing: Text(post['items'].toString()),
                      onTap: () => onTapped(post)
                    );
                  }
                );
                }
              ),
            ),
            floatingActionButton: Semantics(
              button: true,
              enabled: true,
              onTapHint: 'Create a new post',
              child: FloatingActionButton(
                onPressed: () {Navigator.pushNamed(context, "/createEntry");},
                child: Icon(Icons.add),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // This trailing comma makes auto-formatting nicer for build methods.
          );
        }
        else {
          return new Scaffold(
            appBar: AppBar(
              title: Center(child: Text(widget.title + "0")),
            ),
            body: new Container( child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator()]
              ),
              ),
            ),
            floatingActionButton: Semantics(
              button: true,
              enabled: true,
              onTapHint: 'Create a new post',
              child: FloatingActionButton(
                onPressed: () {Navigator.pushNamed(context, "/createEntry");},
                child: Icon(Icons.add),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // This trailing comma makes auto-formatting nicer for build methods.
          );
        }
      }
    );

  }

  void onTapped(post) {
    Navigator.pushNamed(context, 
      "/viewEntry", 
      arguments: WasteArguments(
        post['date'], 
        post['items'],
        post['latitude'],
        post['longitude'],
        post['photo'],
      )
    );
  }
  /*Widget hasData() {

  }*/
}