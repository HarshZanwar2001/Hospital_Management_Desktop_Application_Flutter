import "package:flutter/material.dart";
import "package:flutter1/dash_boardpage/searchpatientdata.dart";
import "package:flutter1/widgets/button_widget.dart";
import "package:flutter1/widgets/img_widget.dart";
import "package:flutter1/widgets/textfield.dart";
import "package:flutter1/widgets/textreturn.dart";
import 'package:flutter1/auth/provider.dart';
import "package:provider/provider.dart";

class Priscription extends StatefulWidget {
  const Priscription({super.key});

  @override
  State<Priscription> createState() => _PriscriptionState();
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

// Dialog box end

class _PriscriptionState extends State<Priscription> {
  @override
  Widget build(BuildContext context) {
    
    final provider = Provider.of<UserDataProvider>(context);
    final userData = provider.userData;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios_new),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchPatient1()),
                                ); //
                              },
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Patient Details:',
                                  style: TextStyle(
                                    color: Color(0xff122D51),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  '${userData.username}',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 20, 20, 20),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                           
                            Expanded(
                              child: Text(
                                'ID : ${userData.id}',
                                style: TextStyle(
                                  color: Color.fromARGB(188, 45, 45, 46),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  '09/03/1989',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 119, 121, 123),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Gender: Male', // Corrected the text here
                                  style: TextStyle(
                                    color: Color.fromARGB(241, 28, 29, 32),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  '26 Years',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 123, 125, 127),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 36),
                        Container(
                          height: 162,
                          width: 561,
                          child: Card(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          'Doctor Name:${userData.name}',
                                          style: TextStyle(
                                            fontFamily: 'Exo',
                                            fontSize: 13.61,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          textColor: Color(0xff122D51),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          'Patient Name: ${userData.username}',
                                          style: TextStyle(
                                            fontFamily: 'Exo',
                                            fontSize: 13.61,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          textColor: Color(0xff122D51),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          'Branch Name:${userData.branch}',
                                          style: TextStyle(
                                            fontFamily: 'Exo',
                                            fontSize: 13.61,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          textColor: Color(0xff122D51),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          'Age:',
                                          style: TextStyle(
                                            fontFamily: 'Exo',
                                            fontSize: 13.61,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          textColor: Color(0xff122D51),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          'Disease Name:',
                                          style: TextStyle(
                                            fontFamily: 'Exo',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textColor: Color(0xff122D51),
                                        ),
                                        SizedBox(
                                          height: 80,
                                        ),
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Other widgets in the column
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 0),
                                child: Textfieldready(
                                  hint: '  Search....',
                                  hintfontsize: 20,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  suffixIcon: Icons.search,
                                  suffixIconColor: Color(0xff122D51),
                                  border: Border.all(
                                    color: Color(0xff122D51),
                                    width: 1,
                                  ),
                                  width: 269, // Custom width
                                  height: 45, // Custom height
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
