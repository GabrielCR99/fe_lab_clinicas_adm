import 'package:json_annotation/json_annotation.dart';

import 'patient_address_model.dart';

part 'patient_model.g.dart';

@JsonSerializable(createToJson: false)
final class PatientModel {
  final String id;
  final String name;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String document;
  final String email;
  final String guardian;
  @JsonKey(name: 'guardian_identification_number')
  final String guardianIdentificationNumber;
  final PatientAddressModel address;

  const PatientModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.document,
    required this.email,
    required this.guardian,
    required this.guardianIdentificationNumber,
    required this.address,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);
}
