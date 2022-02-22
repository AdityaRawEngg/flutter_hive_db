import 'package:hive_flutter/adapters.dart';
import 'package:hive_poc/model/students.dart';
import 'package:hive_poc/model/subject.dart';

part 'teacher.g.dart';

@HiveType(typeId: 2)
class Teacher extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? age;

  @HiveField(2)
  String? tid;

  @HiveField(3)
  List<Student>? students;

  @HiveField(4)
  Subject? subject;

  Teacher({
    this.name,
    this.age,
    this.tid,
    this.students,
    this.subject,
  });
  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      name: json['name'],
      age: json['age'],
      tid: json['tid'],
      students: (json['students'] as List)
          .map((student) => Student.fromJson(student))
          .toList(),
      subject: Subject.fromJson(json['subject']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['tid'] = this.tid;
    data['students'] =
        this.students!.map((student) => student.toJson()).toList();
    data['subject'] = this.subject;
    return data;
  }
}
