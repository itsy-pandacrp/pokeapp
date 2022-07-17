import 'package:http/http.dart' as http;

// ignore: non_constant_identifier_names
Future<String> send_Login(
    {required String login, required String password}) async {
  var map = new Map<String, dynamic>();
  map['login'] = login;
  map['password'] = password;

  final response = await http.post(
    Uri.parse('http://localhost/api.php'),
    body: map,
  );

  print(response.body);
  return (response.body);
}
