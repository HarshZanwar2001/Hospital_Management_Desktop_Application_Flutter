import 'package:flutter/material.dart';
import 'package:flutter1/auth/provider.dart';
import 'package:flutter1/auth/staff/staff_login.dart';
import 'package:flutter1/auth/staff/staff_register.dart';
import 'package:flutter1/dash_boardpage/individual_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter1/dash_boardpage/dashboardpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  String? _user;

  String? get user => _user;

  void setUser(String newUser) {
    _user = newUser;
    notifyListeners(); // Notify listeners when the user data changes
  }
}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(
    ChangeNotifierProvider(
    create: (context)=> UserDataProvider(),
    child:MyApp(isLoggedIn: isLoggedIn)
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(), 
      child: MaterialApp(
        title: 'Admin Portal',
        theme: ThemeData(
          //primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? DashboardPage() : StaffLogin(),
        routes: {
          '/stafflogin':(context) => StaffLogin(),
          '/staff_register':(context) => StaffRegister(),
          '/dashboard': (context) => DashboardPage(), 
          '/individualpage':(context) => IndividualPage(), 
        },
      ),
    );
  }
}
class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hospitalProvider = Provider.of<UserProvider>(context); 

    if (hospitalProvider.user != null) {
      return DashboardPage();
    } else {
      return StaffLogin();
    }
  }
}