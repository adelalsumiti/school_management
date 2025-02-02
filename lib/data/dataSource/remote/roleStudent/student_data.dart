import 'dart:io';

import 'package:school_management/core/class/curd.dart';
import 'package:school_management/linkapi.dart';

class StudentData {
  Crud crud;
  StudentData(this.crud);
  //

  // fetch: Report => Student
  getDataReports(
    int? studentId,
  ) async {
    var response = await crud.getData(
      "${AppLink.getReports}?student_id=$studentId",
    );
    print('=============== Student ID: $studentId');
    print(
        '=============== StudentData getDataReports For Role Student : $response ===========');
    return response.fold((l) => l, (r) => r);
  }
  //

// Send Record
  sendRecord(int? idRecord, File file) async {
    var response = await crud.postUploadAudio(AppLink.addReport, file);
    print('=============== StudentData DeleteRecord ID: $idRecord =======');
    print('=============== StudentData DeleteRecord : $response ===========');

    return response.fold((l) => l, (r) => r);
  }
//

// Delete Record
  deleteRecord(
    int? idRecord,
  ) async {
    var response =
        await crud.postData(AppLink.deleteReport, {"id": idRecord.toString()});
    print('=============== StudentData DeleteRecord ID: $idRecord =======');
    print('=============== StudentData DeleteRecord : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

  Future deleteAudio(int? reportId, String? fieldName) async {
    var response = await crud.postAddEditDelete(AppLink.deleteRecord, {
      'report_id': reportId.toString(),
      'field_name': fieldName,
    });
    print('=============== deleteAudio ReportId ID: $reportId =======');
    print('=============== deleteAudio fieldName : $fieldName ===========');
    print('=============== deleteAudio response ID: $response =======');
    return response.fold((l) => l, (r) => r);
  }
}
