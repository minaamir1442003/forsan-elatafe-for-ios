class RequestModel {
  final String name;
  final int age;
  final String nationalId;
  final String phoneNumber;
  final String location;
  final String occupation;
  final String maritalStatus;
  final int childrenCount;
  final String residence;

  RequestModel({
    required this.name,
    required this.age,
    required this.nationalId,
    required this.phoneNumber,
    required this.location,
    required this.occupation,
    required this.maritalStatus,
    required this.childrenCount,
    required this.residence,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
    'nationalId': nationalId,
    'phoneNumber': phoneNumber,
    'location': location,
    'occupation': occupation,
    'maritalStatus': maritalStatus,
    'childrenCount': childrenCount,
    'residence': residence,
  };
}

class RequestStatusModel {
  final String name;
  final String status;
  final DateTime createdAt;

  RequestStatusModel({
    required this.name,
    required this.status,
    required this.createdAt,
  });

  factory RequestStatusModel.fromJson(Map<String, dynamic> json) {
    return RequestStatusModel(
      name: json['name'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}