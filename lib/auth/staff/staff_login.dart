import 'package:flutter/material.dart';
import 'package:flutter1/auth/model.dart';
import 'package:flutter1/auth/provider.dart';
import 'package:flutter1/auth/staff/staff_register.dart';
import 'package:flutter1/dash_boardpage/dashboardpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StaffLogin extends StatefulWidget {
  const StaffLogin({super.key});

  @override
  State<StaffLogin> createState() => _StaffLoginState();
}

class _StaffLoginState extends State<StaffLogin> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }
//   _callApi() async {
//     // Your API call logic here
//      var headers = {
//   'Content-Type': 'application/json',
// };
// var request = http.Request('POST', Uri.parse('http://192.168.1.100:5001/login/hospital-login'));
// request.body = json.encode({
//   "username": _userNameController.text,
//   "password": _passwordController.text,
// });
// request.headers.addAll(headers);

// http.StreamedResponse streamedResponse = await request.send();

// // Convert streamedResponse to regular http.Response
// http.Response response = await http.Response.fromStream(streamedResponse);

// if (response.statusCode == 200) {
//   print(response.statusCode);
//   var responseData = json.decode(response.body);
//   print(responseData);
//   var user = User.fromJson(responseData['user']);
//   Provider.of<UserProvider>(context, listen: false).setUser(user);
//   // ignore: use_build_context_synchronously
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text('Login Successful'),
//       duration: Duration(seconds: 2),
//     ),
//   );
//   // Refresh the page
//   setState(() {});
//   Navigator.pushReplacementNamed(context, '/dashboard');
// }
//  else {
//    ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(response.body ),
//       duration: Duration(seconds: 2),
//     ),
//   );
// }
//   }
//  _callApi() async {

  // void checkLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  //   if (isLoggedIn) {
  //     Navigator.pushReplacementNamed(context, '/dashboard');
  //   }
  // }

  // _callApi() async {
  //   var headers = {
  //     'Content-Type': 'application/json',
  //   };

  // _callApi() async {
  //   var url =
  //       Uri.parse('https://app.sheikhafatimahospital.com/login/staff-login');
  //   var headers = {'Content-Type': 'application/json'};
  //   var body = json.encode({
  //     "username": _userNameController.text,
  //     "password": _passwordController.text,
  //   });

  //   var response = await http.post(url, headers: headers, body: body);
  //   print(response.statusCode);

  //   if (response.statusCode == 200) {
  //     List<dynamic> responseData = json.decode(response.body);
  //     print(responseData);
  // //     User user = User.fromJson(responseData[0]);
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => DashboardPage(),
  //       ),
  //     );
  //   } else if (response.statusCode == 401) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Invalid username or password'),
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('An error occurred. Please try again later.'),
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   }
  // }

  void _login(String username, String password) async {
    print("$username, $password");
    final String apiUrl =
        'https://app.sheikhafatimahospital.com/login/staff-login';
    final Map<String, String> loginData = {
      'username': username,
      'password': password,
    };

    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: json.encode(loginData),
          headers: {'Content-Type': 'application/json'});

      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);

        if (responseData != null && responseData['token'] != null) {
          User user = User.fromJson(responseData);

          // Token is not stored, only maintained in memory
          print("Token (not stored): ${responseData['token']}");
          print(user.id);

          // Typically, you would pass the token to the Provider to manage it in memory
          Provider.of<UserDataProvider>(context, listen: false)
              .setUserData(user);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardPage(),
            ),
          );
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        throw Exception(
            'Login failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to log in: ${e.toString()}')));
    }
  }

  //   var request = http.Request('POST',Uri.parse('https://app.sheikhafatimahospital.com/login/staff-login'));
  //   request.body = json.encode({
  //     "username": _userNameController.text,
  //     "password": _passwordController.text,
  //   });
  //   request.headers.addAll(headers);

  //   http.StreamedResponse streamedResponse = await request.send();

  //   // Convert streamedResponse to regular http.Response
  //   http.Response response = await http.Response.fromStream(streamedResponse);

  //   if (response.statusCode == 200) {
  //     print(response.statusCode);
  //     User responseData = json.decode(response.body);
  //     print(responseData);
  //     // User user = User.fromJson(responseData[0]);
  //     //  Provider.of<UserProvider>(context, listen: false).setUser(user as String);

  //     // Update the login status
  //     // SharedPreferences prefs = await SharedPreferences.getInstance();
  //     // prefs.setBool('isLoggedIn', true);

  //     // ignore: use_build_context_synchronously
  //     // ScaffoldMessenger.of(context).showSnackBar(
  //     //   const SnackBar(
  //     //     content: Text('Login Successful'),
  //     //     duration: Duration(seconds: 2),
  //     //   ),
  //     // );
  //     // Refresh the page
  //     setState(() {});
  //     // Navigator.pushReplacementNamed(context, '/dashboard');
  //     Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => DashboardPage(),
  //           ),
  //         );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('please check details'),
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   }
  // }

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
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18, // This sets the text color to white.
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff4CCACF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ), // Background color
                          minimumSize: Size(double.infinity,
                              60), // Makes the button full width, height is arbitrary
                          foregroundColor: Colors
                              .white, // This sets the text color for the button, which should also be white
                        ),
                        onPressed: () {
                          // Navigator.pushNamed(context, '/dashboard');
                          // TODO: Implement registration logic.
                          _login(_userNameController.text,
                              _passwordController.text);
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
                            text: 'register Here',
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
                                      builder: (context) => StaffRegister()),
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

    // @override
    // Widget build(BuildContext context) {
    //   return Scaffold(
    //     body: Container(
    //       decoration: const BoxDecoration(
    //         image: DecorationImage(image: AssetImage('assets/images/login_logo.png'),
    //         fit: BoxFit.cover),
    //       ),
    //       child: Center(
    //         child: Form(
    //           key:_formKey,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               const Text(
    //                 "Staff Login",
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   color:Colors.white,
    //                   fontSize: 40,
    //                 ),
    //               ),
    //               SizedBox(height: 30),
    //               Container(
    //                 width: 300,
    //                   child:Row(children: [
    //                      Expanded(
    //                       child: TextFormField(
    //                         controller: _userNameController,
    //                         decoration: const InputDecoration(
    //                           focusedBorder: OutlineInputBorder(
    //                           borderSide: BorderSide(color: Colors.white, width: 2.0),
    //                            ),
    //                             enabledBorder: OutlineInputBorder(
    //                             borderSide: BorderSide(color: Colors.white, width: 1.0),
    //                            ),
    //                           labelText: 'User Name',
    //                           labelStyle: TextStyle(color:Colors.white),
    //                           border: OutlineInputBorder(),
    //                           suffixIcon:Icon(Icons.person),
    //                           suffixIconColor:Colors.white
    //                         ),
    //                         style:const TextStyle(
    //                           color:Colors.white
    //                         ),
    //                         onChanged: (value) {
    //                           print(_userNameController.text);
    //                           // setState(() {});
    //                           //   if (_userNameController.text.length == 10){
    //                           //       setState((){
    //                           //         showIcon = value.length == 10;
    //                           //       });
    //                           //     }
    //                         },

    //                             validator: (value) {
    //                             if (value == null || value.isEmpty) {
    //                              return 'Please enter User name';
    //                              }
    //                            return null;
    //                           },
    //                       ),
    //                     ),
    //                   ],)

    //               ),
    //               SizedBox(height: 10),

    //               Container(
    //                 width: 300,
    //                 child: TextFormField(
    //                   controller: _passwordController,
    //                   obscureText: true,
    //                   decoration: const InputDecoration(
    //                   focusedBorder: OutlineInputBorder(
    //                   borderSide: BorderSide(color: Colors.white, width: 2.0),
    //                   ),
    //                   enabledBorder: OutlineInputBorder(
    //                   borderSide: BorderSide(color: Colors.white, width: 1.0),
    //                   ),

    //                     suffixIcon: Icon(Icons.password),
    //                     suffixIconColor:Colors.white,
    //                     labelText: 'Enter Password',
    //                     labelStyle: TextStyle(color:Colors.white),
    //                     border: OutlineInputBorder(),

    //                   ),
    //                   style:const TextStyle(
    //                           color:Colors.white
    //                         ),
    //                   onChanged: (value) {
    //                      print(_passwordController.text);
    //                   },
    //                   validator: (value) {
    //                             if (value == null || value.isEmpty) {
    //                              return 'Please enter valid password';
    //                              }
    //                            return null;
    //                           },
    //                 ),
    //               ),

    //               SizedBox(height: 20),
    //               Container(
    //               height: 50.0, // Set the height
    //               width:300, // Set the width to match the parent widget
    //               decoration: BoxDecoration(
    //               color:const Color(0xFF4CCACF), // Set the background color
    //               borderRadius: BorderRadius.circular(10.0), // Optionally, add border radius
    //            ),
    //           child: ElevatedButton(
    //             onPressed: () async {
    //           //      Navigator.push(
    //           //   context,
    //           //   MaterialPageRoute(builder: (context) => DashboardPage()),
    //           // );
    //                if(_formKey.currentState!.validate()){
    //                  _callApi();
    //                  print(_userNameController);

    //               }else{

    //               }
    //             },
    //              child:  const Text('Login',style: TextStyle(color: Colors.white),),
    //              style: ElevatedButton.styleFrom(
    //               backgroundColor: Colors.transparent, // Make button transparent
    //               elevation: 0, // Remove button elevation
    //               textStyle: TextStyle(color: Colors.white), // Set text color
    //             ),
    //           ),

    //         ),
    //         SizedBox(height: 50,),
    //        ElevatedButton(
    //       onPressed: () {
    //         // Navigate to the register staff page
    //         Navigator.pushNamed(context, '/staff_register');

    //       },
    //         style: ButtonStyle(
    //         backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    //         shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
    //         elevation: MaterialStateProperty.all<double>(0),
    //         side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
    //         overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
    //         foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
    //       ),
    //       child: const Text(
    //         "Create an account",
    //         style: TextStyle(
    //         fontWeight: FontWeight.normal,
    //         fontSize:15,
    //         ),
    //       ),
    //     ),

    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
  }
}
