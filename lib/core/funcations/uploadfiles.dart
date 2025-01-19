import 'dart:io';

import 'package:school_management/core/constant/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

imageUplodadCamera() async {
  final XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);

  if (file != null) {
    return File(file.path);
  } else {
    return null;
  }
}

imageUplodadMulti() async {
  final List<XFile> listXFile = await ImagePicker().pickMultiImage();

  if (listXFile.isNotEmpty) {
    List<File> listFile = [];
    listXFile.map((e) {
      listFile.add(File(e.path));
    });

    return listFile;
  } else {
    return [];
  }
}

fileUpload([isSvg = false]) async {
  if (isSvg) {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions:
            isSvg ? ["svg", "SVG"] : ["PNG", "png", "jpg", "jpeg", "gif"]);

    if (result != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  } else {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      print(
          "====xFile.path===========${xFile.path}==============================");
      return File(xFile.path);
    } else {
      return null;
    }
  }
}

showbottomSheet(Function() imageUplodadCamera, Function() fileUpload) {
  Get.bottomSheet(Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "327".tr,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(160),
                      color: AppColors.thirdColor),
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          imageUplodadCamera();
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        )),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(160),
                      color: AppColors.thirdColor),
                  child: IconButton(
                      onPressed: () {
                        fileUpload();
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.photo,
                        color: Colors.white,
                      )),
                ),
              ],
            )
          ],
        ),
      )));
}
