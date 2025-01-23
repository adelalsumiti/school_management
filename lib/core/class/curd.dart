// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:dartz/dartz.dart';

// import 'package:http/http.dart' as http;
// import 'package:school_management/core/constant/colors.dart';
// import 'package:school_management/core/funcations/checkinternet.dart';
// import 'package:school_management/core/funcations/multidialog.dart';
// import 'package:school_management/core/funcations/showsmartdialog.dart';
// import 'package:school_management/core/funcations/translatefatabase.dart';
// import 'statusrequest.dart';
// import 'package:retry/retry.dart';
// // import 'package:school_management/core/class/statusrequest.dart';
// // import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;
// import 'package:path/path.dart';

// // class Crud {
// //   Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
// //     try {
// //       // print("=data========$data===================");
// //       if (await checkInternet()) {
// //         var response = await http.post(Uri.parse(linkurl), body: data);
// //         print(
// //             "=response.statusCode========${response.statusCode}===================");
// //         print("=response.body========${response.body}===================");

// //         if (response.statusCode == 200 || response.statusCode == 201) {
// //           Map responsebody = jsonDecode(response.body);
// //           return Right(responsebody);
// //         } else {
// //           return const Left(StatusRequest.serverfailure);
// //         }
// //       } else {
// //         return const Left(StatusRequest.offlinefailure);
// //       }
// //     } catch (_) {
// //       print("=catch========$_===================");

// //       return const Left(StatusRequest.serverfailure);
// //     }
// //   }
// // }

// //

// //
// //
// // String _basicAuth =
// //     'Basic ${base64Encode(utf8.encode('kingcityshop:kingcityshopfares773555099'
// //         // 'kingcityshop:kingcityshopfares773555099',
// //         ))}';
// String _basicAuth =
//     'Basic ${base64Encode(utf8.encode('u703454372_School:Aden2024#'))}';
// Map<String, String> myheaders = {
//   // "authorization": _basicAuth,
//   "authorization": _basicAuth,
//   // 'Content-Type': 'application/json; charset=UTF-8',
//   // 'Accept': "*/*",
//   // 'connection': 'keep-alive',
//   // 'Accept-Encoding': 'gzip, deflate, br',
// };

// //
// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

// class Crud {
//   bool? allowBack;
//   bool? isShowLoad;
//   Future<Either<StatusRequest, Map>> postData(String linkurl, Map data,
//       {isShowLoad = true, allowBack = true}) async {
//     if (isShowLoad) {
//       showSmartDialogLoading(allowBack);
//     }

//     try {
//       if (await checkInternet()) {
//         print("==postData===============$data===================");

//         final response = await retry(
//           // Make a GET request
//           () => http
//               .post(
//                 Uri.parse(linkurl),
//                 body: data,
//                 headers: myheaders,
//               )
//               .timeout(const Duration(seconds: 15)),
//           // Retry on SocketException or TimeoutException
//           retryIf: (e) =>
//               e is SocketException ||
//               e is TimeoutException ||
//               e is http.ClientException,
//           onRetry: (e) {
//             log("$e", name: 'onRetry');
//           },
//         );
// // print(response.body);
//         // var response = await http.post(
//         //   Uri.parse(linkurl),
//         //   body: data,
//         //   headers: myheaders,
//         // );
//         print(
//             "==statusCode===============${response.statusCode}===================");
//         print("==postData===============${response.body}===================");
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           Map responsebody = jsonDecode(response.body);
//           hideSmartDialog();
//           return Right(responsebody);
//         } else {
//           hideSmartDialog();
//           showDialogErrorOnAdd(response.body);
//           return const Left(StatusRequest.serverfailure);
//         }
//       } else {
//         hideSmartDialog();
//         return const Left(StatusRequest.offlinefailure);
//       }
//     } on http.ClientException {
//       print("==postData===============ClientException===================");
//       Get.rawSnackbar(
//         title: "323".tr,
//         message: translateDatabase("", "324".tr),
//         // backgroundColor: Colors.red.shade300
//         backgroundColor: AppColors.primaryColor,
//       );
//       hideSmartDialog();
//       // showDialogErrorOnAdd(" ClientException \n not connect with Server");
//       return const Left(StatusRequest.serverfailure);
//     } on SocketException {
//       hideSmartDialog();
//       print("==postData===============SocketException===================");

