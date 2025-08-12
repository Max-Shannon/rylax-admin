import 'package:json_annotation/json_annotation.dart';

part 'create_development_phase_request.g.dart';

@JsonSerializable()
class CreateDevelopmentPhaseRequest {
  late final String phaseName;
  late final String phaseNumber;
  late final DateTime phaseEstimatedStartDate;
  late final DateTime phaseEstimatedEndDate;

  CreateDevelopmentPhaseRequest(this.phaseName, this.phaseNumber, this.phaseEstimatedStartDate, this.phaseEstimatedEndDate);

  Map<String, dynamic> toJson() => _$CreateDevelopmentPhaseRequestToJson(this);

  @override
  String toString() {
    return 'CreateDevelopmentPhaseRequest{phaseName: $phaseName, phaseNumber: $phaseNumber, phaseEstimatedStartDate: $phaseEstimatedStartDate, phaseEstimatedEndDate: $phaseEstimatedEndDate}';
  }
}
