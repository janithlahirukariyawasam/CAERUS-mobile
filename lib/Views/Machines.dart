import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Machines extends StatefulWidget {
  const Machines({Key? key}) : super(key: key);

  @override
  State<Machines> createState() => _MachinesState();
}

class _MachinesState extends State<Machines> {
  List<dynamic> machines = [];
  List<dynamic> filterMachinesByStatus(List<dynamic> machines) {
    return machines.where((machine) => machine['hideMachine'] != 1).toList();
  }

  Future<void> _fetchMachines() async {
    try {
      final response =
          await http.get(Uri.parse('https://192.168.92.223:8800/machines'));
      final responseData = json.decode(response.body);

      List<dynamic> filteredMachines = filterMachinesByStatus(responseData);

      setState(() {
        machines = filteredMachines;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMachines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Machines '),
      ),
      body: Container(
        color: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            child: ListView.builder(
              itemCount: machines.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.black54,
                            title: Text("Machine Details"),
                          ),
                          body: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 400,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.pink
                                                .shade100, //color of shadow
                                            spreadRadius: 0, //spread radius
                                            blurRadius: 0, // blur radius
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                        shape: BoxShape.rectangle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'https://192.168.92.223:8800/' +
                                                  machines[index]['image']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 50,),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "Machine Name:  " +
                                              machines[index]['machinename'],
                                          style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.grey.shade800),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "Model name :  " +
                                              machines[index]['uniqueName'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.red.shade300),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "Machine Description\n\n " +
                                              machines[index]['smallDes'],
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 40,),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "Department of " +
                                              machines[index]['departmentname'] +
                                              "\n\n" +
                                              machines[index]['departmentdes'],
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                    // Add navigation logic for when a machine is tapped
                    // Similar to how it was done in the Employees screen
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink.shade100, //color of shadow
                              spreadRadius: 1, //spread radius
                              blurRadius: 1, // blur radius
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: Colors.pink.shade50,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors
                                            .pink.shade100, //color of shadow
                                        spreadRadius: 2, //spread radius
                                        blurRadius: 2, // blur radius
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://192.168.92.223:8800/' +
                                              machines[index]['image']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Machine : " +
                                                      machines[index]
                                                          ['machinename'],
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color:
                                                          Colors.grey.shade800),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 1, 0, 8),
                                            child: Text(
                                              "Model:  " +
                                                  machines[index]['uniqueName'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.red.shade300),
                                            ),
                                          ),
                                          Text("Department of " +
                                              machines[index]
                                                  ['departmentname']),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
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
