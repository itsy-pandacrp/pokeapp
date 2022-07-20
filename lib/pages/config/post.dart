import 'package:dio/dio.dart';

Future<Map<String, dynamic>> postData(
    {required Map<String, dynamic> body}) async {
  var dio = Dio();
  try {
    FormData formData = FormData.fromMap(body);
    var response = await dio.post('http://127.0.0.1/api.php', data: formData);
    return response.data;
  } catch (e) {
    return {'error': 'Can\'t reach server'};
  }
}
