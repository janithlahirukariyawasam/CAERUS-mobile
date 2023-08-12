import 'package:caerus/Views/ManageIssue/CloseIssues.dart';
import 'package:caerus/Views/ManageIssue/OpenIssues.dart';
import 'package:caerus/Views/Planner.dart';
import 'package:flutter/material.dart';

class ManageIssues extends StatefulWidget {
  const ManageIssues({Key? key}) : super(key: key);

  @override
  State<ManageIssues> createState() => _ManageIssuesState();
}

class _ManageIssuesState extends State<ManageIssues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("Manage Issues"),
      ),
      body: Container(
        color: Colors.black26,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OpenIssue()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Container(
                    height: 250,
                    width: 300,
                    child: Center(child: Text("Open Issues",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w700,color: Colors.white),)),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade200,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow:  [
                        BoxShadow(
                          color: Colors.purple.shade600, //color of shadow
                          spreadRadius: 1, //spread radius
                          blurRadius: 3, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CloseIssue()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Container(
                    height: 250,
                    width: 300,
                    child: Center(child: Text("Close Issues",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w700,color: Colors.white),)),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade200,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow:  [
                        BoxShadow(
                          color: Colors.pink.shade600, //color of shadow
                          spreadRadius: 1, //spread radius
                          blurRadius: 3, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
