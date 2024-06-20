import 'package:flutter/material.dart';

class IndividualPage extends StatefulWidget {
final Map<String, dynamic>? searchData;

  const IndividualPage({Key? key, this.searchData}) : super(key: key);
  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  @override
  Widget build(BuildContext context) {
 return Scaffold(
         appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Patient Details",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: WidgetStateProperty.all(Size(180, 45)),
                    backgroundColor: WidgetStateProperty.all(Color(0xFF4CCACF)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Search',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 235, 235, 235),
              borderRadius: BorderRadius.circular(4),
            ),
            // height: ,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildInfoText('Patient Name: ${widget.searchData?['name']}'),
                  _buildInfoText('Phone Number: ${widget.searchData?['phone_number']}'),
                  _buildInfoText('Age: ${widget.searchData?['age']}'),
                  _buildInfoText('Registered Family Members: ${widget.searchData?['family_member']}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Flexible(
      child: Text(
        text,
        style: TextStyle(
          // color: Color(0xFF7B7B7B),
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ),
    );
  }
  }