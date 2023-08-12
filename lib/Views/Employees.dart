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
  List<dynamic> filterEmployeesByStatus(List<dynamic> employees) {
    return employees.where((employee) => employee['status'] != 0).toList();
  }

  Future<void> _fetchEmployees() async {
    try {
      final response =
          await http.get(Uri.parse('https://192.168.92.223:8800/employees'));
      final responseData = json.decode(response.body);

      // Filter the employees list based on the 'status' attribute
      List<dynamic> filteredEmployees = filterEmployeesByStatus(responseData);

      setState(() {
        employees = filteredEmployees;
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
                                                color: Colors.white, //color of shadow
                                                spreadRadius: 2, //spread radius
                                                blurRadius: 2, // blur radius
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                            color: Colors.black12,
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 50,),
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      18.0),
                                                  child: Container(
                                                    width: 250,
                                                    height: 250,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: NetworkImage('https://192.168.92.223:8800/'+
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
                                                  padding: const EdgeInsets.all(
                                                      18.0),
                                                  child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Center(
                                                        child: Text(
                                                            employees[index]
                                                                ['name'],
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontSize: 20)),
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(18.0),
                                                child: Container(
                                                    child: Text(employees[index]
                                                    ['positionName'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Container(
                                                    child: Text(employees[index]
                                                        ['email'])),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(18.0),
                                                child: Container(
                                                    child: Text("Tel: " +employees[index]
                                                    ['phone'])),
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
                          color: Colors.white,
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
                                          'https://192.168.92.223:8800/' +
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
