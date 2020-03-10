import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: Text(widget.title + "1")),
      ),
      body: Container(
        child: LayoutBuilder(builder: (context, constraints) {
          return wasteScaffold();
        },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // This trailing comma makes auto-formatting nicer for build methods.
    );
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
      stream: Firestore.instance.collection('wasteList').snapshots(),
      builder: (content, snapshot) {
        if(snapshot.hasData) {
          return ListView.builder(itemCount: snapshot.data.documents.length, 
          itemBuilder: (context, index) {
            var post = snapshot.data.documents[index];
            return ListTile(
              leading: Column(mainAxisAlignment: MainAxisAlignment.center, 
                children:[Text(post['date'].toString())]),
              trailing: Text(post['items'].toString()),
              onTap: () => onTapped(/*journal, index*/)
            );
          });
        }
        else {
          return Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator() ]
            ),
          );
        }
      }
    );
    /*if(/*list.entries.length == 0*/false) {
      return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator() ]
        ),
      );
    }
    else {
      return ListView.builder(itemCount: 1, itemBuilder: (context, index) {
        return ListTile(
          leading: Column(mainAxisAlignment: MainAxisAlignment.center, 
            children:[Text("Monday, March 8")]),
          trailing: Text("7"),
          onTap: () => onTapped(/*journal, index*/)
        );
      });
    }*/
  }

    void onTapped(/*journal, index*/) {
    Navigator.pushNamed(context, 
      "/viewEntry", 
      /*arguments: JournalArguments(
        journal.entries[index].title, 
        journal.entries[index].body,
        journal.entries[index].rating,
        journal.entries[index].dateTime
      )*/
    );
  }
}