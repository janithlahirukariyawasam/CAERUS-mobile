import 'package:caerus/Views/MainPage/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    var url = 'https://192.168.92.223:8800/login';

    try {
      print(username + password);
      var response = await http.post(
        Uri.parse(url),
        body: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        // Successful login
        print("Successful");
        Map<String, dynamic> responseData = json.decode(response.body);
        int userId = responseData['userId'];
        print(userId);
        Fluttertoast.showToast(msg: 'Welcome '+username);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>MainPage()));
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

void main() => runApp(MaterialApp(home: LoginScreen()));
