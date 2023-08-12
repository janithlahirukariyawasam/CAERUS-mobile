import 'package:caerus/Views/Equipment.dart';
import 'package:caerus/Views/Issues.dart';
import 'package:caerus/Views/Machines.dart';
import 'package:caerus/Views/Notices.dart';
import 'package:caerus/Views/Planner.dart';
import 'package:caerus/Views/Employees.dart';
import 'package:caerus/Views/ManageIssues.dart';
import 'package:caerus/Views/Auth/UpdateCredintiols.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<dynamic> issues = [];

  Future<void> _fetchIssues() async {
    try {
      final response = await http.get(Uri.parse('https://192.168.92.223:8800/issues'));
      final responseData = json.decode(response.body);
      final filteredIssues = responseData.where((issue) => issue['status'] == 1).toList();
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Center(
            child: Text(
              'SystemCAERUS',
              style: TextStyle(),
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black26,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade900
                            .withOpacity(0.5), //color of shadow
                        spreadRadius: 2, //spread radius
                        blurRadius: 7, // blur radius
                        offset: Offset(0, 2), // changes position of shadow
                        //first paramerter of offset is left-right
                        //second parameter is top to down
                      ),
                      //you can set more BoxShadow() here
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => IssuePage()),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          child: Container(
                            color: Colors.red.shade200,
                            height: 40,
                            child: Center(
                              child: Text(
                                'Issues',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              height: 430,
                              child: /*ListView(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      height: 40,
                                      color: Colors.red.shade100,
                                      child: Text("Text issue"),
                                    ),
                                  ),

                                ],
                              ),*/
                              ListView.builder(
                                itemCount: issues.length,
                                itemBuilder: (context, index) {
                                  final issue = issues[index];

                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                     // height: 40,
                                      color: Colors.red.shade100,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
                                        child: Text(issue['des'],style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
                                      ), // Assuming the issue data has a 'description' field.
                                    ),
                                  );
                                },
                              )
                            )),
                      ],
                    ),
                  ),
                  height: 500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>ManageIssues()),
                    );
                  },
                  child: Container(
                    height: 100,
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Machine Breakdowns",style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),),
                        Text("(යන්ත්‍ර බිඳවැටීම්)",style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),),
                      ],
                    )),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow:  [
                        BoxShadow(
                          color: Colors.grey.shade900.withOpacity(0.5), //color of shadow
                          spreadRadius: 1, //spread radius
                          blurRadius: 3, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                  ),
                ),),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Planner()),
                    );
                  },
                  child: Container(
                    height: 100,
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Planned Works",style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),),
                        Text("(සැලසුම් කළ වැඩ)",style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),),
                      ],
                    )),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow:  [
                          BoxShadow(
                            color: Colors.grey.shade900.withOpacity(0.5), //color of shadow
                            spreadRadius: 1, //spread radius
                            blurRadius: 3, // blur radius
                            offset: Offset(0, 2), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          ),
                          //you can set more BoxShadow() here
                        ],
                  ),
              ),
                ),),
             /* Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Container(
                  height: 60,
                  child: Center(child: Text("Chat (කතාබස් කරන්න)",style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),)),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow:  [
                      BoxShadow(
                        color: Colors.grey.shade900.withOpacity(0.5), //color of shadow
                        spreadRadius: 1, //spread radius
                        blurRadius: 3, // blur radius
                        offset: Offset(0, 2), // changes position of shadow
                        //first paramerter of offset is left-right
                        //second parameter is top to down
                      ),
                      //you can set more BoxShadow() here
                    ],
                  ),
                ),),*/
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>Machines()),
                    );
                  },
                  child: Container(
                    height: 100,
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Machines",style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),),
                        Text("(යන්ත්ර සහ උපකරණ)",style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),),
                      ],
                    )),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow:  [
                        BoxShadow(
                          color: Colors.grey.shade900.withOpacity(0.5), //color of shadow
                          spreadRadius: 1, //spread radius
                          blurRadius: 3, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                  ),
                ),),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>EquipmentPage()),
                    );
                  },
                  child: Container(
                    height: 100,
                    child: Center(child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Parts Under Repair",style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text("(අලුත්වැඩියාව යටතේ ඇති",style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),),
                            ),
                          ),
                          Text("කොටස්)",style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),),
                        ],
                      ),
                    )),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow:  [
                        BoxShadow(
                          color: Colors.grey.shade900.withOpacity(0.5), //color of shadow
                          spreadRadius: 1, //spread radius
                          blurRadius: 3, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                  ),
                ),),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>Employees()),
                    );
                  },
                  child: Container(
                    height: 100,
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Employees",style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),),
                        Text("(සේවකයින්)",style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),),
                      ],
                    )),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow:  [
                        BoxShadow(
                          color: Colors.grey.shade900.withOpacity(0.5), //color of shadow
                          spreadRadius: 1, //spread radius
                          blurRadius: 3, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                  ),
                ),),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationPage()),
                    );
                  },
                  child: Container(
                    height: 100,
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Notice Board ",style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),),
                        Text("(දැන්වීම් පුවරුව)",style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),),
                      ],
                    )),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow:  [
                        BoxShadow(
                          color: Colors.grey.shade900.withOpacity(0.5), //color of shadow
                          spreadRadius: 1, //spread radius
                          blurRadius: 3, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                  ),
                ),),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>LoginScreenMy()),
                    );
                  },
                  child: Container(
                    height: 100,
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("My Profile ",style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),),
                        Text("(මගේ ප්‍රොෆයිලය)",style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),),
                      ],
                    )),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow:  [
                        BoxShadow(
                          color: Colors.grey.shade900.withOpacity(0.5), //color of shadow
                          spreadRadius: 1, //spread radius
                          blurRadius: 3, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                  ),
                ),),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