//       // showDialogErrorOnAdd(
//       //     "SocketException \n  not connect with Server because internet low");
//       return const Left(StatusRequest.serverfailure);
//     } catch (e) {
//       hideSmartDialog();
//       print("==postData===============$e===================");

//       if (e is HandshakeException) {
//         showDialogErrorOnAdd("${"325".tr}\n HandshakeException");
//       } else {
//         showDialogErrorOnAdd(e);
//       }
//       return const Left(StatusRequest.serverfailure);
//     }
//   }

//   Future<Either<StatusRequest, Map>> addRequestwithFiles(
//       String linkurl, Map data, File? file,
//       {String? namerequest, isShowLoad = true, allowBack = true}) async {
//     showSmartDialogLoading(allowBack);

//     try {
//       if (await checkInternet()) {
//         print("==postData===============$data===================");

//         namerequest ??= "files";
//         var uri = Uri.parse(linkurl);
//         var request = http.MultipartRequest("POST", uri);
//         request.headers.addAll(myheaders);

//         if (file != null) {
//           var length = await file.length();
//           var stream = http.ByteStream(file.openRead());
//           stream.cast();
//           String name = basename(file.path);
//           name = name.replaceAll(RegExp(r'-'), '');
//           var multipartFile =
//               http.MultipartFile(namerequest, stream, length, filename: name);
//           request.files.add(multipartFile);
//         }

//         // add Data to Request
//         data.forEach((key, value) {
//           request.fields[key] = value;
//         });

//         // send Request
//         var myrequest = await retry(
//           () => request.send(),
//           retryIf: (e) =>
//               e is SocketException ||
//               e is TimeoutException ||
//               e is http.ClientException,
//           onRetry: (e) {
//             log("$e", name: 'onRetry-send-WithFiels');
//           },
//         );
//         // var myrequest = await request.send();

//         // For get Response body
//         // var response = await http.Response.fromStream(myrequest);
//         // if (response.statusCode == 200 || response.statusCode == 201) {
//         //   Map responsebody = jsonDecode(response.body);
//         //   return Right(responsebody);
//         // } else {
//         //   return const Left(StatusRequest.serverfailure);
//         // }
//         var response = await retry(
//           () => http.Response.fromStream(myrequest),
//           retryIf: (e) =>
//               e is SocketException ||
//               e is TimeoutException ||
//               e is http.ClientException,
//           onRetry: (e) {
//             log("$e", name: 'onRetry-send-WithFiels');
//           },
//         );
//         // var response = await http.Response.fromStream(myrequest);
//         print(
//             "==statusCode===============${response.statusCode}===================");
//         print("==postData===============${response.body}===================");
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           Map responsebody = jsonDecode(response.body);
//           hideSmartDialog();
//           return Right(responsebody);
//         } else {
//           hideSmartDialog();
//           showDialogErrorOnAdd(response.body);
//           return const Left(StatusRequest.serverfailure);
//         }
//       } else {
//         hideSmartDialog();

//         return const Left(StatusRequest.offlinefailure);
//       }
//     } catch (e) {
//       print("==catch===============$e===================");
//       hideSmartDialog();
//       showDialogErrorOnAdd(e);
//       return const Left(StatusRequest.serverfailure);
//     }
//   }

//   Future<Either<StatusRequest, Map>> addRequestwithMultiFiles(
//       String linkurl, Map data, File? file, List<File> listFile,
//       {String? namerequest, isShowLoad = true, allowBack = true}) async {
//     showSmartDialogLoading(allowBack);

//     try {
//       if (await checkInternet()) {
//         print("==postData===============$data===================");

//         namerequest ??= "file";
//         var uri = Uri.parse(linkurl);
//         var request = http.MultipartRequest("POST", uri);
//         request.headers.addAll(myheaders);

//         if (file != null) {
//           var length = await file.length();
//           var stream = http.ByteStream(file.openRead());
//           stream.cast();
//           String name = basename(file.path);
//           name = name.replaceAll(RegExp(r'-'), '');
//           var multipartFile =
//               http.MultipartFile(namerequest, stream, length, filename: name);
//           request.files.add(multipartFile);
//         }
//         if (listFile.isNotEmpty) {
//           namerequest = "files";

