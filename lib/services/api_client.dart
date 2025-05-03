
import 'package:http/http.dart' as http;

class ApiClient {
  Future<http.Response> post({
    required String url,
    // Map<String, String>? headers,
    Object? body,
  }) async {
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> get({
    required String url,
    Map<String, String>? headers,
    // Object? body,
  }) async {
    // log(http.get(Uri.parse(url), headers: headers).toString());
    return await http.get(Uri.parse(url), headers: headers);
  }
}
