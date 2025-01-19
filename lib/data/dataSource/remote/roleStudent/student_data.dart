// import 'package:fatorty/core/class/crud.dart';

import 'package:flutter/material.dart';
import 'package:school_management/core/class/curd.dart';
import 'package:school_management/linkapi.dart';

class StudentData {
  Crud crud;
  StudentData(this.crud);
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
        '=============== StudentData getDataTeachereStudents : $response ===========');

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
        '=============== StudentData getDataReportTeachereStudents : $response ===========');

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
        '=============== StudentData getDataReportStudentForRoleStudent : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

// Delete Report
  deleteReport(
    int? idReport,
  ) async {
    var response =
        await crud.postData(AppLink.deleteReport, {"id": idReport.toString()});
    print('=============== StudentData DeleteReport ID: $idReport =======');
    print('=============== StudentData DeleteReport : $response ===========');

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
