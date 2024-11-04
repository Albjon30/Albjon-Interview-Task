import 'package:app_task_demo/common/widgets.dart';
import 'package:app_task_demo/routing/go_route.dart';
import 'package:app_task_demo/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NicknameScreen extends StatelessWidget {
  const NicknameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose your\nnickname",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            buildDateInputField(
              value: "John Smith",
              readOnly: false,
            ),
          ],
        ),
        const FloatingButton(
          routeRedirection: Routes.genderScreen,
        ),
      ],
    );
  }
}
