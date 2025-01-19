// ignore: depend_on_referenced_packages
import 'package:school_management/core/class/curd.dart';

import 'package:get/get.dart';
import 'package:school_management/core/services/report_Service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(ReportService());
  }
}
