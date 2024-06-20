import 'package:flutter/material.dart';
import 'package:flutter1/dash_boardpage/searchpatient.dart';
import 'package:flutter1/dash_boardpage/searchpatientdata.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_patient.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _currentAction = 'Register Patient Data';

  @override
  Widget build(BuildContext context) {
    Widget _selectedComponent = Container(); // Default empty component

    // Determine which component to show based on the current action
    switch (_currentAction) {
      case 'Manage Appointment':
        _selectedComponent = ManageAppointments();
        break;
      case 'Appointment List':
        _selectedComponent = AppointmentList();
        break;
      case 'Search Patient':
        _selectedComponent = Searchpatient();
        break;
      default:
        _selectedComponent = RegisterPatient();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentAction),
      ),
      body: _selectedComponent,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: null,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                'Register Patient',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                setState(() {
                  _currentAction = 'Register Patient';
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text(
                'Search Patient',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                setState(() {
                  _currentAction = 'Search Patient';
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(
                'Manage Appointment',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                setState(() {
                  _currentAction = 'Manage Appointment';
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text(
                'Appointment List',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                setState(() {
                  _currentAction = 'Appointment List';
                  Navigator.pop(context);
                });
              },
            ),
            const SizedBox(
              height: 550,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 288,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('isLoggedIn'); // Remove the login status
                    Navigator.pushReplacementNamed(context, '/stafflogin');
                  },
                  icon: const Icon(Icons.logout,
                      color: Color.fromARGB(255, 254, 254, 254)),
                  label: const Text('Log out',
                      style:
                          TextStyle(color: Color.fromARGB(255, 254, 254, 254))),
                  style: ButtonStyle(
                    // Set height and width based on button state
                    minimumSize:
                        WidgetStateProperty.resolveWith<Size>((states) {
                      if (states.contains(WidgetState.pressed)) {
                        return const Size(200, 40); // Set size when pressed
                      }
                      return const Size(200, 40); // Default size
                    }),
                    // Set background color
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Color.fromARGB(255, 4, 20, 42)), // Dark blue color
                    // Remove circular shape
                    shape: WidgetStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            4), // Set border radius to 0 for square edges
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Define your custom components here
class ManageAppointments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Manage Appointments Component'),
    );
  }
}

class AppointmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Appointment List Component'),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Staff Dashboard Example',
    home: DashboardPage(),
  ));
}
