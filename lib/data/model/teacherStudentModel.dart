class TeacherStudentModel {
  String? _studentName;
  int? _studentId;
  int? _classId;
  String? _className;

  TeacherStudentModel(
      {String? studentName, int? studentId, int? classId, String? className}) {
    if (studentName != null) {
      _studentName = studentName;
    }
    if (studentId != null) {
      _studentId = studentId;
    }
    if (classId != null) {
      _classId = classId;
    }
    if (className != null) {
      _className = className;
    }
  }

  String? get studentName => _studentName;
  set studentName(String? studentName) => _studentName = studentName;
  int? get studentId => _studentId;
  set studentId(int? studentId) => _studentId = studentId;
  int? get classId => _classId;
  set classId(int? classId) => _classId = classId;
  String? get className => _className;
  set className(String? className) => _className = className;

  TeacherStudentModel.fromJson(Map<String, dynamic> json) {
    _studentName = json['student_name'];
    _studentId = json['student_id'];
    _classId = json['class_id'];
    _className = json['class_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_name'] = _studentName;
    data['student_id'] = _studentId;
    data['class_id'] = _classId;
    data['class_name'] = _className;
    return data;
  }
}
