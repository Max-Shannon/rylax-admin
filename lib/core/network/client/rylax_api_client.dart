import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rylax_admin/core/network/models/development_response.dart';

class RylaxAPIClient {

  final String baseUrl = 'http://192.168.1.132:8080/api/v1';
  //final String baseUrl = 'https://staging.rylax.ie/api/v1';

  Future<DevelopmentResponse> getDevelopmentsByBranchId(int branchId) async {
    final uri = Uri.parse("$baseUrl/developments?branchId=$branchId");
    //final token = await authService.getFirebaseToken();

    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'TODO - FILL THIS IN'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      return DevelopmentResponse.fromJson(jsonMap);
    } else {
      throw Exception('Failed to create buyer profile. Status: ${response.statusCode}');
    }
  }
}
