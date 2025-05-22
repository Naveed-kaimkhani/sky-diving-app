import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiClient {
  Future<http.Response> post({
    required String url,
    Object? body,
  }) async {
    return await http.post(Uri.parse(url), body: body);
  }


  static Future<http.Response> getMessages({
    required String url,
    Map<String, String>? headers,
  }) async {
    return await http.get(Uri.parse(url), headers: headers);
  }

  Future<http.Response> sendMessageAPI({
    required String url,
    Map<String, String>? headers,
    Object? body,
  }) async {
    return await http.post(Uri.parse(url), headers: headers, body: body);
  }

  Future<http.Response> get({
    required String url,
    Map<String, String>? headers,
    // Object? body,
  }) async {
    return await http.get(Uri.parse(url), headers: headers);
  }

  Future<http.Response> delete({
    required String url,
    Object? body,
  }) async {
    return await http.delete(
      Uri.parse(url),
      body: body,
    );
  }
}
