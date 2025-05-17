class NotificationModel {
  final String title;
  final String subtitle;
  final String date;

  NotificationModel({
    required this.title,
    required this.subtitle,
    required this.date,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] ?? '',
      subtitle: json['message'] ?? '',
      date: json['created_at'] ?? '',
    );
  }
}
