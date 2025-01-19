// import 'package:school_management/core/class/statusrequest.dart';
// import 'package:school_management/core/funcations/multidialog.dart';

// ////  [response] the data status is get from server.
// ///
// ////  [operation] take four operatopn (add,edit,delete,view).
// ///
// ////  [page] enter page route name examples (customer,item,color,size,invoice ...enc).
// ///
// ////  (success) return [StatusResponse.success] when success.
// ///
// ////   (failure) return [StatusResponse.exists]  when (error) is (exists ) using for operation add,edit,delete.
// ///
// ////   (failure) return [StatusResponse.hasrefrences]  when (error) is (hasrefrences ) using for operation add,edit,delete.
// ///
// ////   (failure) return [StatusResponse.emptychange]  when (error) is (empty) using for operation add,edit,delete.
// ///
// ////   (failure) return [StatusResponse.emptyshow]  when (error) is (empty) using for operation view.
// ///
// ////   (failure) return [StatusResponse.unknown]  when (error) is unKnown.

// Future<StatusResponse> checkResponseStatus(
//     {required dynamic response,
//     required dynamic operation,
//     dynamic page = "Info"}) async {
//   if (response['status'] == "success") {
//     return StatusResponse.success;
//   } else if (response['status'] == "failure" && response['error'] == "exists") {
//     await showDialogNameExists();
//     return StatusResponse.exists;
//   } else if (response['status'] == "failure" &&
//       response['error'] == "hasrefrences") {
//     await showDialogCanNotDelete(page);

//     return StatusResponse.hasrefrences;
//   } else if (response['status'] == "failure" && response['error'] == "empty") {
//     if (operation == "add") {
//       await showDialogErrorOnAdd(response["message"]);
//       return StatusResponse.emptychange;
//     } else if (operation == "edit") {
//       await showDialogErrorOnAdd(response["message"]);
//       return StatusResponse.emptychange;
//     } else if (operation == "delete") {
//       await showDialogErrorOnAdd(response["message"]);
//       return StatusResponse.emptychange;
//     } else if (operation == "view") {
//       return StatusResponse.emptyshow;
//     } else {
//       return StatusResponse.unknown;
//     }
//   } else {
//     return StatusResponse.unknown;
//   }
// }
