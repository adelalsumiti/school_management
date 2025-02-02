import 'package:school_management/core/class/curd.dart';
import 'package:school_management/linkapi.dart';

class HomeData {
  Crud crud;
  HomeData(this.crud);
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
        '=============== HomeData getDataTeachereStudents : $response ===========');

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
        '=============== HomeData getDataReportTeachereStudents : $response ===========');

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
        '=============== HomeData getDataReportStudentForRoleStudent : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

// Delete Report
  deleteReport(
    int? idReport,
  ) async {
    var response =
        await crud.postData(AppLink.deleteReport, {"id": idReport.toString()});
    print('=============== HomeData DeleteReport ID: $idReport =======');
    print('=============== HomeData DeleteReport : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

  //

  // getSearch(String data) async {
  //   var response = await crud.postData(AppLink.cashcust, {"datasearch": data});

  //   return response.fold((l) => 1, (r) => r);
  // }

  // getSearchHome(String data) async {
  //   var response = await crud.postData(AppLink.home, {"datasearch": data});

  //   return response.fold((l) => 1, (r) => r);
  // }

  // getData() async {
  //   var response = await crud.postData(AppLink.cashcust, {});

  //   return response.fold((l) => l, (r) => r);
  // }

  // getDataHome() async {
  //   var response = await crud.postData(AppLink.home, {});

  //   return response.fold((l) => l, (r) => r);
  // }

  // getimagbody() async {
  //   var response = await crud.postData(AppLink.imagebody, {});

  //   return response.fold((l) => l, (r) => r);
  // }
}
