import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/dash_boardpage/registration_page.dart';
import 'package:flutter1/widgets/password_field_widget.dart';

class Login extends StatelessWidget {
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
                        color: Color(0xff122D51) // Sets the text color to blue.
                      ),
                    ),
                  ),
                  Center(
                    // This will center the "Welcome Back" text in the column.
                    child: Text(
                      'Welcome back! Please enter your details',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff7B7B7B), // Sets the text color to blue.
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
                          child: PasswordFieldWidget(),
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
                          Navigator.pushNamed(context, '/dashboard');
                          // TODO: Implement registration logic.
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
                              color: Color(0xff4CCACF),// Text color for the clickable text // Underline decoration
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  // Use pushReplacement to replace the current page with the new one
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => regis1()),
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
}
