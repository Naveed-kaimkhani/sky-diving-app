// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;

// class SupportRepo {
//   Future<Map<String, dynamic>> sendSupportMail({
//     required int userId,
//     required String title,
//     required String description,
//     List<File>? files,
//   }) async {
//     var uri = Uri.parse("https://deinfini.com/info/public/api/support-mail");

//     var request = http.MultipartRequest("POST", uri)
//       ..fields['user_id'] = userId.toString()
//       ..fields['title'] = title
//       ..fields['description'] = description;

//     // Add files if any
//     if (files != null && files.isNotEmpty) {
//       for (var file in files) {
//         request.files.add(await http.MultipartFile.fromPath('files[]', file.path));
//       }
//     }

//     request.headers['accept'] = 'application/json';

//     var streamedResponse = await request.send();
//     var response = await http.Response.fromStream(streamedResponse);

//     final data = jsonDecode(response.body);
//     return {
//       "success": response.statusCode == 200,
//       "data": data,
//     };
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class SupportRepo {
  Future<Map<String, dynamic>> sendSupportMail({
    required int userId,
    required String title,
    required String description,
    List<File>? files,
    required String token, // 🔐 Accept bearer token as a parameter
  }) async {
    var uri = Uri.parse("https://deinfini.com/info/public/api/support-mail");

    var request = http.MultipartRequest("POST", uri)
      ..fields['user_id'] = userId.toString()
      ..fields['title'] = title
      ..fields['description'] = description;

    // 📎 Add files if available
    if (files != null && files.isNotEmpty) {
      for (var file in files) {
        request.files
            .add(await http.MultipartFile.fromPath('files[]', file.path));
      }
    }

    // 🧾 Headers with Bearer Token
    request.headers.addAll({
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    log(response.statusCode.toString());
    log(response.body);
    final data = jsonDecode(response.body);
    return {
      "success": response.statusCode == 200,
      "data": data,
    };
  }
}
