// // ignore_for_file: must_be_immutable

// import 'package:adminkingfashion/core/constant/alldatafromsql.dart';
// import 'package:adminkingfashion/data/model/sizemodel.dart';
// import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:flutter/material.dart';

// class CustomDropDownTextFieldSearchSize extends StatelessWidget {
//   CustomDropDownTextFieldSearchSize(
//       {super.key,
//       this.onChanged,
//       this.searchController2,
//       this.validator,
//       this.typeSearch});
//   int? typeSearch;
//   Function(dynamic)? onChanged;
//   String? Function(String?)? validator;
//   TextEditingController searchController = TextEditingController(text: "");
//   MultiValueDropDownController? searchController2;
//   FocusNode searchFocusNode = FocusNode();
//   FocusNode textFieldFocusNode = FocusNode();
//   // String? searchName;
//   // String? searchID;

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
//         decoration: BoxDecoration(
//             color: Colors.grey.shade300,
//             borderRadius: BorderRadius.circular(20)),
//         child: FutureBuilder<List<SizeModel>>(
//             future: Future(() => getAllSizesFromShared()),
//             builder: (context, snapshot) {
//               return snapshot.hasData
//                   ? DropDownTextField.multiSelection(
//                       displayCompleteItem: true,
//                       submitButtonText: "OK",

//                       searchFocusNode: searchFocusNode,
//                       textFieldFocusNode: textFieldFocusNode,
//                       // initialValue: "name4",
//                       // searchAutofocus: true,

//                       textFieldDecoration:
//                           const InputDecoration(hintText: "Select Sizes"),

//                       controller: searchController2,
//                       // clearOption: false,
//                       // enableSearch: false,
//                       // searchKeyboardType: TextInputType.text,

//                       dropdownColor: Colors.white,
//                       listTextStyle: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           height: 1),
//                       // searchDecoration:
//                       //     const InputDecoration(hintText: "Select Sizes"),
//                       validator: validator,
//                       dropDownItemCount: 10,
//                       padding: const EdgeInsets.all(10),
//                       listPadding: ListPadding(
//                         bottom: 10,
//                         top: 10,
//                       ),
//                       dropDownList: List<DropDownValueModel>.generate(
//                           snapshot.data!.length, (index) {
//                         SizeModel size = snapshot.data![index];

//                         return DropDownValueModel(
//                             name: size.name,
//                             //snapshot.data![index].name!,
//                             value: size);
//                       }),
//                       onChanged: onChanged,
//                     )
//                   : DropDownTextField(
//                       // initialValue: "name4",
//                       // controller: searchController2,
//                       clearOption: true,
//                       enableSearch: true,
//                       // dropdownColor: Colors.green,
//                       searchDecoration: const InputDecoration(
//                           hintText: "لايوجد حسابات يؤجى اضافة حسابات اولا"),
//                       validator: (value) {
//                         if (value == null || value == "name1" || value == "") {
//                           return "Required field";
//                         } else {
//                           return null;
//                         }
//                       },
//                       dropDownItemCount: 6,

//                       dropDownList: const [
//                         DropDownValueModel(name: 'name1', value: "value1"),
//                       ],
//                       onChanged: (val) {},
//                     );
//             }),
//       ),
//     );
//   }
// }
