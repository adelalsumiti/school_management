// import 'dart:io';

// class ReportModel {
//   int? id;
//   int? studentId;
//   int? teacherId;
//   int? classId;
//   String? date;
//   String? assessment;
//   String? note;
//   String? surah;
//   int? startVerse;
//   int? endVerse;
//   // Null filePath;
//   // Null audioNotePath;
//    File? filePath;
//   File? audioNotePath;
//   String? createdAt;

//   ReportModel(
//       {this.id,
//       this.studentId,
//       this.teacherId,
//       this.classId,
//       this.date,
//       this.assessment,
//       this.note,
//       this.surah,
//       this.startVerse,
//       this.endVerse,
//       this.filePath,
//       this.audioNotePath,
//       this.createdAt});

//   ReportModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     studentId = json['student_id'];
//     teacherId = json['teacher_id'];
//     classId = json['class_id'];
//     date = json['date'];
//     assessment = json['assessment'];
//     note = json['note'];
//     surah = json['surah'];
//     startVerse = json['startVerse'];
//     endVerse = json['endVerse'];
//     filePath = json['file_path'];
//     audioNotePath = json['audio_note_path'];
//     createdAt = json['created_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['student_id'] = studentId;
//     data['teacher_id'] = teacherId;
//     data['class_id'] = classId;
//     data['date'] = date;
//     data['assessment'] = assessment;
//     data['note'] = note;
//     data['surah'] = surah;
//     data['startVerse'] = startVerse;
//     data['endVerse'] = endVerse;
//     data['file_path'] = filePath;
//     data['audio_note_path'] = audioNotePath;
//     data['created_at'] = createdAt;
//     return data;
//   }
// }

//
//

import 'dart:io';

class ReportModel {
  int? id;
  int? studentId;
  int? teacherId;
  int? classId;
  String? date;
  String? assessment;
  String? note;
  String? surah;
  String? surahReview;
  int? startVerseReview;
  int? endVerseReview;
  int? startVerse;
  int? endVerse;
  File? filePath;
  File? audioNotePath;
  String? createdAt;

  ReportModel({
    this.id,
    this.studentId,
    this.teacherId,
    this.classId,
    this.date,
    this.assessment,
    this.note,
    this.surahReview,
    this.startVerseReview,
    this.endVerseReview,
    this.surah,
    this.startVerse,
    this.endVerse,
    this.filePath,
    this.audioNotePath,
    this.createdAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      studentId: json['student_id'],
      teacherId: json['teacher_id'],
      classId: json['class_id'],
      date: json['date'],
      assessment: json['assessment'],
      note: json['note'],
      surahReview: json['surahReview']!,
      startVerseReview: json['startVerseReview']!,
      endVerseReview: json['endVerseReview']!,
      surah: json['surah']!,
      startVerse: json['startVerse']!,
      endVerse: json['endVerse']!,
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'teacher_id': teacherId,
      'class_id': classId,
      'date': date,
      'assessment': assessment,
      'note': note,
      'surahReview': surahReview,
      'startVerseReview': startVerseReview,
      'endVerseReview': endVerseReview,
      'surah': surah,
      'startVerse': startVerse,
      'endVerse': endVerse,
    };
  }
}
