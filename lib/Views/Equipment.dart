import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EquipmentPage extends StatefulWidget {
  @override
  _EquipmentPageState createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  List<dynamic> equipments = [];

  Future<void> _fetchEquipments() async {
    try {
      final response = await http.get(Uri.parse('https://192.168.92.223:8800/repairs'));
      final responseData = json.decode(response.body);

      // Filter the data based on the 'status' field
      List<dynamic> filteredEquipments = responseData.where((equipment) => equipment['status'] == 1).toList();

      setState(() {
        equipments = filteredEquipments;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchEquipments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Equipments   ( අලුත්වැඩියා යටතේ )'),
      ),
      body: Container(
        color: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            child: ListView.builder(
              itemCount: equipments.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.black54,
                            title: Text('Under Repair    ( අලුත්වැඩියා යටතේ )'),
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
                                                    "Equipment name," ,
                                                    style: TextStyle(
                                                      fontSize: 28,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  Text(
                                                    equipments[index]['partname'],
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
                                            color: Colors.pink.shade50,
                                            child: Padding(
                                              padding: const EdgeInsets.all(18.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Return Date :  " + equipments[index]['returndate'].toString().substring(0, 10),
                                                    style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w900,fontSize: 18),
                                                  ),
                                                  SizedBox(height: 8,),
                                                  Text(
                                                    "Given Date :  " + equipments[index]['givendate'].toString().substring(0, 10),
                                                    style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w900,fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
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
                                                    "Department :  " + equipments[index]['departmentname'],
                                                    style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w900,fontSize: 18),
                                                  ),
                                                  SizedBox(height: 8,),
                                                  Text(
                                                    "Machine :  " + equipments[index]['machinename'],
                                                    style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w900,fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Container(
                                            width: 400,
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(18.0),
                                              child: Text(
                                                " " + (equipments[index]['repairnote'] ?? 'No Repair Note'),
                                                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                                              ),
                                            ),
                                          ),
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
                            color: Colors.purple.shade900.withOpacity(0.4), //color of shadow
                            spreadRadius: 2, //spread radius
                            blurRadius: 2, // blur radius
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
                              Text(
                                "Part name : " + equipments[index]['partname'] + "\n",
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26, color: Colors.black),
                              ),
                              Text(
                                "Machine name : " + equipments[index]['machinename'],
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Return data : " + equipments[index]['returndate'].toString().substring(0, 10),
                            style: TextStyle(color: Colors.black87.withOpacity(0.7)),
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


