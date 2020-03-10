import 'package:flutter/material.dart';

class ViewEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //final JournalArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Wasteagram"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Monday, March 8 2020", style: TextStyle(fontSize: 32)),Placeholder(), Text("Items: 7"), Text("Geolocation")]
        ),
      ),
    );
  }
}

class JournalArguments {
  final String title;
  final String body;
  final int rating;
  final int dateTime;

  JournalArguments(this.title, this.body, this.rating, this.dateTime);
}