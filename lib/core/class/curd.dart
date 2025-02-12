import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
// import 'package:get/get.dart';
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
  Future<Either<StatusRequest, Map>> postAddEditDelete(
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
  Future<Either<StatusRequest, dynamic>> getPlayAudio(String url) async {
    try {
      if (await checkInternet()) {
        var response = await retry(
          // Make a GET request
          () => http.head(Uri.parse(url)).timeout(const Duration(seconds: 15)),
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
        response is Map<String, dynamic>;

        if (response.statusCode == 200) {
          // return Right(response);
          return Right(await json.decode(response.body));
          // return const Right(StatusRequest.success);
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
  Future<Either<StatusRequest, dynamic>> getData(String url) async {
    try {
      if (await checkInternet()) {
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

  Future<Either<StatusRequest, Map>> postUploadAudio(
      String linkurl, File audioFile, int recordId) async {
    try {
      if (await checkInternet()) {
        final request = await retry(
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
        request.fields['report_id'] = recordId.toString();

        request.files.add(await retry(
            () => http.MultipartFile.fromPath(
                  'audio_note_path',
                  // 'file_path',
                  audioFile.path,
                ),
            retryIf: (e) =>
                e is SocketException ||
                e is TimeoutException ||
                e is http.ClientException,
            onRetry: (e) {
              log("$e", name: 'onRetry');
            }));
        var response = await request.send();
        print(
            "=response.statusCode========${response.statusCode}===================");
        response is Map<String, dynamic>;
        if (response.statusCode == 200) {
          var responseData = await response.stream.bytesToString();
          var jsonResponse = json.decode(responseData);
          // as Map<String, dynamic>;
          return Right(jsonResponse);
        } else {
          // Get.snackbar('خطأ', 'فشل في رفع الملف');
          log("فشل", error: "فشل في رفع الملف الصوتي");
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
  Future<Either<StatusRequest, Map>> postAudioSt(
      String linkurl, File audioFile, int recordId) async {
    try {
      if (await checkInternet()) {
        final request = await retry(
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
        request.fields['report_id'] = recordId.toString();

        request.files.add(await retry(
            () => http.MultipartFile.fromPath(
                  'student_audio_response',

                  // 'audio_note_path',
                  // 'file_path',
                  audioFile.path,
                ),
            retryIf: (e) =>
                e is SocketException ||
                e is TimeoutException ||
                e is http.ClientException,
            onRetry: (e) {
              log("$e", name: 'onRetry');
            }));
        var response = await request.send();
        print(
            "=response.statusCode========${response.statusCode}===================");
        // response is Map<String, dynamic>;
        if (response.statusCode == 200) {
          var responseData = await response.stream.bytesToString();
          var jsonResponse = json.decode(responseData) as Map<String, dynamic>;
          return Right(jsonResponse);
        } else {
          // Get.snackbar('خطأ', 'فشل في رفع الملف');
          log("فشل", error: "فشل في رفع الملف الصوتي");
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
      // }
    } catch (_) {
      return const Left(StatusRequest.serverfailure);
    }
  }

  //
}

//
