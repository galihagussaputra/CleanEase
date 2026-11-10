import 'package:http/http.dart' as http;
import 'dart:convert';

class AppHttpHelper {
  static const String _baseUrl = 'https://your-api.com';

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/$endpoint'))
        .timeout(const Duration(seconds: 15));
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic data) async {
    final response = await http
        .post(
          Uri.parse('$_baseUrl/$endpoint'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(data),
        )
        .timeout(const Duration(seconds: 15));
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http
        .put(
          Uri.parse('$_baseUrl/$endpoint'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(data),
        )
        .timeout(const Duration(seconds: 15));
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http
        .delete(Uri.parse('$_baseUrl/$endpoint'))
        .timeout(const Duration(seconds: 15));
    return _handleResponse(response);
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return <String, dynamic>{};
      final decoded = json.decode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      return {'data': decoded};
    }

    throw Exception('Failed to load data: ${response.statusCode}');
  }
}
