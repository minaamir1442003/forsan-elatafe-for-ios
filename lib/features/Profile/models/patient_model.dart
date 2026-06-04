class PatientProfile {
  final String name;
  final int age;
  final String occupation;
  final String maritalStatus;
  final int childrenCount;
  final String residence;
  final String status;
  final String entryDate;
  final List<dynamic> therapeuticHistory;  // 👈 أضف هذا

  PatientProfile({
    required this.name,
    required this.age,
    required this.occupation,
    required this.maritalStatus,
    required this.childrenCount,
    required this.residence,
    required this.status,
    required this.entryDate,
    required this.therapeuticHistory,  // 👈 أضف هذا
  });

  factory PatientProfile.fromJson(Map<String, dynamic> json) {
    return PatientProfile(
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      occupation: json['occupation'] ?? '',
      maritalStatus: json['maritalStatus'] ?? '',
      childrenCount: json['childrenCount'] ?? 0,
      residence: json['residence'] ?? '',
      status: json['status'] ?? '',
      entryDate: json['entryDate'] ?? '',
      therapeuticHistory: json['therapeuticHistory'] ?? [],  // 👈 أضف هذا
    );
  }
}