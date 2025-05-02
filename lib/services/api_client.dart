
import 'package:http/http.dart' as http;
class ApiClient {
    Future<http.Response> post({
    required String url,
    // Map<String, String>? headers,
    Object? body,
  }) async {
    return await http.post(Uri.parse(url), body: body);
  }
//,headers: headers
//http://127.0.0.1:8000/api/
}