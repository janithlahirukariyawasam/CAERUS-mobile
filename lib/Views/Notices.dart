import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<dynamic> notifications = [];

  Future<void> _fetchNotifications() async {
    try {
      final response = await http.get(Uri.parse('https://192.168.92.223:8800/hr'));
      final responseData = json.decode(response.body);
      setState(() {
        notifications = responseData;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Notice Board   ( දැන්වීම් පුවරුව )'),
      ),
      body: Container(
        color: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                appBar: AppBar(
                                  backgroundColor: Colors.black54,
                                  title: Text('Notice    ( දැනුම්දීම )'),
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
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: Container(
                                                    color: Colors.yellow,
                                                    //height: 150,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              18.0),
                                                      child: Text(
                                                        "Notice Title\n\n" +
                                                            notifications[index]
                                                                [
                                                                'notification'],
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              Container(
                                                height: 50,
                                                color: Colors.white70,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: Container(
                                                    width: 500,
                                                    color: Colors.pink.shade100,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              18.0),
                                                      child: Text(
                                                          "Notice Date   \n\n" +
                                                              notifications[
                                                                          index]
                                                                      ['date']
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.9),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900)),
                                                    )),
                                              ),
                                              Container(
                                                height: 50,
                                                color: Colors.white70,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: Container(
                                                    width: 400,
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              18.0),
                                                      child: Text(
                                                          "Notice Body\n\n" +
                                                              notifications[
                                                                      index]
                                                                  ['desc'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,fontSize: 16)),
                                                    )),
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
                            color: Colors.red.shade900
                                .withOpacity(0.4), //color of shadow
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
                          child: Text(
                            "Notice Title\n\n\n"+notifications[index]['notification'],
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            notifications[index]['date']
                                .toString()
                                .substring(0, 10),
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.7)),
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
