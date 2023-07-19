import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Planner extends StatefulWidget {
  const Planner({Key? key}) : super(key: key);

  @override
  State<Planner> createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  List<dynamic> planner = [];

  Future<void> _fetchPlanner() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.3:8800/planner'));
      final responseData = json.decode(response.body);
      setState(() {
        planner = responseData;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPlanner();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Planned Works   (සැලසුම් කළ වැඩ)'),
      ),
      body: Container(
        color: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            child: ListView.builder(
              itemCount: planner.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(
                              backgroundColor: Colors.black54,
                              title: Text('Planned Information    ( සැලසුම් කළ තොරතුරු )'),
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
                                        boxShadow: [BoxShadow(
                                          color: Colors.grey.shade900.withOpacity(0.06), //color of shadow
                                          spreadRadius: 2, //spread radius
                                          blurRadius: 2, // blur radius
                                          offset: Offset(0, 3),
                                        ),],
                                        color: Colors.black12,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                height: 50,
                                                child: Text(
                                                  planner[index]
                                                  ['msg'],
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Text(planner[index]
                                                ['machinename'])),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [BoxShadow(
                          color: Colors.grey.shade900.withOpacity(0.06), //color of shadow
                          spreadRadius: 2, //spread radius
                          blurRadius: 2, // blur radius
                          offset: Offset(0, 3),
                        ),],
                        color: Colors.black12,
                      ),
                      child: ListTile(
                        title: Text(planner[index]['msg'],style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                        subtitle: Text(planner[index]['departmentname'] + planner[index]['machinename']),
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
