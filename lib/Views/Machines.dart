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

  Future<void> _fetchMachines() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.3:8800/machines'));
      final responseData = json.decode(response.body);
      setState(() {
        machines = responseData;
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
    return const Placeholder();
  }
}
