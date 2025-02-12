import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:school_management/core/class/curd.dart';
import 'package:school_management/linkapi.dart';

class ReportData {
  Crud crud;
  ReportData(this.crud);

// Get PlayAudio :
  // getPlayAyahAudio(int surah, int verse) async {
  // Future
  getPlayAyahAudio(String fullPath) async {
    //
    // String fullPath =
    //     "https://www.everyayah.com/data/Minshawy_Mujawwad_64kbps/${surah.toString().padLeft(3, '0')}${verse.toString().padLeft(3, '0')}.mp3";
    log('getPlayAyahAudio Url  $fullPath');
    var response = await crud.getPlayAudio(fullPath);
    print('=============== FilePath ID: $fullPath');
    print('=============== ReportData getPlayAudio : $response ===========');
    // return response.fold((l) => l, (r) => r);
    // return response.fold((l) => (l), (r) => r);
    return response.fold((l) => left(l), (r) => r);
    //this is soultion(الملف غير موجود) =>
  }

// Get PlayAudio :
  getPlayAudio(String fullPath) async {
    var response = await crud.getPlayAudio(fullPath);
    print('=============== FilePath ID: $fullPath');
    print('=============== ReportData getPlayAudio : $response ===========');
    // return response.fold((l) => l, (r) => r);
    //this is soultion(الملف غير موجود) =>
    return response.fold((l) => left(l), (r) => r);
  }

//
  // Get Data For ReportTeachereStudents
  getDataReport(
    int? studentId,
  ) async {
    var response = await crud.getData(
      "${AppLink.getReports}?student_id=$studentId",
    );
    print('=============== Student ID: $studentId');
    print('=============== ReportData getDataReport : $response ===========');
    return response.fold((l) => l, (r) => r);
  }

// Send Record
  sendRecord(int idRecord, File audioFile) async {
    var response = await crud.postUploadAudio(
        AppLink.submitTeacherResponse, audioFile, idRecord);
    print('=============== StudentData DeleteRecord ID: $idRecord =======');
    print('=============== StudentData DeleteRecord : $response ===========');
    // return response.fold((l) => left(l), (r) => r);
    return response.fold((l) => l, (r) => r);
  }

// Delete Record
  deleteRecord(
    String? record,
  ) async {
    var response =
        await crud.postData(AppLink.deleteReport, {"id": record.toString()});
    print('=============== ReportData Delete Record ID: $record =======');
    print('=============== ReportData Delete Record : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

  //
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

// Delete Report
  deleteReport(
    int? idReport,
  ) async {
    var response = await crud
        .postAddEditDelete(AppLink.deleteReport, {"id": idReport.toString()});
    print('=============== ReportData DeleteReport ID: $idReport =======');
    print('=============== ReportData DeleteReport : $response ===========');
    return response.fold((l) => l, (r) => r);
  }
}
