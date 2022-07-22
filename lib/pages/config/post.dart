import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> postData(
    {required Map<String, dynamic> body, required String function}) async {
  try {
    var dio = Dio();
    FormData formData = FormData.fromMap(body);
    var response = await dio.post('http://pokehub.pandacrp.com/api/' + function,
        data: formData);
    return await response.data;
  } catch (e) {
    print(e);
    return ({'error': 'can\'t reach server'});
  }
}