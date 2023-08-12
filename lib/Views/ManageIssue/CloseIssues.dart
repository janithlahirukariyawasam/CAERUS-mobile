import 'package:caerus/Views/MainPage/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CloseIssue extends StatefulWidget {
  @override
  _CloseIssueState createState() => _CloseIssueState();
}

class _CloseIssueState extends State<CloseIssue> {
  List<Map<String, dynamic>> breakdowns = [];
  String selectedIssueID = "";
  String closingRemark = "";
  String closingDes = "";
  String finishedWorkers = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> fetchIssues() async {
    try {
      final response = await http.get(Uri.parse("https://192.168.92.223:8800/issues"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          breakdowns = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchIssues();
  }

  void handleDropdownChange(String? value) {
    setState(() {
      selectedIssueID = value ?? "";
    });
  }

  void handleClose() async {
    if (_formKey.currentState!.validate()) {
      final requestData = {
        "finishedWorkers": finishedWorkers,
        "selectedIssueID": int.tryParse(selectedIssueID) ?? 0,
        "closingDes": closingDes,
        "closingRemark": closingRemark,
      };

      try {
        final response = await http.put(
          Uri.parse("https://192.168.92.223:8800/issues"),
          body: json.encode(requestData),
          headers: {
            "Content-Type": "application/json",
          },
        );
        if (response.statusCode == 200) {
          print("Issue closed successfully");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        } else {
          throw Exception("Failed to close issue");
        }
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("Close Breakdown"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedIssueID,
                  onChanged: handleDropdownChange,
                  items: [
                    DropdownMenuItem(
                      value: "",
                      child: Text("Select an Issue to Close"),
                    ),
                    ...breakdowns
                        .where((item) => item["status"] == 1)
                        .map((item) => DropdownMenuItem(
                      value: item["issueID"].toString(),
                      child: Text(item["des"]),
                    ))
                        .toList(),
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  onChanged: (value) {
                    closingRemark = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the Closing Remark";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Please Enter the Closing Remark",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  onChanged: (value) {
                    closingDes = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the Detailed Description about the breakdown";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Please enter the Detailed Description about the breakdown",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  onChanged: (value) {
                    finishedWorkers = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Employee's names who finished the Task";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Employee's names who finished the Task (Ex: Janith, Kavindu, Lahiru...)",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 46),
                ElevatedButton(
                  onPressed: handleClose,
                  child: Text("CLOSE BREAKDOWN"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade300),
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

void main() {
  runApp(MaterialApp(
    home: CloseIssue(),
    routes: {
      "/issues": (context) => Scaffold(body: Center(child: Text("Issues Screen"))),
    },
  ));
}



