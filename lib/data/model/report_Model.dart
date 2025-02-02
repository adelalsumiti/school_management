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
  // File? filePath;
  String? filePath;
  // File? audioNotePath;
  String? audioNotePath;
  // String? studentAudioResponsePath;
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
    // this.studentAudioResponsePath,
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
      audioNotePath: json['audio_note_path']!,
      filePath: json['file_path']!,
      note: json['note'],
      surahReview: json['surahReview']!,
      startVerseReview: json['startVerseReview']!,
      endVerseReview: json['endVerseReview']!,
      surah: json['surah']!,
      startVerse: json['startVerse']!,
      endVerse: json['endVerse']!,
      // studentAudioResponsePath: json['student_audio_response_path']!,
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
      'audio_note_path': audioNotePath!,
      'file_path': filePath!,
      'note': note,
      'surahReview': surahReview!,
      'startVerseReview': startVerseReview!,
      'endVerseReview': endVerseReview!,
      'surah': surah!,
      'startVerse': startVerse!,
      // 'student_audio_response_path': studentAudioResponsePath,
      'endVerse': endVerse!,
    };
  }
}
