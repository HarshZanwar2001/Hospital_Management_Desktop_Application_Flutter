import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/dash_boardpage/login_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StaffRegister extends StatefulWidget {
  const StaffRegister({Key? key}) : super(key: key);

  @override
  _StaffRegisterState createState() => _StaffRegisterState();
}

class _StaffRegisterState extends State<StaffRegister> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  String? _selectedRole; // Changed to nullable string
  String? _selectedBranch; // Changed to nullable string
  late Future<void> _fetchBranches;
  List<String> _dropdownItems = [];

  Future<void> fetchBranches() async {
    try {
      final response = await http
          .get(Uri.parse('https://app.sheikhafatimahospital.com/login/branch'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _dropdownItems = data.cast<String>().toList();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // }
  // }
  _callApi(String num, String username, String password) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://app.sheikhafatimahospital.com/login/hospital-create-account'));
    request.body = json.encode({
      "branch": _selectedBranch,
      "role": _selectedRole,
      "username": username,
      "number": num,
      "password": password,
    });
    print(request);
    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();

// Convert streamedResponse to regular http.Response
    http.Response response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData);
      Navigator.pushReplacementNamed(context, '/stafflogin');
      SnackBar(
        content: Text(responseData.body ?? 'Unknown error'),
        duration: Duration(seconds: 3),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.body),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBranches = fetchBranches();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // This will center all the children vertically.

                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.png',
                    width: 192,
                    height: 35.4,
                  ),
                  SizedBox(height: 20),
                  Center(
                    // This will center the "Welcome Back" text in the column.
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color:
                              Color(0xff122D51) // Sets the text color to blue.
                          ),
                    ),
                  ),
                  Center(
                    // This will center the "Welcome Back" text in the column.
                    child: Text(
                      'Welcome back! Please enter your details',
                      style: TextStyle(
                        fontSize: 20,
                        color:
                            Color(0xff7B7B7B), // Sets the text color to blue.
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Branch",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            // Other text styles like color can also be added here
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: 435,
                          height: 84,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                            labelText: 'Select Branch',
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
                        SizedBox(height: 5),
                        Text(
                          "Select Role",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            // Other text styles like color can also be added here
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: 435,
                          height: 84,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                            border: OutlineInputBorder(),
                              ),
                            
                            hint: Text('Select Role'),
                            value: _selectedRole,
                            items: [
                              DropdownMenuItem(
                                value: 'Doctor',
                                child: Text('Doctor'),
                              ),
                              DropdownMenuItem(
                                value: 'Receptionist',
                                child: Text('Receptionist'),
                              ),
                              DropdownMenuItem(
                                value: 'Pharmacist',
                                child: Text('Pharmacist'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedRole = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Enter Number",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            // Other text styles like color can also be added here
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: 435,
                          height: 84,
                          child: TextField(
                            controller: _numberController,
                            decoration: InputDecoration(
                              labelText: 'Enter Phone Number',
                              suffixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Enter Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            // Other text styles like color can also be added here
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: 435,
                          height: 84,
                          child: TextField(
                            controller: _userNameController,
                            decoration: InputDecoration(
                              labelText: 'Enter Name',
                              suffixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Enter Password",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            // Other text styles like color can also be added here
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: 435,
                          height: 84,
                          child: TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Enter Pass',
                              suffixIcon: Icon(Icons.password),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      width: 414,
                      height: 50,
                      child: ElevatedButton(
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            // Other text styles like color can also be added here
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff4CCACF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // Background color
                          minimumSize: Size(double.infinity,
                              60), // Makes the button full width, height is arbitrary
                          foregroundColor: Colors
                              .white, // This sets the text color for the button, which should also be white
                        ),
                        onPressed: () {
                          _callApi(_numberController.text, _userNameController.text, _passwordController.text);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Color(0xff344054), // Default text color
                          fontSize: 16, // Default font size
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'If You Have Already An Account '),
                          TextSpan(
                            text: 'Login Here',
                            style: TextStyle(
                              color: Color(
                                  0xff4CCACF), // Text color for the clickable text // Underline decoration
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  // Use pushReplacement to replace the current page with the new one
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            Image.asset(
              'assets/images/doctor1.png',
              width: 624,
              height: 782,
            ),
          ],
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor:Color.fromARGB(255, 87, 111, 116),
  //     body: Center(
  //       child: Form(
  //         key: _formKey,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             const Text(
  //               "Register an Account",
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 40,
  //                 color:Colors.white,
  //               ),
  //             ),
  //             SizedBox(height: 30),
  //    Container(
  //   width: 300,
  //   child: FutureBuilder<List<String>>(
  //     future: _fetchBranches,
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Text('');
  //       } else if (snapshot.hasError) {
  //         return const Text('');
  //       } else {
  //         return DropdownButtonFormField<String>(
  //           value: _selectedBranch,
  //           onChanged: (String? newValue) {
  //             setState(() {
  //               _selectedBranch = newValue;
  //             });
  //           },
  //           decoration: const InputDecoration(
  //           focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.white, width: 2.0),
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.white, width: 1.0),
  //           ),
  //             labelText: 'Select Branch',
  //             labelStyle:TextStyle(color:Colors.white),
  //             border: OutlineInputBorder(),
  //           ),
  //           items: snapshot.data!.map<DropdownMenuItem<String>>((String value) {
  //             return DropdownMenuItem<String>(
  //               value: value,
  //               child: Text(value),
  //             );
  //           }).toList(),
  //         );
  //       }
  //     },
  //   ),
  // ),
  // SizedBox(height: 30),
  //             Container(
  //               width: 300,
  //               child: DropdownButtonFormField<String>(
  //                 value: _selectedRole,
  //                 onChanged: (String? newValue) {
  //                   setState(() {
  //                     _selectedRole = newValue;
  //                   });
  //                 },
  //                 decoration: const InputDecoration(
  //                 focusedBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(color: Colors.white, width: 2.0),
  //                 ),
  //                 enabledBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(color: Colors.white, width: 1.0),
  //                 ),
  //                   labelText: 'Select Role',
  //                   labelStyle:TextStyle(color:Colors.white),
  //                   border: OutlineInputBorder(),
  //                 ),
  //                 items: <String>[
  //                   'Doctor',
  //                   'Receptionist',
  //                   'Pharmacist',
  //                   // Add more roles here as needed
  //                 ].map<DropdownMenuItem<String>>((String value) {
  //                   return DropdownMenuItem<String>(
  //                     value: value,
  //                     child: Text(value),
  //                   );
  //                 }).toList(),
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //                Container(
  //               width: 300,
  //               child: TextFormField(
  //                 controller: _numberController,
  //                 decoration: const InputDecoration(
  //                 focusedBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(color: Colors.white, width: 2.0),
  //                 ),
  //                 enabledBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(color: Colors.white, width: 1.0),
  //                 ),
  //                   labelText: 'Your Number',
  //                   labelStyle:TextStyle(color:Colors.white),
  //                   border: OutlineInputBorder(),
  //                   suffixIcon: Icon(Icons.phone,color:Colors.white),
  //                 ),
  //                 onChanged: (value) {
  //                   // Additional logic if needed
  //                 },
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return 'Please enter User name';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //             ),
  //              SizedBox(height: 20),
  //             Container(
  //               width: 300,
  //               child: TextFormField(
  //                 controller: _userNameController,
  //                 decoration: const InputDecoration(
  //                 focusedBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(color: Colors.white, width: 2.0),
  //                 ),
  //                 enabledBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(color: Colors.white, width: 1.0),
  //                 ),
  //                   labelText: 'Your Name',
  //                   labelStyle: TextStyle(color:Colors.white),
  //                   border: OutlineInputBorder(),
  //                   suffixIcon: Icon(Icons.person,color:Colors.white),
  //                 ),
  //                 onChanged: (value) {
  //                   // Additional logic if needed
  //                 },
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return 'Please enter User name';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             Container(
  //               width: 300,
  //               child: TextFormField(
  //                 controller: _passwordController,
  //                 obscureText: true,
  //                 decoration: const InputDecoration(
  //                 focusedBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(color: Colors.white, width: 2.0),
  //                 ),
  //                 enabledBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(color: Colors.white, width: 1.0),
  //                 ),
  //                   suffixIcon: Icon(Icons.password,color:Colors.white),
  //                   labelText: 'Enter Password',
  //                   labelStyle:TextStyle(color:Colors.white),
  //                   border: OutlineInputBorder(),
  //                 ),
  //                 onChanged: (value) {
  //                   // Additional logic if needed
  //                 },
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return 'Please enter valid password';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             Container(
  //               height: 50.0,
  //               width: 300,
  //               decoration: BoxDecoration(
  //                 color:Color(0xFF4CCACF),
  //                 borderRadius: BorderRadius.circular(10.0),
  //               ),
  //               child: ElevatedButton(
  //                 onPressed: () async {
  //                   _callApi();
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.transparent,
  //                   elevation: 0,
  //                   textStyle: const TextStyle(color: Colors.white),
  //                 ),
  //                 child: const Text('Register',
  //                  style: TextStyle(color: Colors.white),),
  //               ),
  //             ),
  //             SizedBox(height: 10),
  //             ElevatedButton(
  //               onPressed: () {
  //                 // Navigate to the register staff page
  //                 Navigator.pushNamed(context, '/stafflogin');
  //               },
  //               style: ButtonStyle(
  //                 backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  //                 shadowColor:
  //                 MaterialStateProperty.all<Color>(Colors.transparent),
  //                 elevation: MaterialStateProperty.all<double>(0),
  //                 side: MaterialStateProperty.all<BorderSide>(
  //                   BorderSide.none,
  //                 ),
  //                 overlayColor:
  //                     MaterialStateProperty.all<Color>(Colors.transparent),
  //                 foregroundColor:
  //                     MaterialStateProperty.all<Color>(Colors.black),
  //               ),
  //               child: const Text(
  //                 "Go back to the login page",
  //                   style: TextStyle(
  //                   fontWeight: FontWeight.normal,
  //                   fontSize: 15,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
