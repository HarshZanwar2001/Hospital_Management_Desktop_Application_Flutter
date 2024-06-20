// import 'package:flutter/material.dart';
// import 'package:flutter1/auth/HospitalProvider.dart';
// import 'package:flutter1/auth/hospital.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:provider/provider.dart';
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
// class _LoginPageState extends State<LoginPage> {
//   TextEditingController _phoneNumberController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();



//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _callApi();
//   // }

//   _callApi() async {

//  var headers = {
//   'Content-Type': 'application/json',
// };

// var request = http.Request('POST', Uri.parse('http://192.168.1.6:5001/login/hospital-login'));
// request.body = json.encode({
//   "hospital": _phoneNumberController.text,
//   "password": _passwordController.text,
// });
// request.headers.addAll(headers);

// http.StreamedResponse streamedResponse = await request.send();

// // Convert streamedResponse to regular http.Response
// http.Response response = await http.Response.fromStream(streamedResponse);

// if (response.statusCode == 200) {
//   var responseData = json.decode(response.body);
//   var hospital = Hospital(
//     id: responseData['user']['_id'],
//     username: responseData['user']['hospital'],
//     password: responseData['user']['password'],
//     token: responseData['token'],
//   );
//   // Save the user globally using UserProvider
//   Provider.of<HospitalProvider>(context, listen: false).setUser(hospital);
//    Navigator.pushReplacementNamed(context, '/stafflogin');
// } else {
//    ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(response.reasonPhrase ?? 'Unknown error'),
//       duration: Duration(seconds: 2),
//     ),
//   );
// }

//   }

//   final _formKey = GlobalKey<FormState>();
//   bool showIcon = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Form(
//           key:_formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Login",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 40,
//                 ),
//               ),
//               SizedBox(height: 30),
//               Container(
//                 width: 300,
//                   child:Row(children: [
//                      Expanded(
//                       child: TextFormField(
//                         controller: _phoneNumberController,
//                         decoration: const InputDecoration(
//                           labelText: 'User Name',
//                           border: OutlineInputBorder(),
//                           suffixIcon:Icon(Icons.person)
//                         ),
//                         onChanged: (value) {
//                           print(_phoneNumberController.text);
//                           // setState(() {}); 
//                           //   if (_phoneNumberController.text.length == 10){
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
                    
//                     suffixIcon: Icon(Icons.password),
//                     labelText: 'Enter Password',
//                     border: OutlineInputBorder(),
                    
//                   ),
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
//              decoration: BoxDecoration(
//              color: Colors.blue, // Set the background color
//              borderRadius: BorderRadius.circular(10.0), // Optionally, add border radius
//            ),
//           child: ElevatedButton(
//             onPressed: () async {
//               _callApi();
//               print(_phoneNumberController);
//             //   if(_formKey.currentState!.validate()){
//             //   // Perform authentication logic here
//             //   String phoneNumber = _phoneNumberController.text;
//             //   String password = _passwordController.text;

//             //   // _signin();
//             //   //       await  _authService.emailandpassword(emailController.text,passwordcontroller.text);
                              
                    
//             //             print('success');
//             //             _phoneNumberController.clear();
//             //            _passwordController.clear();
//                         //  Navigator.pushReplacementNamed(context, '/dashboard');
        
              
//             // } else{
//             //   Failedsnackbar(context:context, msg:AppStrings.Msg);
//             // }
             
//             }, child:  const Text('Login'),
//              style: ElevatedButton.styleFrom(
//               primary: Colors.transparent, // Make button transparent
//               elevation: 0, // Remove button elevation
//               textStyle: TextStyle(color: Colors.white), // Set text color
//             ),
//           )
//         ),
        
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Clean up controllers when widget is disposed
//     _phoneNumberController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// }

