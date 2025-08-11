import 'package:rylax_admin/core/network/models/development_response.dart';

import '../network/client/rylax_api_client.dart';

class RylaxAPIService {
  final RylaxAPIClient rylaxClient = RylaxAPIClient();

  Future<DevelopmentResponse> getDevelopmentsForAgent(int branchId) {
    return rylaxClient.getDevelopmentsByBranchId(branchId);
  }
}
