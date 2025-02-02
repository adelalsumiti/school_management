import 'dart:developer';
import 'package:get/get.dart';
import 'package:school_management/core/class/statusrequest.dart';
import 'package:school_management/core/funcations/handlinfdatacontroller.dart';
import 'package:school_management/core/services/report_Service.dart';
import 'package:school_management/data/dataSource/remote/home/home_data.dart';
import 'package:school_management/data/model/report_Model.dart';
// import 'package:school_management/core/services/services.dart';
// import 'package:school_management/data/dataSource/studentsWithTeacher_data.dart';
import 'package:school_management/data/model/teacherStudentModel.dart';
// import 'package:school_management/linkapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

abstract class RoleTeachersController extends GetxController {
  getStudents();
  initialData();
}

class RoleTeachersControllerImp extends RoleTeachersController {
  HomeData homeData = HomeData(Get.find());
  ReportService reportService = Get.find();
  late SharedPreferences prefs;
  late StatusRequest statusRequest;

  // MyServices myServices = Get.find();
  // List<CategoriesModel> categories = [];
  List<TeacherStudentModel> teacherStudentdata = [];
  // late Future<List<Map<String, dynamic>>> teacherStudents;
  List<dynamic> teacherStudents = [];
  List<dynamic> responsev = [];
  bool isLoading = true;
  int? userId;
  int? studentId;
  int? classId;
  ReportModel reportModel = ReportModel();

  @override
  getStudents() async {
    statusRequest = StatusRequest.loading;
    // try {
    update();
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt("id");
    var response = await homeData.getDataTeachereStudents(userId);
    statusRequest = await handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (await response['success']) {
        response is Map<String, dynamic>;
        teacherStudents = await response['data'];
        update();
        log("studentId", error: studentId);
        print('Data received teacherStudents: $teacherStudents');
      } else {
        statusRequest = StatusRequest.failure;
        throw Exception(await response['message']);
      }
    }
    // } catch (e) {
    //   throw Exception('Not Found Internet PlZ Connect The Internet $e ');
    // }
  }

  //

  @override
  void onInit() async {
    statusRequest = StatusRequest.none;
    super.onInit();
    initialData();
    isLoading;
  }

  @override
  initialData() {
    statusRequest = StatusRequest.none;
    getStudents();
  }

  //
}
