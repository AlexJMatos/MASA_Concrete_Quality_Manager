class SiteResident {
  int? id;
  String firstName;
  String lastName;
  String jobPosition;

  SiteResident({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.jobPosition,
  });

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "job_position": jobPosition
    };
  }

  static SiteResident toModel(Map<String, Object?> map) {
    return SiteResident(
        id: map["id"] as int,
        firstName: map["first_name"] as String,
        lastName: map["last_name"] as String,
        jobPosition: map["job_position"] as String);
  }
}