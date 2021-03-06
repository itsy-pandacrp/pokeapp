import 'package:flutter/material.dart';
import 'package:pokeapp/pages/config/header.dart';
import 'package:pokeapp/pages/config/post.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pokeapp/pages/home.dart';
import 'package:pokeapp/pages/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final storage = new FlutterSecureStorage();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String userToken = "";

  @override
  void initState() {
    super.initState();
    storage.read(key: 'uti_token').then((value) {
      setState(() {
        userToken = value ?? "";
      });
      if (userToken != "") {
        print(userToken);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      }
    });
  }

  var isLogin = false;
  String page = "login";
  bool _visible = false;
  String _text = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: const DefaultAppBar(
        parms: {"leadingVisible": false, "actionVisible": false},
      ),
      drawer: DefaultContainer(parms: {
        'page': page,
        'account': const {'isLogged': false}
      }),
      endDrawer: DefaultDrawer(
        parms: const {},
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Login'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
            ),
          ),
          Visibility(
              visible: _visible,
              child: Text(
                _text,
                style: const TextStyle(
                  color: Colors.blue,
                ),
              )),
          TextButton(
            onPressed: () async {},
            child: const Text(
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
              onPressed: () async {
                _visible = false;

                Map<String, dynamic> res = await postData(body: {
                  'email': nameController.text,
                  'password': passwordController.text,
                }, function: 'login');

                print(res);

                setState(() {
                  _visible = res.containsKey('error');
                  _text = res['error'] ?? "";
                  userToken = res['api_token'] ?? "";
                  print(userToken);

                  storage.write(key: 'uti_token', value: userToken);

                  if (res.containsKey('api_token') && res["api_token"] != "") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  }
                });
              },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          const SizedBox(
            height: 130,
          ),
          TextButton(
              child: Text('New User? Create Account'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Register()),
                );
              }),
        ],
      ),
    );
  }
}
