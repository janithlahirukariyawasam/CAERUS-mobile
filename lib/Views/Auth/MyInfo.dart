import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyInfo extends StatefulWidget {
  final int value;

  MyInfo({required this.value});

  @override
  _MyInfoState createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  List<Map<String, dynamic>> filteredUserData = [];

  @override
  void initState() {
    super.initState();
    print('Value: ${widget.value}');
    _filterData();
  }

  Future<void> _filterData() async {
    final response =
        await http.get(Uri.parse('https://192.168.92.223:8800/employees'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print('API Response: $data');
      List<Map<String, dynamic>> userDataList =
          List<Map<String, dynamic>>.from(data);
      print('User Data List: $userDataList');
      setState(() {
        filteredUserData = userDataList
            .where(
                (user) => user['userid'].toString() == widget.value.toString())
            .toList();
        print('Filtered User Data: $filteredUserData');
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('MyInfo Page'),
      ),
      body: Center(
        child: filteredUserData.isEmpty
            ? Text('No matching user found.')
            : Padding(
                padding: const EdgeInsets.all(18.0),
                child: SingleChildScrollView(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 5,),
                      ClipOval(
                        child: Image(
                            image: NetworkImage('https://192.168.92.223:8800/' +
                                filteredUserData[0]['imageURL']),fit: BoxFit.cover,width: 250,height: 250,),
                      ),
                      SizedBox(height: 50,),
                      Text('${filteredUserData[0]['name']}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 22),),
                      SizedBox(height: 50,),
                      Text('${filteredUserData[0]['positionName']}',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 22,color: Colors.red),),
                      SizedBox(height: 50,),
                      Text('Tel: ${filteredUserData[0]['phone']}',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 22),),
                      SizedBox(height: 50,),
                      Text('email: ${filteredUserData[0]['email']}'),
                      // Add more details here
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
