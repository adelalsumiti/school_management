// // ignore_for_file: must_be_immutable

// import 'package:adminkingfashion/core/constant/alldatafromsql.dart';
// import 'package:adminkingfashion/data/model/colormodel.dart';
// import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:flutter/material.dart';

// class CustomDropDownTextFieldSearchColor extends StatelessWidget {
//   CustomDropDownTextFieldSearchColor(
//       {super.key,
//       this.onChanged,
//       this.searchController2,
//       this.validator,
//       this.typeSearch});
//   int? typeSearch;
//   Function(dynamic)? onChanged;
//   String? Function(String?)? validator;
//   TextEditingController searchController = TextEditingController(text: "");
//   SingleValueDropDownController? searchController2;
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
//         child: FutureBuilder<List<ColorModel>>(
//             future: Future(() => getAllColorsFromShared()),
//             builder: (context, snapshot) {
//               return snapshot.hasData
//                   ? DropDownTextField(
//                       searchFocusNode: searchFocusNode,
//                       textFieldFocusNode: textFieldFocusNode,
//                       // initialValue: "name4",
//                       searchAutofocus: true,

//                       textFieldDecoration:
//                           const InputDecoration(hintText: "Select Color"),

//                       controller: searchController2,
//                       clearOption: false,
//                       enableSearch: true,
//                       searchKeyboardType: TextInputType.text,

//                       dropdownColor: Colors.white,
//                       listTextStyle: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold),
//                       searchDecoration:
//                           const InputDecoration(hintText: "Select Color"),
//                       validator: validator,
//                       dropDownItemCount: 10,

//                       listPadding: ListPadding(bottom: 10, top: 10),
//                       dropDownList: List<DropDownValueModel>.generate(
//                           snapshot.data!.length, (index) {
//                         ColorModel color = snapshot.data![index];

//                         return DropDownValueModel(
//                             name: color.name,
//                             //snapshot.data![index].name!,
//                             value: color);
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
