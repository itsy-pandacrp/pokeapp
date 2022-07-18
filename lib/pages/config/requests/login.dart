import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: non_constant_identifier_names
Future<Map<String, dynamic>> send_Login(
    {required String login, required String password}) async {
  var map = new Map<String, dynamic>();
  map['login'] = login;
  map['password'] = password;

  final response = await http.post(
    Uri.parse('http://localhost/api.php'),
    body: map,
  );
  Map<String, dynamic> resp = jsonDecode(response.body);
  print(resp);
  return (resp);
}
