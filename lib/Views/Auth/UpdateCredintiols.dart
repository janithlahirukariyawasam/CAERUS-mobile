/*import 'package:caerus/Views/MainPage/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';


class LoginScreenMy extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    var url = 'http://192.168.1.3:8800/login';

    try {
      print(username + password);
      var response = await http.post(
        Uri.parse(url),
        body: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {

        Map<String, dynamic> responseData = json.decode(response.body);
        var userId = responseData['userId'];

        print(userId);
        // Successful login
        print("Successful");
        Fluttertoast.showToast(msg: 'Welcome '+username);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>UpdateData()));
      } else {
        print("Failded Login");
        Fluttertoast.showToast(msg: 'Username or Password is incorrect');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('SystemCAERUS  Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: NetworkImage("https://th.bing.com/th/id/R.90ca7a4fd20410dc30120838477db029?rik=vO5oMnuusCMWRw&riu=http%3a%2f%2fs3.amazonaws.com%2fbizenglish%2fwp-content%2fuploads%2f2021%2f03%2f31132852%2fPyramid-Wilmar.png&ehk=sqMA%2bvZVr4iblBRPqL4jIVLn2kkKR0hdGIRW1ytWtJM%3d&risl=&pid=ImgRaw&r=0")),
            SizedBox(height: 130,),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: LoginScreenMy()));

class UpdateData extends StatefulWidget {
  const UpdateData({Key? key}) : super(key: key);

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text("userId" ),
      ),
    );
  }
}*/

import 'package:caerus/Views/Auth/MyInfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MaterialApp(home: LoginScreenMy()));

var usernameG = "";
var phoneG = "";
var userIDG=null;
GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class LoginScreenMy extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    var url = 'https://192.168.92.223:8800/login';

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        var userId = responseData['userId'];
        var usernameD = responseData['username'];
        var phone = responseData['phone'];
        usernameG = usernameD;
        phoneG = phone;
        userIDG = userId;

        print("Successful");
        Fluttertoast.showToast(msg: 'Welcome ' + username);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UpdateData(userId: userId)),
        );
      } else {
        print("Failed Login");
        Fluttertoast.showToast(msg: 'Username or Password is incorrect');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('SystemCAERUS  Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: NetworkImage(
                "https://th.bing.com/th/id/R.90ca7a4fd20410dc30120838477db029?rik=vO5oMnuusCMWRw&riu=http%3a%2f%2fs3.amazonaws.com%2fbizenglish%2fwp-content%2fuploads%2f2021%2f03%2f31132852%2fPyramid-Wilmar.png&ehk=sqMA%2bvZVr4iblBRPqL4jIVLn2kkKR0hdGIRW1ytWtJM%3d&risl=&pid=ImgRaw&r=0",
              ),
            ),
            SizedBox(
              height: 130,
            ),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green.shade300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateData extends StatefulWidget {
  final int userId;

  const UpdateData({Key? key, required this.userId}) : super(key: key);

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final TextEditingController newUsernameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void _updateUser(BuildContext context) async {
    String newUsername = newUsernameController.text;
    String newPassword = newPasswordController.text;

    var url = 'https://192.168.92.223:8800/employees/update_user';

    try {
      var response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': widget.userId.toString(),
          'newUsername': newUsername,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        print("User information updated successfully");
        Fluttertoast.showToast(msg: 'User information updated successfully');
      } else {
        print("Failed to update user information");
        Fluttertoast.showToast(msg: 'Failed to update user information');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: usernameG == phoneG,
              child: Container(
                width: MediaQuery.of(context).size.height,
                height: 250,
                color: Colors.red,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Warning  Notification",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Please Change The Default Username & Password\n\nකරුණාකර පෙරනිමි පරිශීලක නාමය සහ මුරපදය වෙනස් කරන්න',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyInfo(value: userIDG)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade50,//color of shadow
                        spreadRadius: 3, //spread radius
                        blurRadius: 3, // blur radius
                        offset: Offset(0, 3),
                      ),
                    ],
                    color:  Colors.purpleAccent.shade100,
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "My Information",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  )),
                  height: 200,
                  width: MediaQuery.of(context).size.height,
                  //color: Colors.purpleAccent,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                            appBar: AppBar(
                              backgroundColor: Colors.black54,
                              title: Text("Change Username & Password"),
                            ),
                            body: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextFormField(
                                        controller: newUsernameController,
                                        style: TextStyle(fontSize: 24),
                                        decoration: InputDecoration(
                                            labelText: 'New Username'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter a new username';
                                          } else if (value.length < 4) {
                                            return 'Username should be at least 4 characters';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: newPasswordController,
                                        style: TextStyle(fontSize: 24),
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            labelText: 'New Password'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter a new password';
                                          } else if (value.length < 4) {
                                            return 'Password should be at least 4 characters';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: confirmPasswordController,
                                        style: TextStyle(fontSize: 24),
                                        obscureText: true,
                                        decoration: InputDecoration(labelText: 'Confirm Password'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter the confirmation password';
                                          } else if (value != newPasswordController.text) {
                                            return 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 36),
                                      ElevatedButton(
                                        onPressed: () => {
                                          if (_formKey.currentState!.validate())
                                            {
                                              // Form is valid, proceed with updating user
                                              _updateUser(context),
                                            }
                                        },
                                        /*_updateUser(context),*/
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Update User',style: TextStyle(fontSize: 24),),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.green.shade400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade50,//color of shadow
                        spreadRadius: 3, //spread radius
                        blurRadius: 3, // blur radius
                        offset: Offset(0, 3),
                      ),
                    ],
                    color:  Colors.blue.shade200,
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "Update Username & Password",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  )),
                  height: 200,
                  width: MediaQuery.of(context).size.height,
                  //color: Colors.yellow,
                ),
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: newUsernameController,
                    decoration: InputDecoration(labelText: 'New Username'),
                  ),
                  TextFormField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'New Password'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _updateUser(context),
                    child: Text('Update User'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
