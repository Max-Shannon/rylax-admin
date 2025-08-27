import 'package:rylax_admin/core/network/models/create_development_phase_request.dart';
import 'package:rylax_admin/core/network/models/development_response.dart';
import 'package:rylax_admin/core/network/models/property_dto.dart';

import '../network/client/rylax_api_client.dart';
import '../network/models/create_property_request.dart';

class RylaxAPIService {
  final RylaxAPIClient rylaxClient = RylaxAPIClient();

  Future<DevelopmentResponse> getDevelopmentsForAgent(int branchId) {
    return rylaxClient.getDevelopmentsByBranchId(branchId);
  }

  Future<void> createDevelopmentPhase(int developmentId, CreateDevelopmentPhaseRequest createDevelopmentPhaseRequest) {
    return rylaxClient.createDevelopmentPhase(developmentId, createDevelopmentPhaseRequest);
  }

  Future<bool> createProperty(int developmentPhaseId, CreatePropertyRequest createPropertyRequest) {
    return rylaxClient.createProperty(developmentPhaseId, createPropertyRequest);
  }
}
