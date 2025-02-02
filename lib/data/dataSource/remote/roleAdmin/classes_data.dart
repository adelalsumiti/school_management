import 'package:school_management/core/class/curd.dart';
import 'package:school_management/linkapi.dart';

class ClassData {
  Crud crud;
  ClassData(this.crud);

  // Get Classes
  getDataClasses() async {
    var response = await crud.getData(
      AppLink.getClasses,
    );
    print('=============== Class ID: ');
    print('=============== Classes_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

  // AddClass
  addClass(
    String? classNameController,
  ) async {
    var response = await crud.postAddEditDelete(
        AppLink.addClass, {'className': classNameController});
    print(
        '===============AddClass classNameController ID  : $classNameController ===========');
    print('===============Add Class __ Class_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

//
  // Edit Class
  editClass(
    String? nameController,
    String? classId,
  ) async {
    var response = await crud.postAddEditDelete(
        AppLink.editClass, {'id': classId, 'className': nameController});
    print(
        '===============AddClass nameController ==>  : $nameController ===========');
    print('===============AddClass class_Id ID ==> : $classId ===========');
    print('===============Add Class __ Class_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

//
  // Delete Class
  deleteClass(String classId) async {
    var response =
        await crud.postAddEditDelete(AppLink.deleteClass, {'classId': classId});
    print(
        '=============== Class_Data__Delete_Class  ID  : $classId ===========');
    print('===============Delete_Class Class_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }
}
