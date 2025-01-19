import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdownSearch extends StatefulWidget {
  final String? title;
  final String? hint;
  final String submitbutton;
  final IconData? iconData;
  final TextEditingController? selectedName;
  final TextEditingController selectedId;
  final List<SelectedListItem>? dropDownListData;

  const CustomDropdownSearch(
      {super.key,
      this.title,
      required this.selectedName,
      required this.selectedId,
      required this.dropDownListData,
      required this.submitbutton,
      this.hint,
      required this.iconData});

  @override
  State<CustomDropdownSearch> createState() => _CustomDropdownSearchState();
}

class _CustomDropdownSearchState extends State<CustomDropdownSearch> {
  void onTabDropdownList(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.8, // 80% من الشاشة
          minChildSize: 0.3,
          initialChildSize: 0.5, // حجم العرض الأولي
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.title ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  ...?widget.dropDownListData?.map((item) {
                    return ListTile(
                      title: Text(item.name),
                      onTap: () {
                        widget.selectedName?.text = item.name;
                        widget.selectedId.text = item.value.toString();
                        Navigator.pop(context);
                      },
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        widget.submitbutton == ""
                            ? '351'.tr
                            : widget.submitbutton,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
//
//
//
//
  //   DropDownState(
  //     DropDown(
  //       bottomSheetTitle: Text(
  //         widget.title!,
  //         style: const TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 20.0,
  //         ),
  //       ),
  //       submitButtonChild: SingleChildScrollView(
  //         child: ListView(shrinkWrap: true, children: [
  //           Text(
  //             widget.submitbutton == "" ? '351'.tr : widget.submitbutton,
  //             style: const TextStyle(
  //               fontSize: 14,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ]),
  //       ),
  //       data: widget.dropDownListData ?? [],
  //       selectedItems: (List<dynamic> selectedList) {
  //         SelectedListItem selectedListItem = selectedList[0];
  //         widget.selectedName!.text = selectedListItem.name;
  //         widget.selectedId.text = selectedListItem.value.toString();
  //       },
  //     ),
  //     heightOfBottomSheet: MediaQuery.of(context).size.height * 0.6,
  //     // heightOfBottomSheet: Get.height - 20,
  //   ).showModal(context);
  // }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // enabled: true,
      // enableSuggestions: true,
      // scrollController: TrackingScrollController(
      //     initialScrollOffset: 20, keepScrollOffset: true),
      controller: widget.selectedName,
      cursorColor: Colors.black,
      onTap: () {
        FocusScope.of(context).unfocus();
        onTabDropdownList(context);
      },
      decoration: InputDecoration(
        icon: Icon(widget.iconData),
        contentPadding:
            const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
        hintText: widget.selectedName!.text == ""
            ? widget.title
            : widget.selectedName!.text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),

          // borderSide: const BorderSide(
          //   width: 0,
          //   // style: BorderStyle.none,
          // ),
        ),
      ),
    );
  }
}
