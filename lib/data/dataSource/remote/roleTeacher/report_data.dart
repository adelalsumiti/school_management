import 'package:school_management/core/class/curd.dart';
import 'package:school_management/linkapi.dart';

class ReportData {
  Crud crud;
  ReportData(this.crud);

  // Get Data For ReportTeachereStudents
  getDataReportTeachereStudents(
    int? studentIdInRoleTeacher,
  ) async {
    var response = await crud.getData(
      "${AppLink.getReports}?student_id=$studentIdInRoleTeacher",
    );
    print('=============== Student ID: $studentIdInRoleTeacher');
    print(
        '=============== ReportData getDataReportTeachereStudents : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

// Delete Report
  deleteReport(
    int? idReport,
  ) async {
    var response =
        await crud.postData(AppLink.deleteReport, {"id": idReport.toString()});
    print('=============== ReportData DeleteReport ID: $idReport =======');
    print('=============== ReportData DeleteReport : $response ===========');

    return response.fold((l) => l, (r) => r);
  }
}
