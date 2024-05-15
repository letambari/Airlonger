import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  static Future<Map<String, dynamic>> getUserData(String token) async {
    final String apiUrl = 'https://api.airlonger.com/api/profile/';
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData['status'] == 'failed') {
        throw Exception(responseData['message']);
      } else {
        // If the server returns a 200 OK response, parse the JSON response
        Map<String, dynamic> userData = responseData;
        return userData['data'];
      }
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load user data');
    }
  }
}
