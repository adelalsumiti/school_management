// // import 'package:school_management/view/controller/invoices/addeditinvoices_controller.dart';
// // import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
// // import 'package:school_management/data/model/invoicemodel.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// // ignore: must_be_immutable
// class CustomTableDetails extends StatelessWidget {
//   int countColumn;
//   CustomTableDetails({super.key, required this.countColumn});
//   @override
//   Widget build(BuildContext context) {
//     // Get.put(AddEditInvoiceControllerImp());
//  1   return GetBuilder<AddEditInvoiceControllerImp>(builder: (controller) {
//       return Container(
//         margin: const EdgeInsets.only(top: 20),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: DataTable(
//             border: TableBorder.all(),
//             showBottomBorder: true,
//             showCheckboxColumn: true,
//             columns: List.generate(countColumn, (index) {
//               return DataColumn(
//                 label: Text(
//                   "242".tr,
//                   style: const TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               );
//             }),
//             rows: List.generate(controller.invoiceModel.bills!.length, (index) {
//               InvoiceBillsModel bill = controller.invoiceModel.bills![index];
//               return DataRow(
//                 cells: [
//                   DataCell(
//                     Text(
//                       "${index + 1}",
//                       style: const TextStyle(
//                           fontSize: 13, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   DataCell(
//                     Text(
//                       bill.itmName,
//                       style: const TextStyle(
//                           fontSize: 13, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   DataCell(
//                     Text(
//                       bill.clrName,
//                       style: const TextStyle(
//                           fontSize: 13, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   DataCell(
//                     Text(
//                       bill.sizeName,
//                       style: const TextStyle(
//                           fontSize: 13, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   DataCell(
//                     Text(
//                       bill.qty ?? "0",
//                       style: const TextStyle(
//                           fontSize: 13, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   DataCell(
//                     Text(
//                       bill.price ?? "0",
//                       style: const TextStyle(
//                           fontSize: 13, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   DataCell(
//                     Text(
//                       bill.descount ?? "0",
//                       style: const TextStyle(
//                           fontSize: 13, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   DataCell(
//                     Text(
//                       ((double.parse(bill.qty ?? "0") -
//                                   double.parse(bill.descount ?? "0")) *
//                               double.parse(bill.price ?? "0"))
//                           .toString(),
//                       style: const TextStyle(
//                           fontSize: 13, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               );
//             }),
//           ),
//         ),
//       );
//     });
//   }
// }