//           for (int i = 0; i < listFile.length; i++) {
//             File f = listFile[i];
//             var length = await f.length();
//             var stream = http.ByteStream(f.openRead());
//             stream.cast();
//             String name = basename(f.path);
//             name = name.replaceAll(RegExp(r'-'), '');
//             var multipartFile =
//                 http.MultipartFile(namerequest, stream, length, filename: name);

//             request.files.add(multipartFile);
//           }
//         }

//         // add Data to Request
//         data.forEach((key, value) {
//           request.fields[key] = value;
//         });

//         // send Request
//         var myrequest = await retry(
//           () => request.send(),
//           retryIf: (e) =>
//               e is SocketException ||
//               e is TimeoutException ||
//               e is http.ClientException,
//           onRetry: (e) {
//             log("$e", name: 'onRetry-send-WithFiels');
//           },
//         );
//         // var myrequest = await request.send();

//         // For get Response body
//         // var response = await http.Response.fromStream(myrequest);
//         // if (response.statusCode == 200 || response.statusCode == 201) {
//         //   Map responsebody = jsonDecode(response.body);
//         //   return Right(responsebody);
//         // } else {
//         //   return const Left(StatusRequest.serverfailure);
//         // }
//         var response = await retry(
//           () => http.Response.fromStream(myrequest),
//           retryIf: (e) =>
//               e is SocketException ||
//               e is TimeoutException ||
//               e is http.ClientException,
//           onRetry: (e) {
//             log("$e", name: 'onRetry-send-WithMultiFiels');
//           },
//         );
//         // var response = await http.Response.fromStream(myrequest);
//         print(
//             "==statusCode===============${response.statusCode}===================");
//         print("==postData===============${response.body}===================");
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           Map responsebody = jsonDecode(response.body);
//           hideSmartDialog();
//           return Right(responsebody);
//         } else {
//           hideSmartDialog();
//           showDialogErrorOnAdd(response.body);
//           return const Left(StatusRequest.serverfailure);
//         }
//       } else {
//         hideSmartDialog();

//         return const Left(StatusRequest.offlinefailure);
//       }
//     } catch (e) {
//       print("==catch===============$e===================");
//       hideSmartDialog();
//       showDialogErrorOnAdd(e);
//       return const Left(StatusRequest.serverfailure);
//     }
//   }
// }

// //

// //
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:retry/retry.dart';
import 'package:school_management/core/funcations/checkinternet.dart';
import 'package:http/http.dart' as http;
import 'statusrequest.dart';

//
Map<String, String> myheaders = {
  // "authorization": _basicAuth,
  "Content-Type": "application/json"
  // 'Accept': "*/*",
  // 'connection': 'keep-alive',
  // 'Accept-Encoding': 'gzip, deflate, br',
};

