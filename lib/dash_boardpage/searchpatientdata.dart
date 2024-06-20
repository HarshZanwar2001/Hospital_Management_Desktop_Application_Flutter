import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter1/auth/provider.dart';
import 'package:flutter1/dash_boardpage/history_page.dart';
import 'package:flutter1/widgets/button_widget.dart';
import 'package:flutter1/widgets/textfield.dart';
import 'package:flutter1/widgets/textreturn.dart';
import 'package:flutter1/dash_boardpage/searchpatient.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class SearchPatient1 extends StatefulWidget {
  final Map<String, dynamic>? searchData;

  const SearchPatient1({Key? key, this.searchData}) : super(key: key);
  @override
  State<SearchPatient1> createState() => _SearchPatientState();
}

class _SearchPatientState extends State<SearchPatient1> {
  final TextEditingController patientname = TextEditingController();
  final TextEditingController medicine = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController hospitalbranchname = TextEditingController();
  final TextEditingController precision = TextEditingController();
  final TextEditingController diseasename = TextEditingController();
  late TextEditingController _textEditingController;
  bool? _admit = true; // Changed to nullable string
  String? _selectedBranch; // Changed to nullable string
  late Future<void> _fetchBranches;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _loadData(
      String registerby,
      String tokenid,
      String name,
      // String age,
      // String number,
      String disease,
      String medicine,
      String precision) async {
    if (patientname.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Patient Name, Age, and Precision are required.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokenid'
    };
    // print("${widget.searchData?['name']}");
    // print("$registerby");
    // print("$precision");
    // print("$registerby");
    // print("$diseasename");
    // print("$medicine");
    // print("$_selectedBranch");
    // print("$_admit");
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://app.sheikhafatimahospital.com/doctor/doctors-entry'));
    request.body = json.encode({
      "patient": "${widget.searchData?['id']}",
      "doctor": "$registerby",
      "description": precision,
      "visitor_name": name,
      "disease": disease,
      "medicine": medicine,
      "admit": _admit,
      "branch": _selectedBranch
    });
    print(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Submitted Successfully'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context);
    final userData = provider.userData;
    final String regisbyid = userData.id;
    final String tokenid = userData.token;
    return Scaffold(
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
                                      builder: (context) => Searchpatient()),
                                ); //
                              },
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Search Patient Data',
                                  style: TextStyle(
                                    color: Color(0xff122D51),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Textfieldready(
                          hint: '   Enter text here...',
                          hintfontsize: 20,
                          border: Border.all(
                            color: Color(0xff122D51),
                            width: 1,
                          ),
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          width: 630,
                          height: 50,
                        ),
                        SizedBox(height: 36),
                        Container(
                          height: 262,
                          width: 546,
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
                                          'Patient Name: ${widget.searchData?['name']}',
                                          style: TextStyle(
                                            fontFamily: 'Exo',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          'Age: ${widget.searchData?['age']}',
                                          style: TextStyle(
                                            fontFamily: 'Exo',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          'registred Aadhar:',
                                          style: TextStyle(
                                              fontFamily: 'Exo',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          'Registred At:',
                                          style: TextStyle(
                                              fontFamily: 'Exo',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          'Regitration Date:',
                                          style: TextStyle(
                                              fontFamily: 'Exo',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
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
                                          'Phone Number: ${widget.searchData?['phone_number']}',
                                          style: TextStyle(
                                              fontFamily: 'Exo',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          'Address: ${widget.searchData?['address']}',
                                          style: TextStyle(
                                              fontFamily: 'Exo',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
                                        // CustomText(
                                        //   'Disease Name:',
                                        //   style: TextStyle(
                                        //     fontFamily: 'Exo',
                                        //     fontSize: 18,
                                        //     fontWeight: FontWeight.w600,
                                        //   ),
                                        //   textAlign: TextAlign.center,
                                        //   overflow: TextOverflow.ellipsis,
                                        //   maxLines: 1,
                                        //   color: Colors.black,
                                        // ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          'Date',
                                          style: TextStyle(
                                            fontFamily: 'Exo',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        CustomText(
                                          'Family Members: ${widget.searchData?['name']}',
                                          style: TextStyle(
                                              fontFamily: 'Exo',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        //         CustomText(
                                        //           'Branch:',
                                        //           style: TextStyle(
                                        //             fontFamily: 'Exo',
                                        //             fontSize: 18,
                                        //             fontWeight: FontWeight.w600,
                                        //           ),
                                        //           textAlign: TextAlign.center,
                                        //           overflow: TextOverflow.ellipsis,
                                        //           maxLines: 1,
                                        //           color: Colors.black,
                                        //         ),
                                        //         SizedBox(
                                        //           height: 10,
                                        //         ),
                                        //         CustomText(
                                        //           'Location:',
                                        //           style: TextStyle(
                                        //             fontFamily: 'Exo',
                                        //             fontSize: 18,
                                        //             fontWeight: FontWeight.w600,
                                        //           ),
                                        //           textAlign: TextAlign.center,
                                        //           overflow: TextOverflow.ellipsis,
                                        //           maxLines: 1,
                                        //           color: Colors.black,
                                        //         ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: CustomButton(
                                  label: 'Doctor',
                                  textColor: Colors.white,
                                  buttonColor: Color(0xff4CCACF),
                                  onPressed: () {
                                    print('Custom button pressed!');
                                  },
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Exo',
                                  fontSize: 24,
                                  borderRadius: 10,
                                  width: 221,
                                  height: 52,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: CustomButton(
                                  label: 'Pharmacy',
                                  textColor: Color(0xff122D51),
                                  onPressed: () {
                                    print('Custom button pressed!');
                                  },
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Exo',
                                  fontSize: 24,
                                  borderRadius: 10,
                                  width: 272,
                                  height: 52,
                                  borderColor: Color(0xff122D51),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 36),
                        Card(
                          elevation: 2, // Example elevation
                          margin: EdgeInsets.all(36), // Example margin
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        'Patient Name:',
                                        style: TextStyle(
                                          fontFamily: 'Exo',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Expanded(
                                      child: Textfieldready(
                                        obscureText: false,
                                        controller: patientname,
                                        keyboardType: TextInputType.text,
                                        border: Border.all(
                                          color: Color(0xff122D51),
                                          width: 1,
                                        ),
                                        width: 380, // Custom width
                                        height: 45,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: CustomText(
                                //         'Age:',
                                //         style: TextStyle(
                                //           fontFamily: 'Exo',
                                //           fontSize: 20,
                                //           fontWeight: FontWeight.w600,
                                //         ),
                                //         overflow: TextOverflow.ellipsis,
                                //         maxLines: 1,
                                //         color: Colors.black,
                                //       ),
                                //     ),
                                //     Expanded(
                                //       child: Textfieldready(
                                //         controller: age,
                                //         obscureText: false,
                                //         keyboardType: TextInputType.number,
                                //         border: Border.all(
                                //           color: Color(0xff122D51),
                                //           width: 1,
                                //         ),
                                //         width: 380, // Custom width
                                //         height: 45,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        'Hospital Branch Name:',
                                        style: TextStyle(
                                          fontFamily: 'Exo',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: 335,
                                        height: 45,
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            // labelText: 'Select Branch',
                                            border: OutlineInputBorder(),
                                          ),
                                          hint: Text('Select Branch'),
                                          value: _selectedBranch,
                                          items: [
                                            DropdownMenuItem(
                                              value: 'Mahdipatnam',
                                              child: Text('Mahdipatnam'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'Jubilee Hills',
                                              child: Text('Jubilee Hills'),
                                            ),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedBranch = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        'Admit?:',
                                        style: TextStyle(
                                          fontFamily: 'Exo',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: 335,
                                        height: 45,
                                        child: DropdownButtonFormField<bool>(
                                          decoration: InputDecoration(
                                            // labelText: 'Admit?',
                                            border: OutlineInputBorder(),
                                          ),
                                          hint: Text('Admit or not'),
                                          value: _admit,
                                          items: [
                                            DropdownMenuItem<bool>(
                                              value: true,
                                              child: Text('No'),
                                            ),
                                            DropdownMenuItem<bool>(
                                              value: false,
                                              child: Text('Yes'),
                                            ),
                                          ],
                                          onChanged: (bool? value) {
                                            setState(() {
                                              _admit = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: CustomText(
                                //         'Gender:',
                                //         style: TextStyle(
                                //           fontFamily: 'Exo',
                                //           fontSize: 20,
                                //           fontWeight: FontWeight.w600,
                                //         ),
                                //         overflow: TextOverflow.ellipsis,
                                //         maxLines: 1,
                                //         color: Colors.black,
                                //       ),
                                //     ),
                                //     Expanded(
                                //       child: Textfieldready(
                                //         obscureText: false,
                                //         controller: gender,
                                //         keyboardType: TextInputType.text,
                                //         border: Border.all(
                                //           color: Color(0xff122D51),
                                //           width: 1,
                                //         ),
                                //         width: 380, // Custom width
                                //         height: 45,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        'Disease Name:',
                                        style: TextStyle(
                                          fontFamily: 'Exo',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: diseasename,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            borderSide: BorderSide(
                                                color: Colors.black, width: 1),
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        'Medicine:',
                                        style: TextStyle(
                                          fontFamily: 'Exo',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: medicine,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            borderSide: BorderSide(
                                                color: Colors.black, width: 1),
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Stack(
                                  children: [
                                    Textfieldready(
                                      hint: '  Write precision..',
                                      controller: precision,
                                      obscureText: false,
                                      keyboardType: TextInputType.text,
                                      border: Border.all(
                                        color: Color(0xff122D51),
                                        width: 1,
                                      ),
                                      width: 569, // Custom width
                                      height: 134, // Custom height
                                      isMultiline: true,
                                      maxLines: 5,
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: SizedBox(
                                        width: 85, // Example width
                                        height: 25.9, // Example height
                                        child: CustomButton(
                                          label: 'Submit',
                                          textColor: Colors.white,
                                          buttonColor: Color(0xff4CCACF),
                                          onPressed: () {
                                            _loadData(
                                                regisbyid,
                                                tokenid,
                                                patientname.text,
                                                // age.text,
                                                // gender.text,
                                                diseasename.text,
                                                medicine.text,
                                                precision.text);
                                          },
                                          fontFamily:
                                              'Exo', // Example font family
                                          fontSize: 11, // Example font size
                                          borderRadius:
                                              4.95, // Example border radius
                                          borderColor: null, // Example height
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        // History(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: EdgeInsets.only(
                                right: 58), // Adjust the margin as needed
                            child: SizedBox(
                              width: 208,
                              height: 52,
                              child: CustomButton(
                                label: 'History',
                                textColor: Colors.white,
                                buttonColor: Color(0xff4CCACF),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => History()),
                                  ); // Add your onPressed logic here
                                },
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Exo', // Example font family
                                fontSize: 24, // Example font size
                                borderRadius: 10, // Example border radius
                                width: 200, // Example width
                                height: 50,
                                borderColor: null, // Example height
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    
  }
}
