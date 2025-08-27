import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rylax_admin/core/network/models/create_development_phase_request.dart';
import 'package:rylax_admin/core/network/models/create_property_request.dart';
import 'package:rylax_admin/core/network/models/development_response.dart';
import 'package:rylax_admin/core/network/models/property_dto.dart';
import 'package:rylax_admin/core/services/auth_service.dart';

class RylaxAPIClient {
  final AuthService authService = AuthService();

  final String baseUrl = 'http://192.168.1.132:8080/api/v1';

  //final String baseUrl = 'http://10.201.55.196:8080/api/v1';

  Future<DevelopmentResponse> getDevelopmentsByBranchId(int branchId) async {
    final uri = Uri.parse("$baseUrl/developments?branchId=$branchId");
    final token = await authService.getFirebaseToken();

    final response = await http.get(uri, headers: {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': ?token});

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      return DevelopmentResponse.fromJson(jsonMap);
    } else {
      throw Exception('Status: ${response.statusCode}');
    }
  }

  Future<void> createDevelopmentPhase(int developmentId, CreateDevelopmentPhaseRequest createDevelopmentPhaseRequest) async {
    final uri = Uri.parse("$baseUrl/developments/$developmentId/development-phase");
    final body = json.encode(createDevelopmentPhaseRequest.toJson());
    final token = await authService.getFirebaseToken();

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': ?token},
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create development-phase. Status: ${response.statusCode}');
    }
  }

  Future<PropertyDTO> createProperty(int developmentPhaseId, CreatePropertyRequest createPropertyRequest) async {
    final uri = Uri.parse("$baseUrl/properties/$developmentPhaseId");
    final body = json.encode(createPropertyRequest.toJson());
    final token = await authService.getFirebaseToken();

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': ?token},
      body: body,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      return PropertyDTO.fromJson(jsonMap);
    } else {
      throw Exception('Failed to create property. Status: ${response.statusCode}');
    }
  }
}
