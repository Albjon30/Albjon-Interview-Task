import 'package:app_task_demo/common/widgets.dart';
import 'package:app_task_demo/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GenderSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Which gender do you\nidentify as?",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Your gender helps us find the right\n matches for you.",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            buildDateInputField(
              onTap: () {
                context.push(Routes.addPhotoScreen);
              },
              width: double.infinity,
              value: "Male",
              readOnly: true,
            ),
            const SizedBox(height: 16),
            buildDateInputField(
              onTap: () {
                context.push(Routes.addPhotoScreen);
              },
              width: double.infinity,
              value: "Female",
              readOnly: true,
            ),
            const SizedBox(height: 16),
            buildDateInputField(
              onTap: () {
                context.push(Routes.addPhotoScreen);
              },
              width: double.infinity,
              value: "Other",
              readOnly: true,
            ),
          ],
        ),
      ],
    );
  }
}
