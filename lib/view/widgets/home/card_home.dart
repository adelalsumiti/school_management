import 'package:get/get.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {
  final void Function()? onTap;
  final String? url;
  final String? title;

  const CardHome(
      {super.key, required this.onTap, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.only(
          right: 2,
          left: 4,
          // bottom: 10,
        ),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            boxShadow: const [
              BoxShadow(blurRadius: 1, spreadRadius: 1, color: AppColors.black)
            ],
            borderRadius: BorderRadius.circular(25)),
        // child: Card(
        // margin: const EdgeInsets.only(
        //   right: 2,
        //   left: 4,
        //   bottom: 10,
        // ),

        //   // shape: Border.all(strokeAlign: 3, width: 0.1 , ),
        //   color: AppColors.primaryColor,
        //   elevation: 20,
        //   shadowColor: AppColors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 6,
            ),
            url != null
                ? url!.endsWith('.svg')
                    ? Expanded(
                        flex: 2,
                        child: Image.asset(
                          url!,
                          width: 80,
                        ))
                    : Expanded(
                        flex: 1,
                        child: Image.asset(
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.contain,
                          url!,
                          height: Get.width - Get.height - 25,
                        ))
                : Container(),
            // SizedBox(height: 10,),
            Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(
                      right: 3, left: 3, top: 10, bottom: 10),
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 0, bottom: 12),
                  child: Center(
                    child: Text(
                      title!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ),
                ))
          ],
        ),
      ),
      // ),
    );
  }
}
