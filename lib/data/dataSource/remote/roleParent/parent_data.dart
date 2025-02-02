import 'package:school_management/core/class/curd.dart';
import 'package:school_management/linkapi.dart';

class ParentData {
  Crud crud;
  ParentData(this.crud);
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
        '=============== ParentData getDataTeachereStudents : $response ===========');

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
        '=============== ParentData getDataReportTeachereStudents : $response ===========');

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
        '=============== ParentData getDataReportStudentForRoleStudent : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

// Delete Report
  deleteReport(
    int? idReport,
  ) async {
    var response =
        await crud.postData(AppLink.deleteReport, {"id": idReport.toString()});
    print('=============== ParentData DeleteReport ID: $idReport =======');
    print('=============== ParentData DeleteReport : $response ===========');

    return response.fold((l) => l, (r) => r);
  }
}
