import 'package:flutter/material.dart';
import 'dateconvert.dart';
import 'models/postEntry.dart';

class ViewEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final WasteArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Wasteagram"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(convertDateYear(args.date), style: TextStyle(fontSize: 32)),
            Expanded(child: Image.network(args.photo)), 
            Text("Items: ${args.items}"), 
            Text("(${args.latitude}, ${args.longitude})"),
          ]
        ),
      ),
    );
  }
}