//
class Crud {
  bool? allowBack;
  bool? isShowLoad;
  //
  Future<Either<StatusRequest, Map>> postDataAccount(
      String linkurl, Map data) async {
    try {
      // print("=data========$data===================");
      if (await checkInternet()) {
        //

        final response = await retry(
          // Make a POST request
          () => http
              .post(Uri.parse(linkurl), body: data)
              .timeout(const Duration(seconds: 15)),
          // Retry on SocketException or TimeoutException
          retryIf: (e) =>
              e is SocketException ||
              e is TimeoutException ||
              e is http.ClientException,
          onRetry: (e) {
            log("$e", name: 'onRetry');
          },
        );
        print(
            "=response.statusCode========${response.statusCode}===================");
        print("=response.body========${response.body}===================");

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      print("=catch========$_===================");

      return const Left(StatusRequest.serverfailure);
    }
  }

  //
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    try {
      // print("=data========$data===================");
      if (await checkInternet()) {
        //

        final response = await retry(
          // Make a POST request

          () => http
              .post(
                Uri.parse(linkurl),
                body: jsonEncode(data),
                headers: myheaders,
              )
              .timeout(const Duration(seconds: 15)),
          // Retry on SocketException or TimeoutException
          retryIf: (e) =>
              e is SocketException ||
              e is TimeoutException ||
              e is http.ClientException,
          onRetry: (e) {
            log("$e", name: 'onRetry');
          },
        );
        print(
            "=response.statusCode========${response.statusCode}===================");
        print("=response.body========${response.body}===================");

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      print("=catch========$_===================");

      return const Left(StatusRequest.serverfailure);
    }
  }

//  Login

  Future<Either<StatusRequest, Map>> postDataLogin(
      String linkurl, Map data) async {
    try {
      // print("=data========$data===================");
      if (await checkInternet()) {
        //

        final response = await retry(
          // Make a POST request

          () => http.post(Uri.parse(linkurl), body: jsonEncode(data), headers: {
            "Content-Type": "application/json"
          }).timeout(const Duration(seconds: 15)),
          // Retry on SocketException or TimeoutException
          retryIf: (e) =>
              e is SocketException ||
              e is TimeoutException ||
              e is http.ClientException,
          onRetry: (e) {
            log("$e", name: 'onRetry');
          },
        );
        print(
            "=response.statusCode========${response.statusCode}===================");
        print("=response.body========${response.body}===================");

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      print("=catch========$_===================");

      return const Left(StatusRequest.serverfailure);
    }
  }

  // Sign Up
  Future<Either<StatusRequest, Map>> postDataSignUp(
      String linkurl, Map data) async {
    try {
      // print("=data========$data===================");
      if (await checkInternet()) {
        //

        final response = await retry(
          // Make a POST request

          () => http.post(Uri.parse(linkurl),
              body: json.encode(data),
              headers: {
                "Content-Type": "application/json"
              }).timeout(const Duration(seconds: 15)),
          // Retry on SocketException or TimeoutException
          retryIf: (e) =>
              e is SocketException ||
              e is TimeoutException ||
              e is http.ClientException,
          onRetry: (e) {
            log("$e", name: 'onRetry');
          },
        );
        print(
            "=response.statusCode========${response.statusCode}===================");
        print("=response.body========${response.body}===================");

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      print("=catch========$_===================");

      return const Left(StatusRequest.serverfailure);
    }
  }

  //
  Future<Either<StatusRequest, dynamic>> getData(String url) async {
    try {
      if (await checkInternet()) {
        //
        final response = await retry(
          // Make a GET request

          () => http.get(Uri.parse(url)).timeout(const Duration(seconds: 15)),
          // Retry on SocketException or TimeoutException
          retryIf: (e) =>
              e is SocketException ||
              e is TimeoutException ||
              e is http.ClientException,
          onRetry: (e) {
            log("$e", name: 'onRetry');
          },
        );
        // final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          return Right(json.decode(response.body));
        } else {
          // return Left(Failure('Failed with status code: ${response.statusCode}'));
          return const Left(StatusRequest.serverfailure);
        }
      }
      return const Left(StatusRequest.serverfailure);
    } catch (e) {
      // return Left(Failure('Error: $e'));
      return const Left(StatusRequest.serverfailure);
    }
  }

  //
  Future<Either<StatusRequest, Map>> postUploadAudio(
      String linkurl, File file) async {
    try {
      if (await checkInternet()) {
        var request = await retry(
            // Make a POST request
            () => http.MultipartRequest(
                  'POST',
                  Uri.parse(linkurl),
                ),
            // Retry on SocketException or TimeoutException
            retryIf: (e) =>
                e is SocketException ||
                e is TimeoutException ||
                e is http.ClientException,
            onRetry: (e) {
              log("$e", name: 'onRetry');
            });
        request.files.add(await retry(
            () => http.MultipartFile.fromPath(
                  'audio',
                  file.path,
                ),
            retryIf: (e) =>
                e is SocketException ||
                e is TimeoutException ||
                e is http.ClientException,
            onRetry: (e) {
              log("$e", name: 'onRetry');
            }));
        //

        var response = await request.send();

        print(
            "=response.statusCode========${response.statusCode}===================");

        if (response.statusCode == 200) {
          Get.snackbar('نجاح', 'تم رفع الملف بنجاح');
          return const Right({}); // إرجاع Map فارغ أو البيانات التي تريدها
        } else {
          Get.snackbar('خطأ', 'فشل في رفع الملف');
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverfailure);
    }
  }

  //
}

//
