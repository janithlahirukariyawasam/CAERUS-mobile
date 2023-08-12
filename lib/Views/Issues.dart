import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IssuePage extends StatefulWidget {
  @override
  _IssuePageState createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  List<dynamic> issues = [];

  Future<void> _fetchIssues() async {
    try {
      final response =
          await http.get(Uri.parse('https://192.168.92.223:8800/issues'));
      final responseData = json.decode(response.body);

      // Filter the data based on the 'status' field (if needed)
      List<dynamic> filteredIssues =
          responseData.where((issue) => issue['status'] == 1).toList();

      setState(() {
        issues = filteredIssues;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchIssues();
  }

  Color _getColorForPriority(int priority) {
    switch (priority) {
      case 0:
        return Colors.green.shade50; // or any color you want for priority 1
      case 1:
        return Colors.yellow.shade50; // or any color you want for priority 2
      case 2:
        return Colors.red.shade100; // or any color you want for priority 3
      default:
        return Colors.black; // or any default color
    }
  }

  String getPriorityDescription(int priority) {
    switch (priority) {
      case 0:
        return "Low priority";
      case 1:
        return "Average priority";
      case 2:
        return "High priority";
      default:
        return "Unknown priority";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Issues Page   ( බිඳවැටීම් )'),
      ),
      body: Container(
        color: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            child: ListView.builder(
              itemCount: issues.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.black54,
                            title: Text('Issue Details'),
                          ),
                          body: SafeArea(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black26,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SingleChildScrollView(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.yellow.shade900.withOpacity(0.3),
                                          //color of shadow
                                          spreadRadius: 2, //spread radius
                                          blurRadius: 2, // blur radius
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Container(
                                            color: Colors.white,
                                            //height: 150,
                                            child: Padding(
                                              padding: const EdgeInsets.all(18.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    issues[index]['des'],
                                                    style: TextStyle(
                                                      fontSize: 46,
                                                      fontWeight: FontWeight.w700,
                                                      color: Colors.red.shade900,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          color: Colors.white70,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Container(
                                            width: 500,
                                            color: Colors.blue.shade50,
                                            child: Padding(
                                              padding: const EdgeInsets.all(18.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Department :  " + issues[index]['departmentname'],
                                                    style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w900,fontSize: 18),
                                                  ),
                                                  SizedBox(height: 8,),
                                                  Text(
                                                    "Machine :  " + issues[index]['machinename'],
                                                    style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w900,fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 50,),
                                        Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Container(
                                            child: Text(
                                              issues[index]['dDes'] ?? 'No description available',style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Container(child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(getPriorityDescription(issues[index]['priority']),style: TextStyle(fontSize: 16),),
                                          ),color: Colors.red.shade100,),
                                        )

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.yellow.shade900.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 9,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Breakdown\n",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22,
                                        color: Colors.black),
                                  ),
                                  Container(
                                    color: _getColorForPriority(
                                        issues[index]['priority']),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        issues[index]['des'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
