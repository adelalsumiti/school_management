import 'package:school_management/core/class/curd.dart';
import 'package:school_management/linkapi.dart';

class StudentsData {
  Crud crud;
  StudentsData(this.crud);
//

  // Get Students
  getDataStudents() async {
    var response = await crud.getData(
      AppLink.getStudents,
    );
    print('=============== Students ID: ');
    print('=============== Students_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }
  //

  // Get Classes
  getDataSClasses() async {
    var response = await crud.getData(
      AppLink.getClasses,
    );
    print('=============== Classes ID: ');
    print('=============== Classes Responde  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

//
  // Get StudentsWithClassesData
  getDataStudentsWithClasses() async {
    var response = await crud.getData(
      AppLink.getStudentsWithClasses,
    );
    print('=============== Students ID: ');
    print('=============== Students_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

  // Add Student To Class
  addStudentToClass(
    String? selectedStudent,
    String? selectedClass,
  ) async {
    var response = await crud.postAddEditDelete(AppLink.addStudentToClass, {
      'student_id': selectedStudent,
      'class_id': selectedClass,
    });
    print(
        '===============Add StudentTo Class selected_Class ID  : $selectedClass ===========');

    print(
        '===============Add StudentTo Class selected_Student ID  : $selectedStudent ===========');
    print(
        '===============Add Student __ Student_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

//
  // Edit Student
  editStudent(
    String? nameController,
    String? studentId,
  ) async {
    var response = await crud.postAddEditDelete(
        AppLink.editClass, {'id': studentId, 'className': nameController});
    print(
        '===============AddStudent nameController ==>  : $nameController ===========');
    print(
        '===============AddStudent student_Id ID ==> : $studentId ===========');
    print(
        '===============Add Student __ Student_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }

//
  // Delete Student
  deleteStudent(String studentId) async {
    var response =
        await crud.postAddEditDelete(AppLink.deleteStudent, {'id': studentId});
    print(
        '=============== Student_Data__Delete_Student  ID  : $studentId ===========');
    print(
        '===============Delete_Student Student_Data  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }
}
