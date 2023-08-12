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
      final response =
          await http.get(Uri.parse('https://192.168.92.223:8800/planner'));
      final responseData = json.decode(response.body);
      List<dynamic> filteredPlanner = responseData.where((element) => element['status'] == 1).toList();

      setState(() {
        planner = filteredPlanner;
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
    return Scaffold(
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
                                  title: Text(
                                      'Planned Information    ( සැලසුම් කළ තොරතුරු )'),
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
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade50,//color of shadow
                                                spreadRadius: 2, //spread radius
                                                blurRadius: 2, // blur radius
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    alignment: Alignment.topLeft,
                                                    color: Colors.white,
                                                    //height: MediaQuery.of(context).size.height,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(18.0),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "Planned Task\n\n",
                                                            style: TextStyle(
                                                              fontSize: 28,
                                                              fontWeight:
                                                              FontWeight.w700,
                                                            ),
                                                          ),
                                                          Text(
                                                                planner[index]['msg'],
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 36,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    color: Colors.pink.shade50,
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          height: 50,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "Machine name : " +
                                                                planner[index][
                                                                    'machinename'],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "Unique ID : " +
                                                                planner[index][
                                                                    'uniqueName'],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "Department is : " +
                                                                planner[index][
                                                                    'departmentname'],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    color:
                                                        Colors.yellow.shade50,
                                                    height: 80,
                                                    child: Text(
                                                      "Planned Date : " +
                                                          planner[index]
                                                              ['date'],
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    color:
                                                        Colors.yellow.shade50,
                                                    //height: 80,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              18.0),
                                                      child: Text(
                                                        "Machine Description \n\n\n " +
                                                            planner[index]
                                                                ['smallDes'],
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    )),
                                              ),
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade900
                                .withOpacity(0.06), //color of shadow
                            spreadRadius: 2, //spread radius
                            blurRadius: 2, // blur radius
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "TODO : "+planner[index]['msg'],
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 22),
                          ),
                        ),
                        subtitle: Container(
                          color: Colors.pink.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text("Department name   "+planner[index]['departmentname'] +
                                " \n " +
                                "Machine name   "+planner[index]['machinename']),
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
