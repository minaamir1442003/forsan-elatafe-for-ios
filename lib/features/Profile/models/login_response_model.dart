class LoginResponseModel {
  final bool success;
  final String? token;
  final String? patientId;
  final String? name;
  final String? message;

  LoginResponseModel({
    required this.success,
    this.token,
    this.patientId,
    this.name,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] ?? false,
      token: json['data']?['token'],
      patientId: json['data']?['patientId'],
      name: json['data']?['name'],
      message: json['message'],
    );
  }
}