import 'package:school_management/core/class/curd.dart';
import 'package:school_management/linkapi.dart';

class FathersData {
  Crud crud;
  FathersData(this.crud);

//
// Get FathersWithStudent
  getDataRelationships() async {
    var response = await crud.getData(
      AppLink.getParentStudentRelationships,
    );
    print('=============== Fathers ID: ');
    print('=============== Fathers_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

//
  // Get FathersWithStudent
  getDataFathersWithStudents() async {
    var response = await crud.getData(
      AppLink.getParentsAndStudents,
    );
    print('=============== Fathers ID: ');
    print('=============== Fathers_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

  // Add Father To Student
  addFatherToStudent(
    String? selectedStudent,
    String? selectedFather,
  ) async {
    var response = await crud.postAddEditDelete(AppLink.saveParentStudent, {
      'parent_id': selectedFather,
      'student_id': selectedStudent,
    });
    print(
        '===============Add Father TO Student selectedFather ID  : $selectedFather ===========');

    print(
        '===============Add Father To Student selected_Student ID  : $selectedStudent ===========');
    print(
        '===============Add Father To Student __ Student_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

//
  // Edit Father
  editFather(
    String? nameController,
    String? studentId,
  ) async {
    var response = await crud.postAddEditDelete(
        AppLink.editClass, {'id': studentId, 'className': nameController});
    print(
        '===============AddFather nameController ==>  : $nameController ===========');
    print(
        '===============AddFather student_Id ID ==> : $studentId ===========');
    print('===============Add Father __ Father_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

//
  // Delete Father
  deleteFather(String fatherId) async {
    var response = await crud
        .postAddEditDelete(AppLink.deleteParentFromStudent, {'id': fatherId});
    print(
        '=============== Father_Data__Delete_Father  ID  : $fatherId ===========');
    print('===============Delete_Father Father_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }
}
