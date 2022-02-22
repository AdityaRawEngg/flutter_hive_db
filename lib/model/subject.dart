import 'package:hive/hive.dart';

part 'subject.g.dart';

@HiveType(typeId: 1)
class Subject extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String sid;
  Subject({
    required this.name,
    required this.sid,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      name: json['name'] ?? '',
      sid: json['sid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'sid': this.sid,
    };
  }
}
