// models/employee.dart
class Employee {
  final String title; // Full name
  final String subTitle; // Phone number
  final String? trailing; // URL or path to image

  Employee({
    required this.title,
    required this.subTitle,
    this.trailing,
  });
}
