import 'package:flutter/material.dart';
class Historypage extends StatelessWidget {
  var arrData = [
    {
      'name': 'John',
      'age': '25',
    },
    {
      'name': 'Doe',
      'age': '30',
    },
    {
      'name': 'Smith',
      'age': '35',
    },
  ];
  // const Historypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Container(
        child: ListView(
          children: arrData.map((data) {
            return ListTile(
              title: Text(data['name'].toString()),
              subtitle: Text(data['age'].toString()),
            );
          }).toList()
        ),
      )
    );
  }
}