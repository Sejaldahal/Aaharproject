import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://4133-110-44-118-183.ngrok-free.app';

  static Future<Map<String, dynamic>> getProductInfo(String barcode) async {
    final url = Uri.parse('$baseUrl/product/$barcode');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch product info: ${response.body}');
    }
  }
}
