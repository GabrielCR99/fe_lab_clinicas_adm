import 'package:json_annotation/json_annotation.dart';

import 'patient_model.dart';
part 'patient_information_form_model.g.dart';

@JsonEnum(valueField: 'id')
enum PatientInformationFormStatus {
  waiting(id: 'Waiting'),
  checkin(id: 'Checked In'),
  beingAttended(id: 'Being Attended');

  final String id;

  const PatientInformationFormStatus({required this.id});
}

@JsonSerializable(createToJson: false)
final class PatientInformationFormModel {
  final String id;
  final PatientModel patient;
  @JsonKey(name: 'health_insurance_card')
  final String healthInsuranceCard;
  @JsonKey(name: 'medical_order')
  final List<String> medicalOrders;
  final String password;
  @JsonKey(name: 'date_created')
  final DateTime dateCreated;
  final PatientInformationFormStatus status;

  const PatientInformationFormModel({
    required this.id,
    required this.patient,
    required this.healthInsuranceCard,
    required this.medicalOrders,
    required this.password,
    required this.dateCreated,
    required this.status,
  });

  factory PatientInformationFormModel.fromJson(Map<String, dynamic> json) =>
      _$PatientInformationFormModelFromJson(json);
}
