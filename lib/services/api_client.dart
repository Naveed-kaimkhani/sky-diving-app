
import 'package:http/http.dart' as http;

class ApiClient {
  Future<http.Response> post({
    required String url,
    Object? body,
  }) async {
    return await http.post(Uri.parse(url), body: body);
  }
// _TypeError (type 'int' is not a subtype of type 'String' in type cast)
// Future<http.Response> post({
//   required String url,
//   Object? body,
//   Map<String, String>? headers, // Optional headers
// }) async {
//   return await http.post(
//     Uri.parse(url),
//     body: body,
//     headers: headers, // Pass headers only if not null
//   );
// }

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
