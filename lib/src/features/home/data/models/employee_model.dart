import 'package:isar/isar.dart';
part 'employee_model.g.dart';

@collection
class Employees {
  Id dbId = Isar.autoIncrement;
  final String? name;
  final String? role;
  final DateTime? startDate;
  final DateTime? endDate;

  Employees({
    this.name,
    this.role,
    this.startDate,
    this.endDate,
  });

  Employees copyWith({
    String? name,
    String? role,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Employees(
      name: name ?? this.name,
      role: role ?? this.role,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Employees.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        role = json['role'] as String?,
        startDate = json['start_date'] as DateTime?,
        endDate = json['end_date'] as DateTime?;

  Map<String, dynamic> toJson() => {
        'name': name,
        'role': role,
        'start_date': startDate,
        'end_date': endDate
      };
}
