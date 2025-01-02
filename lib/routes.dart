import 'package:get/get.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/data/middleware/mymiddleware.dart';
import 'package:school_management/view/screen/admin/accounts/manageAccountsPage.dart';
import 'package:school_management/view/screen/admin/auth/login/loginPage.dart';
import 'package:school_management/view/screen/admin/auth/signUp/signUp.dart';
import 'package:school_management/view/screen/admin/classes/editClassPage.dart';
import 'package:school_management/view/screen/admin/classes/manageClassesPage.dart';
import 'package:school_management/view/screen/admin/fathers/addParentPage.dart';
import 'package:school_management/view/screen/admin/fathers/manageParentsPage.dart';
import 'package:school_management/view/screen/home/homepage.dart';
import 'package:school_management/view/screen/admin/students/addStudentPage.dart';
import 'package:school_management/view/screen/admin/students/editStudentPage.dart';
import 'package:school_management/view/screen/admin/students/manageStudentsPage.dart';
import 'package:school_management/view/screen/student/studentReportsPage.dart';
import 'package:school_management/view/screen/teacher/addReport.dart';
import 'package:school_management/view/screen/teacher/detaileReport.dart';
import 'package:school_management/view/screen/teacher/studentDetailes.dart';
import 'package:school_management/view/screen/teacher/studentPerformance.dart';
import 'package:school_management/view/screen/teacher/teachersStudents.dart';
import 'package:school_management/view/screen/teacher/viewPerformance.dart';
import 'package:school_management/view/screen/admin/teachers/addTeacherPage.dart';
import 'package:school_management/view/screen/admin/teachers/editTeacherPage.dart';
import 'package:school_management/view/screen/admin/teachers/manageTeachers.dart';
import 'package:school_management/view/screen/teacher/teacherDashboardPage.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: "/", page: () => const LoginPage(), middlewares: [MyMiddleWare()]),
  //  // Auth
  GetPage(name: AppRoute.loginPage, page: () => const LoginPage()),
  GetPage(name: AppRoute.signUpPage, page: () => const SignUpPage()),

  //  // Home

  GetPage(
      name: AppRoute.homePage,
      page: () => const HomePage(
          // userData: {},
          )),

  //  // Teacher

  GetPage(name: AppRoute.addTeacherPage, page: () => const AddTeacherPage()),
  GetPage(
      name: AppRoute.editTeacherPage,
      page: () => const EditTeacherPage(
          // teacher: {},
          )),
  GetPage(
      name: AppRoute.manageTeachersPage,
      page: () => const ManageTeachersPage()),

  // =====Account Teacher ======
  GetPage(
      name: AppRoute.teacherDashboardPage,
      page: () => const TeacherDashboardPage()),
  GetPage(
      name: AppRoute.studentDetailesPage,
      page: () => const StudentDetailsPage()),
  GetPage(name: AppRoute.addReportPage, page: () => const AddReportPage()),
  GetPage(name: AppRoute.detailReport, page: () => const DetailReport()),
  GetPage(
      name: AppRoute.manageParentsPage, page: () => const ManageParentsPage()),
  GetPage(name: AppRoute.addParentPage, page: () => const AddParentPage()),
  GetPage(
      name: AppRoute.teacherStudentsPage,
      page: () => const TeacherStudentsPage()),

  //  // Classes ==========

  GetPage(
      name: AppRoute.manageClassesPage, page: () => const ManageClassesPage()),
  GetPage(name: AppRoute.editClassPage, page: () => const EditClassPage()),

  //  // Students ============

  GetPage(
      name: AppRoute.studentPerformancePage,
      page: () => const StudentPerformance()),
  GetPage(
      name: AppRoute.viewPerformancePage, page: () => const ViewPerformance()),
  GetPage(
      name: AppRoute.manageStudentsPage,
      page: () => const ManageStudentsPage()),
  GetPage(name: AppRoute.addStudentPage, page: () => const AddStudentPage()),
  GetPage(name: AppRoute.editStudentPage, page: () => const EditStudentPage()),
  GetPage(
      name: AppRoute.studentReportsPage,
      page: () => const StudentReportsPage()),

  // =====Accounts Page ======

  GetPage(name: AppRoute.manageAccountsPage, page: () => const AccountsPage()),

// ============

  // GetPage(name: AppRoute.login, page: () => const LoginPage()),
  // GetPage(name: AppRoute.login, page: () => const LoginPage()),
  // GetPage(name: AppRoute.login, page: () => const LoginPage()),
  // GetPage(name: AppRoute.login, page: () => const LoginPage()),
  // GetPage(name: AppRoute.login, page: () => const LoginPage()),
  // GetPage(name: AppRoute.login, page: () => const LoginPage()),
  // GetPage(name: AppRoute.login, page: () => const LoginPage()),
  // GetPage(name: AppRoute.login, page: () => const LoginPage()),
  // GetPage(name: AppRoute.login, page: () => const LoginPage()),
];
