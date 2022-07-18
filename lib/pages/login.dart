import 'package:flutter/material.dart';
import 'package:pokeapp/pages/config/header.dart';
import 'config/header.dart';
import 'config/requests/login.dart';

class Login extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Login({super.key});
  Map<String, dynamic> Returned_value = {};

  var isLogin = false;
  String page = "login";
  bool _visible = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController error_box = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: default_AppBar(
        parms: {"leadingVisible": false, "actionVisible": false},
      ),
      drawer: new default_Container(parms: {
        'page': page,
        'account': {'isLogged': false}
      }),
      endDrawer: default_Drawer(
        parms: {},
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Login'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
            ),
          ),
          AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Text(
                Returned_value["error"] ?? "",
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              )),
          TextButton(
            onPressed: () {
              //TODO FORGOT PASSWORD SCREEN GOES HERE
            },
            child: Text(
              'Forgot Password',
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              onPressed: () {
                print(nameController.text);
                print(passwordController.text);
                final Returned_value = send_Login(
                    login: nameController.text,
                    password: passwordController.text);
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          SizedBox(
            height: 130,
          ),
          Text('New User? Create Account')
        ],
      ),
    );
  }
}
