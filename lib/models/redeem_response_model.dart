class RedeemResponse {
  final bool success;
  final String message;
  final int? updatedPoints;

  RedeemResponse({
    required this.success,
    required this.message,
    this.updatedPoints,
  });

  factory RedeemResponse.fromJson(Map<String, dynamic> json) {
    return RedeemResponse(
      success: json['success'],
      message: json['message'],
      updatedPoints: json['updated_points'],
    );
  }
}
