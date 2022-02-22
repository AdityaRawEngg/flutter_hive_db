import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_poc/data/data.dart';
import 'package:hive_poc/model/students.dart';
import 'package:hive_poc/model/subject.dart';
import 'package:hive_poc/model/teacher.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directoryPath =
      await pathProvider.getApplicationDocumentsDirectory();
  String path = directoryPath.path;
  Hive.initFlutter();
  Hive
    ..init(path)
    ..registerAdapter(TeacherAdapter())
    ..registerAdapter(StudentAdapter())
    ..registerAdapter(SubjectAdapter());
  await Hive.openBox<Teacher>('testBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int length = 0;
  List<Teacher> teachers = [];

  @override
  void initState() {
    super.initState();
    Hive.box<Teacher>('testBox').listenable().addListener(() {
      updateState();
    });
    openBox();
  }

  void updateState() {
    var teacherBox = Hive.box<Teacher>('testBox');
    setState(() {
      length = teacherBox.length;
      teachers = teacherBox.values.toList();
    });
  }

  void openBox() async {
    var teacherBox = Hive.box<Teacher>('testBox');
    setState(() {
      length = teacherBox.length;
      teachers = teacherBox.values.toList();
    });
  }

  void _incrementCounter() {
    var teacherBox = Hive.box<Teacher>('testBox');
    Teacher teacherData = Teacher.fromJson(teacher);
    teacherBox.add(teacherData);

    teacherBox.compact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: teachersListGenerator(teachersList: teachers),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Text(length.toString()),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(widget.title),
    //   ),
    //   body: ValueListenableBuilder<Box>(
    //       valueListenable: Hive.box<Teacher>('testBox').listenable(),
    //       builder: (context, box, widget) {
    //         return Center(
    //           child: ListView(
    //             children: teachersListGenerator(
    //                 teachersList: box.values.toList() as List<Teacher>),
    //           ),
    //         );
    //       }),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: _incrementCounter,
    //     tooltip: 'Increment',
    //     child: Text(length.toString()),
    //   ),
    // );
  }

  List<Widget> teachersListGenerator({required List<Teacher> teachersList}) {
    return List.generate(
        teachersList.length,
        (i) => TeacherView(
            teacherName: teachersList[i].name ?? '',
            subjectName: teachersList[i].subject!.name,
            students: teachersList[i].students ?? []));
  }
}

class TeacherView extends StatelessWidget {
  final String teacherName;

  final String subjectName;
  final List<Student> students;

  const TeacherView(
      {Key? key,
      required this.teacherName,
      required this.subjectName,
      required this.students})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          teacherName,
        ),
        for (var i = 0; i < students.length; i++) getStudentsName(students[i]),
        Text(
          subjectName,
        ),
      ],
    );
  }

  Widget getStudentsName(Student student) {
    return Text(student.name ?? '');
  }
}
