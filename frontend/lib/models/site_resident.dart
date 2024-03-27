// Entidad - Residente en backend
class SiteResident {
  String? id;
  String firstName;
  String lastName;
  String jobPosition;
  String? phoneNumber;
  String? email;

  SiteResident({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.jobPosition,
    this.phoneNumber,
    this.email,
  });

  @override
  String toString() {
    return 'Manager: { firstName: $firstName, lastName: $lastName, jobPosition: $jobPosition, phoneNumber: $phoneNumber, email: $email }';
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "nombres": firstName,
        "apellidos": lastName,
        "puesto": jobPosition,
        "telefono": phoneNumber,
        "email": email
      };
}
