import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter1/auth/provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// class FamilyMember {
//   final String name;

//   FamilyMember(this.name);

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//     };
//   }
// }

class RegisterPatient extends StatefulWidget {
  @override
  _RegisterPatientState createState() => _RegisterPatientState();
}

class _RegisterPatientState extends State<RegisterPatient> {
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  // final TextEditingController _familyMemberController = TextEditingController();
  String? _selectegender;
  String? _selectedBranch;

  get s => null;

  void registerPatient(String tokenvalue, String registerby, String name,
      String phone, String address, String age, String addhar) async {
    //  SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? userId = prefs.getString('userId');

    // // Check if the user ID is not null
    // if (userId == null) {
    //   print('User ID is not available. Please make sure the user is logged in.');
    //   return;
    // }
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': //'Bearer $tokenvalue'
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImhhcnNoMTIiLCJpYXQiOjE3MTQwNzY5Mzh9.8TT0zeXTHoliYj7H7EUiEGPJAGDGGdutaOkBF3EuhBE' // 'Bearer $tokenvalue', // 'Bearer
    };

    var request = http.Request(
      'POST',
      Uri.parse('https://app.sheikhafatimahospital.com/login/create-patient'),
    );
    request.body = json.encode({
      "registerdby": registerby,
      "name": name,
      "phone_number": phone,
      "address": address,
      "age": age,
      "aadhar": addhar,
      "branch": _selectedBranch,
      "gender": _selectegender
    });
    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      _nameController.clear();
      _numberController.clear();
      _addressController.clear();
      _ageController.clear();
      _aadharController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Patient registered successfully!'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green),
      );
    } else {
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to register patient. Please try again.'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red),
      );
    }
  }

  bool isNumeric(String? s) {
    if (s == null) return false;
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context);
    final userData = provider.userData;
    final String regisbyid = userData.id;
    final String token = userData.token;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 386,
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12.0,
                  ),
                  hintText: 'Search here..',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Barlow',
                    color: Color.fromARGB(255, 98, 98, 100),
                  ),

                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.white,
                  filled: true, // Ensure background color is applied
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Register Patient Data',
                    style: TextStyle(
                      color: Color(0xff122D51),
                      fontSize: 22,
                      fontFamily: 'Exo',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Row(
                    children: [
                      Icon(Icons.arrow_back_ios_new),
                      const SizedBox(width: 4),
                      Text(
                        'Back to patient list',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  tooltip: 'Back to patient list',
                )
              ],
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: 1520,
              height: 750,
              child: Card(
                color: Color(0xFFF5F9FF),
                elevation: 1,
                child: SizedBox(
                  width: 1183,
                  height: 556,
                  child: Card(
                    color: Color.fromARGB(255, 248, 251, 254),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Barlow',
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Container(
                                      width: 525,
                                      height: 50, // Adjust the width as needed
                                      child: TextFormField(
                                        controller: _nameController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Colors.white,
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 12.0,
                                          ),
                                          alignLabelWithHint: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Number',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Barlow',
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Container(
                                      width: 525,
                                      height: 50, // Adjust the width as needed
                                      child: Form(
                                        key: _formKey,
                                        child: Container(
                                          width: 525,
                                          height:
                                              50, // Adjust the width as needed
                                          child: TextFormField(
                                            controller: _numberController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              fillColor: Colors.white,
                                              filled: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 12.0,
                                              ),
                                              alignLabelWithHint: true,
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter a phone number';
                                              } else if (value.length != 10) {
                                                return 'Phone number must be 10 digits long';
                                              } else if (!isNumeric(value)) {
                                                return 'Phone number must contain only numbers';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 26.0),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Address',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Barlow',
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Container(
                                      width: 525,
                                      height: 50, // Adjust the width as needed
                                      child: TextFormField(
                                        controller: _addressController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Colors.white,
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 12.0,
                                          ),
                                          alignLabelWithHint: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Age',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Barlow',
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Container(
                                      width: 525,
                                      height: 50, // Adjust the width as needed
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: _ageController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Colors.white,
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 12.0,
                                          ),
                                          alignLabelWithHint: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Aadhar',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Barlow',
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Container(
                                      width: 525,
                                      height: 50, // Adjust the width as needed
                                      child: Form(
                                        key: _formKey1,
                                        child: Container(
                                          width: 525,
                                          height:
                                              50, // Adjust the width as needed
                                          child: TextFormField(
                                            controller: _aadharController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              fillColor: Colors.white,
                                              filled: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 12.0,
                                              ),
                                              alignLabelWithHint: true,
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter a phone number';
                                              } else if (value.length != 12) {
                                                return 'Adhar number must be 12 digits long';
                                              } else if (!isNumeric(value)) {
                                                return 'Aadhar number must contain only numbers';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Gender',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Barlow',
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Container(
                                      width: 525,
                                      height: 50,
                                      child: DropdownButtonFormField<String>(
                                        hint: Text('Select Role'),
                                        value: _selectegender,
                                        items: [
                                          DropdownMenuItem(
                                            value: 'Male',
                                            child: Text('Male'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'Feamle',
                                            child: Text('Feamle'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'Others',
                                            child: Text('Others'),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _selectegender = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Expanded(
                              //   child: Column(
                              //     crossAxisAlignment:
                              //         CrossAxisAlignment.stretch,
                              //     children: [
                              //       Text(
                              //         'Family Member Names (comma separated)',
                              //         style: TextStyle(
                              //           fontSize: 18,
                              //           fontFamily: 'Barlow',
                              //           color:
                              //               const Color.fromARGB(255, 0, 0, 0),
                              //         ),
                              //       ),
                              //       SizedBox(height: 8.0),
                              //       Container(
                              //         width: 525,
                              //         height: 50, // Adjust the width as needed
                              //         child: TextFormField(
                              //           controller: _familyMemberController,
                              //           decoration: InputDecoration(
                              //             border: InputBorder.none,
                              //             fillColor: Colors
                              //                 .white, // Set background color to white
                              //             filled:
                              //                 true, // Ensure background color is applied
                              //             // Align text to the center

                              //             alignLabelWithHint: true,
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hospital Branch',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Barlow',
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Container(
                                      width: 525,
                                      height: 50,
                                      child: DropdownButtonFormField<String>(
                                        hint: Text('Select Branch'),
                                        value: _selectedBranch,
                                        items: [
                                          DropdownMenuItem(
                                            value: 'Madhapur',
                                            child: Text('Madhapu'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'Jubali hills',
                                            child: Text('Jubali hills'),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedBranch = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16.0),

                              // Expanded(
                              //   child: Column(
                              //     crossAxisAlignment:
                              //         CrossAxisAlignment.stretch,
                              //     children: [
                              //       Text(
                              //         'Family Member Names (comma separated)',
                              //         style: TextStyle(
                              //           fontSize: 18,
                              //           fontFamily: 'Barlow',
                              //           color:
                              //               const Color.fromARGB(255, 0, 0, 0),
                              //         ),
                              //       ),
                              //       SizedBox(height: 8.0),
                              //       Container(
                              //         width: 525,
                              //         height: 50, // Adjust the width as needed
                              //         child: TextFormField(
                              //           controller: _familyMemberController,
                              //           decoration: InputDecoration(
                              //             border: InputBorder.none,
                              //             fillColor: Colors
                              //                 .white, // Set background color to white
                              //             filled:
                              //                 true, // Ensure background color is applied
                              //             // Align text to the center

                              //             alignLabelWithHint: true,
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 427,
                            height: 50,
                            child: Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (_formKey1.currentState!.validate()) {
                                      print(token);
                                      registerPatient(
                                          regisbyid,
                                          token,
                                          _nameController.text,
                                          _numberController.text,
                                          _addressController.text,
                                          _ageController.text,
                                          _aadharController.text

                                          // _familyMemberController.text
                                          );

                                      // If the form is valid, you can proceed with your logic here
                                      // You can do something with the validated phone number here, like saving it to a database or displaying it in a dialog.
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: Color(0xff4CCACF),
                                ),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
