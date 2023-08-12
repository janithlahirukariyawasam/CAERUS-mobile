import 'package:caerus/Views/MainPage/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OpenIssue extends StatefulWidget {
  @override
  _OpenIssueState createState() => _OpenIssueState();
}

class _OpenIssueState extends State<OpenIssue> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _issueTitleController = TextEditingController();
  TextEditingController _issueDescController = TextEditingController();
  TextEditingController _assigneeController = TextEditingController();
  int? _priority;
  int? _departmentID;
  int? _machineID;

  List<dynamic> machines = [];
  List<dynamic> departments = [];

  Future<void> fetchMachines() async {
    try {
      final response = await http.get(Uri.parse('https://192.168.92.223:8800/machines'));
      final responseData = json.decode(response.body);
      List<dynamic> filteredData = responseData.where((element) => element['hideMachine'] == 0).toList();
      setState(() {
        machines = filteredData;
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchDepartments() async {
    try {
      final response = await http.get(Uri.parse('https://192.168.92.223:8800/departments'));
      final responseData = json.decode(response.body);
      List<dynamic> filteredDep = responseData.where((element) => element['hide'] == 0).toList();
      setState(() {
        departments = filteredDep;
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> createIssue() async {
    final Map<String, dynamic> issueData = {
      'issueTitle': _issueTitleController.text,
      'issueDesc': _issueDescController.text,
      'priority': _priority,
      'departmentID': _departmentID,
      'machineID': _machineID,
      'assignee': _assigneeController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('https://192.168.92.223:8800/issues'),
        body: json.encode(issueData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Issue created successfully.');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
        // Handle successful creation here, like showing a success message, navigating to another screen, etc.
      } else {
        print('Issue creation failed. Status code: ${response.statusCode}');
        // Handle failure here, like showing an error message to the user.
      }
    } catch (error) {
      print('Error creating issue: $error');
      // Handle error here, like showing an error message to the user.
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMachines();
    fetchDepartments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("OPEN BREAKDOWN"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _issueTitleController,
                  decoration: InputDecoration(
                    labelText: "Please Enter the Breakdown Title:",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the title of the issues.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _issueDescController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "Please Enter the Description:",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the issues description.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _assigneeController,
                  decoration: InputDecoration(
                    labelText: "Please Assign an Employee (Optional):",
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: _priority,
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text("Low Priority"),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text("Avg Priority"),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text("High Priority"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _priority = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Select Priority",
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Priority is missing";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: _departmentID,
                  items: departments.map((department) {
                    return DropdownMenuItem<int>(
                      value: department['id'],
                      child: Text(department['departmentname']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _departmentID = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Select Department",
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Please select Department";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: _machineID,
                  items: machines.map((machine) {
                    return DropdownMenuItem<int>(
                      value: machine['machineid'],
                      child: Text("${machine['machinename']} # ${machine['uniqueName']}"),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _machineID = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Select Machine",
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Please select Machine";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 60),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        createIssue();
                      }
                    },
                    child: Text("OPEN BREAKDOWN",style: TextStyle(fontSize: 20),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade300),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

