import 'package:flutter/material.dart';
import 'package:flutter1/widgets/button_widget.dart';
import 'package:flutter1/widgets/img_widget.dart';
import 'package:flutter1/widgets/textreturn.dart';
import 'package:http/http.dart';
import 'dart:convert';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

void _showProfileCard(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      );
    },
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 10), // Adjust width here
          content: contentBox(context),
        ),
      ),
    ),
  );
}

Widget contentBox(BuildContext context) {
  return Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      width: 600,
      height: 800,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                'Prescription',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 9, 24, 160),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
          CustomImage(
            imagePath: 'assets/images/receipt.png',
            width: 325,
            height: 460,
          ),
          SizedBox(height: 35),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomButton(
                    label: 'Download',
                    textColor: const Color.fromARGB(255, 222, 4, 4),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    suffixIcon: Icons.download,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Exo',
                    fontSize: 17,
                    borderRadius: 10,
                    width: 153,
                    height: 36,
                  ),
                  SizedBox(width: 56),
                  CustomButton(
                    label: 'Share',
                    textColor: Colors.white,
                    buttonColor: Color(0xff4CCACF),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Prescription()),
                      // );
                      print('Custom button pressed!');
                    },
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Exo',
                    fontSize: 15,
                    borderRadius: 10,
                    width: 90,
                    height: 35,
                  ),
                  SizedBox(width: 36),
                  CustomButton(
                    label: 'Print',
                    textColor: Color.fromARGB(255, 24, 222, 216),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Prescription()),
                      // );
                      print('Custom button pressed!');
                    },
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Exo',
                    fontSize: 15,
                    borderRadius: 10,
                    width: 95,
                    height: 35,
                    borderColor: Color.fromARGB(255, 44, 210, 222),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _HistoryState extends State<History> {
  List<Patientdeatails> patientList = [];
  Future<List<Patientdeatails>> getPaitentDetails() async {
    final response = await get(Uri.parse(
        'https://app.sheikhafatimahospital.com/doctor/patient-history?patient=660fd2a8894469fdfa687662'));
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (Map i in jsonData) {
        Patientdeatails patientdet = Patientdeatails(
            description: i['description'],
            visitor_name: i['visitor_name'],
            visitor_age: i['visitor_age'],
            visitor_number: i['visitor_number']);
        patientList.add(patientdet);
      }
      return patientList;
    } else {
      return patientList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescriptions'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPaitentDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 30, // Spacing between columns
                    mainAxisSpacing: 30, // Spacing between rows
                    childAspectRatio:7.0, // Aspect ratio of each item (width / height)
                  ),
                  itemCount: patientList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      child: ListTile(
                        
                        subtitle: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Doctor Name  : ${patientList[index].visitor_name}",),
                                Text("Patient Name : ${patientList[index].visitor_name}"),
                                Text("Branch Number : ${patientList[index].visitor_number}"),
                                Text("Patient Age : ${patientList[index].visitor_age} years"),
                            
                              ],
                            ),
                            SizedBox(width: 40,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Disease Name  : ${patientList[index].description}"),
                                SizedBox(height:40,),
                                Row(
                                          children: [
                                            CustomText(
                                              '15 Days Ago',
                                              style: TextStyle(
                                                fontFamily: 'Exo',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              textColor: Color.fromARGB(
                                                  255, 219, 4, 4),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            CustomButton(
                                              label: 'View',
                                              textColor: Colors.white,
                                              buttonColor: Color(0xff4CCACF),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                // Show the profile card as an overlay
                                                _showProfileCard(context);
                                              }, //
                                              fontFamily: 'Exo',
                                              fontSize: 13.61,
                                              fontWeight: FontWeight.w600,
                                              borderRadius: 4,
                                            ),
                                          ],
                                        ),
                
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Patientdeatails {
  String description;
  String visitor_name;
  String visitor_age;
  String visitor_number;
  Patientdeatails(
      {required this.description,
      required this.visitor_name,
      required this.visitor_age,
      required this.visitor_number});
}
