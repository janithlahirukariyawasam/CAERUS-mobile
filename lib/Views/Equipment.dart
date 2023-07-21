import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Equipment extends StatefulWidget {
  const Equipment({Key? key}) : super(key: key);

  @override
  State<Equipment> createState() => _EquipmentState();
}

class _EquipmentState extends State<Equipment> {
  List<dynamic> equipments = [];

  Future<void> _fetchEquipment() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.3:8800/repairs'));
      final responseData = json.decode(response.body);
      setState(() {
        equipments = responseData;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchEquipment();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
