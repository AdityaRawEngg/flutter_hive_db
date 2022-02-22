import 'package:hive/hive.dart';
import 'package:hive_poc/model/subject.dart';

part 'students.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? age;

  @HiveField(2)
  String? sid;

  @HiveField(3)
  List<Subject>? subjects;

  Student({
    required this.name,
    required this.age,
    required this.sid,
    required this.subjects,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        name: json['name'] ?? '',
        age: json['age'] ?? '',
        sid: json['sid'] ?? '',
        subjects: (json['subjects'] as List)
            .map((subject) => Subject.fromJson(subject))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'age': this.age,
      'sid': this.sid,
      'subjects': this.subjects!.map((subject) => subject.toJson()).toList()
    };
  }
}
