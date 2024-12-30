//
//
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/linkApi.dart';

class ManageParentsPage extends StatefulWidget {
  const ManageParentsPage({super.key});

  @override
  State<ManageParentsPage> createState() => _ManageParentsPageState();
}

class _ManageParentsPageState extends State<ManageParentsPage> {
  List<dynamic> relationships = [];
  List<dynamic> filteredParents = [];
  List<dynamic> originalParents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRelationships();
  }

  Future<void> fetchRelationships() async {
    isLoading = true;

    final response = await http.get(
      Uri.parse(AppLink.getParentStudentRelationships),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        setState(() {
          relationships = data['relationships'];
          filteredParents = relationships;
          originalParents = filteredParents;
          isLoading = false;
          log("$relationships", name: 'relationships');
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${data['message']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('خطأ أثناء جلب البيانات')),
      );
    }
  }
  //

  /// تصفية قائمة ولي الأمرين بناءً على النص المدخل
  void _filterParents(String query) async {
    setState(() {
      if (query.isEmpty) {
        // إذا كان النص فارغًا، عرض القائمة الأصلية
        filteredParents = originalParents;
      } else {
        // تصفية ولي الأمرين بناءً على النص المدخل
        filteredParents = originalParents.where((parent) {
          final name = parent['parent_name']?.toLowerCase() ?? '';
          final studentName = parent['student_name']?.toLowerCase() ?? '';
          return name.contains(query.toLowerCase()) ||
              studentName.contains(query.toLowerCase());
        }).toList();
      }
    });
  }
  //

  Future<void> deleteParint(parentId) async {
    final response = await http.post(
      Uri.parse(AppLink.deleteParentFromStudent),
      body: {'id': parentId.toString()},
    );
    final data = json.decode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data['message'])),
    );
    fetchRelationships();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoute.addParentPage);
        },
        backgroundColor: AppColors.backgroundIDsColor,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('أولياء الأمور والطلاب'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // إعادة بناء الصفحة

              setState(() {
                fetchRelationships();
              });
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : relationships.isEmpty
              ? const Center(child: Text('لا توجد بيانات حالياً'))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child:
                              // حقل البحث
                              Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'ابحث عن ولي أمر...',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onTap: () {
                                _filterParents;
                              },
                              onChanged:
                                  _filterParents, // تنفيذ التصفية عند تغيير النص
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 55,
                            margin: const EdgeInsets.only(right: 10, left: 10),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border(
                                bottom: BorderSide(color: Colors.black45),
                                left: BorderSide(color: Colors.black45),
                                right: BorderSide(color: Colors.black45),
                                top: BorderSide(color: Colors.black45),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'عدد أولياء الأمور: ${originalParents.length}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredParents.length,
                        itemBuilder: (context, index) {
                          final relationship = filteredParents[index];
                          return ListTile(
                            leading: const Icon(Icons.family_restroom),
                            title: Text(
                                'ولي الأمر: ${relationship['parent_name']}'), // اسم ولي الأمر
                            subtitle:
                                Text('الطالب: ${relationship['student_name']}'),
                            trailing: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(spreadRadius: 0.5, blurRadius: 4)
                                  ],
                                  color: Color.fromARGB(248, 255, 255, 255),
                                  border: Border.symmetric(
                                      horizontal: BorderSide(),
                                      vertical: BorderSide())),
                              child: IconButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                        title: 'تأكيد الحذف',
                                        titlePadding: const EdgeInsets.only(
                                            right: 10,
                                            left: 100,
                                            top: 20,
                                            bottom: 20),
                                        textConfirm: "حذف",
                                        content: const Text(
                                          "هل تريد بالتأكيد حذف ولي الأمر هذا ؟",
                                          style: TextStyle(
                                              color: AppColors.actionColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        cancel: TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text(
                                              "الغاء",
                                              style: TextStyle(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        confirm: MaterialButton(
                                          onPressed: () {
                                            Get.back();
                                            deleteParint(relationship['id']);
                                          },
                                          child: const Text(
                                            "حذف",
                                            style: TextStyle(
                                                color: AppColors.actionColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ));
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColors.actionColor,
                                  )),
                            ), // اسم الطالب
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
