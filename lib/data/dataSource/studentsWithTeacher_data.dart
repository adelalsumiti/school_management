// import 'dart:io';

import 'package:school_management/core/class/curd.dart';
// import 'package:school_management/core/class/statusrequest.dart';
// import 'package:school_management/linkapi.dart';
// import 'package:dartz/dartz.dart';

class StudentsWithTeachersDataRemote {
  Crud crud;
  StudentsWithTeachersDataRemote(this.crud);

  getData(
    int? userId,
  ) async {
    // var response = await crud
    // .postData('${AppLink.fetchTeacherStudents}?teacher_id=$userId' , );
    // return response.fold((l) => l, (r) => r);
  }
//
  // getData(int? userId, Map data) async {
  //   var response =
  //       await crud.postData(AppLink.fetchTeacherStudents = '$userId', data, {});
  //   return response.fold((l) => l, (r) => r);
  // }

  // addData(Map data, File? file) async {
  //   if (file != null) {
  //     var response = await crud.addRequestwithFiles(
  //         AppLink.itemsaddAll, data, file,
  //         allowBack: false);
  //     return response.fold((l) => l, (r) => r);
  //   } else {
  //     var response =
  //         await crud.postData(AppLink.itemsadd, data, allowBack: false);
  //     return response.fold((l) => l, (r) => r);
  //   }
  // }

  // editData(Map data, File? file) async {
  //   // Either<StatusRequest, Map> response;
  //   // response = await crud.postData(AppLink.itemsedit, data);
  //   // return response.fold((l) => l, (r) => r);
  //   if (file != null) {
  //     var response = await crud
  //         .addRequestwithFiles(AppLink.itemsedit, data, file, allowBack: true);
  //     return response.fold((l) => l, (r) => r);
  //   } else {
  //     var response =
  //         await crud.postData(AppLink.itemsedit, data, allowBack: true);
  //     return response.fold((l) => l, (r) => r);
  //   }
  // }

  // editItemImage(Map data, File file) async {
  //   Either<StatusRequest, Map> response =
  //       await crud.addRequestwithFiles(AppLink.itemsEditImage, data, file);
  //   return response.fold((l) => l, (r) => r);
  // }

  // deleteData(Map data) async {
  //   var response = await crud.postData(AppLink.itemsdelete, data);
  //   return response.fold((l) => l, (r) => r);
  // }

  // addItemColorSize(Map data) async {
  //   var response = await crud.postData(AppLink.itemcolorsizeadd, data);
  //   return response.fold((l) => l, (r) => r);
  // }
  // searchData(search)async{
  //    var response = await crud.postData(AppLink.searchitems,{
  //     "search" :search
  //    });
  //    return response.fold((l) => l, (r) => r);
  // }
}
