import 'package:school_management/core/class/curd.dart';
import 'package:school_management/linkapi.dart';

class AdminData {
  Crud crud;
  AdminData(this.crud);
  //
  // fetchTeacherStudents
  getDataTeachereStudents(
    int? userId,
  ) async {
    var response = await crud.getData(
      "${AppLink.fetchTeacherStudents}?teacher_id=$userId",
    );
    print('=============== Teacher ID: $userId');
    print(
        '=============== AdminData getDataTeachereStudents : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

  //
  // fetchReportStudentForRoleTeacher
  getDataReportTeachereStudents(
    int? studentIdInRoleTeacher,
  ) async {
    var response = await crud.getData(
      "${AppLink.getReports}?student_id=$studentIdInRoleTeacher",
    );
    print('=============== Student ID: $studentIdInRoleTeacher');
    print(
        '=============== AdminData getDataReportTeachereStudents : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

  //
  // fetchReportStudentForRoleStudent
  getDataReportStudentForRoleStudent(
    int? studentIdInRoleStudent,
  ) async {
    var response = await crud.getData(
      "${AppLink.getReports}?student_id=$studentIdInRoleStudent",
    );
    print('=============== Student ID: $studentIdInRoleStudent');
    print(
        '=============== AdminData getDataReportStudentForRoleStudent : $response ===========');

    return response.fold((l) => l, (r) => r);
  }
}
