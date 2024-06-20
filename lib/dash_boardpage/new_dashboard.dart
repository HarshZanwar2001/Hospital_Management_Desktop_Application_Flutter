import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: <Widget>[
          SizedBox(height: statusBarHeight),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset('assets/images/rectangle.png', height: 20),
                      SizedBox(width: 10),
                      Text('Company Name',
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      DropdownButton<String>(
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                        underline: Container(),
                        items: <String>['Profile', 'Settings', 'Another']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                      DropdownButton<String>(
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                        underline: Container(),
                        items: <String>['Option 1', 'Option 2', 'Option 3']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                      IconButton(
                        icon: Icon(Icons.logout, color: Colors.black),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: MainContent(),
          ),
        ],
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    double contentWidth = screenSize.width > 600 ? 600 : screenSize.width;
    double contentHeight = screenSize.height > 600 ? 600 : screenSize.height;

    double cardAspectRatio = 1 / 1;

    return Center(
      child: Container(
        width: contentWidth,
        height: contentHeight,
        child: GridView.builder(
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: cardAspectRatio,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.dashboard, size: 50),
                    SizedBox(height: 8),
                    Text('Option ${index + 1}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
