import 'package:school_management/core/class/curd.dart';
import 'package:school_management/linkapi.dart';

class TeacherData {
  Crud crud;
  TeacherData(this.crud);

  // Get Teachers
  getDataTeacheres() async {
    var response = await crud.getData(
      AppLink.getTeachersWithClasses,
    );
    print('=============== Teacher ID: ');
    print('=============== Teacher_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

  //
  getDataNamesTeacheres() async {
    var response = await crud.getData(
      AppLink.getTeachers,
    );
    print('=============== Teacher ID: ');
    print('=============== Teacher_Data Names  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

  //Get Classes
  getDataNamesClasses() async {
    var response = await crud.getData(
      AppLink.getClasses,
    );
    print('=============== Classes ID: ');
    print('=============== Classes Names  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

  //
  // AddTeacher To Class
  addTeacherToClass(String? selectTeacher, String? selectClass) async {
    var response = await crud.postDataAccount(
      AppLink.addTeacherToClass,
      {
        'teacher_id': selectTeacher,
        'class_id': selectClass,
      },
    );
    print(
        '===============AddTeacher selectedTeacher ID  : $selectTeacher ===========');
    print(
        '===============AddTeacherselectedClass ID  : $selectClass ===========');
    print(
        '===============Add Teacher To Class Teacher_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

  // DeleteTeacher
  deleteTeacher(int? teacherId) async {
    var response = await crud.postDataAccount(
        AppLink.deleteTeacherFromClass, {'id': teacherId.toString()});
    print(
        '===============DeleteTeacher Teacher_Data ID  : $teacherId ===========');
    print('===============DeleteTeacher Teacher_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }
}
