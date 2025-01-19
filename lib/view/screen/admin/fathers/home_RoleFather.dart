import 'package:flutter/material.dart';

class HomeRoleFather extends StatelessWidget {
  const HomeRoleFather({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // عرض بيانات الطالب
              },
              child: const Text('عرض بيانات الطالب'),
            ),
          ],
        ),
      ),
    );
  }
}
