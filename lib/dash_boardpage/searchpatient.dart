import 'dart:async';
import 'dart:convert';
import 'package:flutter1/dash_boardpage/Searchpatientdata.dart';
import 'package:flutter1/dash_boardpage/dashboardpage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class Searchpatient extends StatefulWidget {
  const Searchpatient({Key? key}) : super(key: key);
  @override
  State<Searchpatient> createState() => _SearchpatientState();
}

class _SearchpatientState extends State<Searchpatient> {
  TextEditingController _numberController = TextEditingController();
  String? searchData;
  List<Map<String, dynamic>> formattedResults = [];
  Timer? _debounce;

  void debounceSearch() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchPatient();
    });
  }

  Future<void> searchPatient() async {
    final response = await http.get(
      Uri.parse(
          'https://app.sheikhafatimahospital.com/login/search?number=${_numberController.text}'),
    );
    if (response.statusCode == 200) {
      // print(response.body);
      setState(() {
        formattedResults = parseSearchResponse(response.body);
      });
    } else {
      setState(() {
        searchData = null;
      });
    }
    setState(() {});
  }

  List<Map<String, dynamic>> parseSearchResponse(String responseBody) {
    try {
      final List<dynamic> data = json.decode(responseBody);

      List<Map<String, dynamic>> searches =
          data.map<Map<String, dynamic>>((search) {
        return {
          'name': search['name'].toString(),
          'id': search['_id'].toString(),
          'phone_number': search['phone_number'].toString(),
          'age': search['age'].toString(),
          'family_member': search['family_member'].toString(),
        };
      }).toList();
      print(searches);
      return searches;
    } catch (error) {
      print('Error parsing API response: $error');
      return [];
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF8F8F8), // Set background color to F8F8F8
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                ); //
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _numberController,
                      onChanged: (value) {
                        debounceSearch();
                        print(_numberController.text);
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Enter patient number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: WidgetStateProperty.all(Size(200, 55)),
                      backgroundColor:
                          WidgetStateProperty.all(Color(0xFF4CCACF)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // onPressed: searchPatient,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPatient1()),
                      );
                    },
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: FractionallySizedBox(
                      child: Text('Name',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FractionallySizedBox(
                      child: Text('Phone Number',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FractionallySizedBox(
                      child: Text('Age',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FractionallySizedBox(
                      child: Text('Family Member',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FractionallySizedBox(
                      child: Icon(Icons.remove_red_eye_outlined),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: formattedResults.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE0EDFE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 50,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          flex: 2,
                          child: FractionallySizedBox(
                            child: Text(
                              '${formattedResults[index]['name']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF7B7B7B),
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: FractionallySizedBox(
                            child: Text(
                                '${formattedResults[index]['phone_number']}',
                                style: TextStyle(
                                    color: Color(0xFF7B7B7B),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: FractionallySizedBox(
                            child: Text('${formattedResults[index]['age']}',
                                style: TextStyle(
                                    color: Color(0xFF7B7B7B),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: FractionallySizedBox(
                            child: Text(
                              '${formattedResults[index]['family_member']}',
                              style: TextStyle(
                                color: Color(0xFF7B7B7B),
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FractionallySizedBox(
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context, '/individualpage',arguments: formattedResults[index]);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchPatient1(
                                        searchData: formattedResults[index]),
                                  ),
                                );
                              },
                              child: FractionallySizedBox(
                                child: Icon(Icons.remove_red_eye_outlined),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
