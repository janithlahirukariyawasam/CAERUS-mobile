import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Employees extends StatefulWidget {
  const Employees({Key? key}) : super(key: key);

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  List<dynamic> employees = [];

  Future<void> _fetchEmployees() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.3:8800/employees'));
      final responseData = json.decode(response.body);
      setState(() {
        employees = responseData;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Employees   ( සේවකයින් )'),
      ),
      body: Container(
        color: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                appBar: AppBar(
                                  backgroundColor: Colors.black54,
                                  title: Text('Employees   ( සේවකයින් )'),
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
                                                color: Colors.yellow.shade900
                                                    .withOpacity(
                                                        0.3), //color of shadow
                                                spreadRadius: 2, //spread radius
                                                blurRadius: 2, // blur radius
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                            color: Colors.black12,
                                          ),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      18.0),
                                                  child: Container(
                                                    width: 150,
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            employees[index]
                                                                ['imageURL']),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(18.0),
                                                  child: Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      child: Center(
                                                        child: Text(
                                                            employees[index]['name'],
                                                            style: TextStyle(color: Colors.white.withOpacity(0.5),fontWeight: FontWeight.w900,fontSize: 20)),
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Container(
                                                    child: Text(employees[index]
                                                        ['email'])),
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
                          boxShadow: [
                            BoxShadow(
                              color: Colors.greenAccent
                                  .withOpacity(0.3), //color of shadow
                              spreadRadius: 2, //spread radius
                              blurRadius: 2, // blur radius
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: Colors.black12,
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
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          employees[index]['imageURL']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              employees[index]['name'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black87),
                                            ),
                                          ),
                                          Text(
                                              employees[index]['positionName']),
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
