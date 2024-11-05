import 'package:app_task_demo/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Add a nice photo\nof yourself",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              context.push(Routes.cameraScreen);
            },
            child: const Text(
              "Take your first photo",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: Colors.white.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Make sure that your image",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              buildGuidelineText("✔ Shows your face clearly"),
              buildGuidelineText("✔ Yourself only, no group pic"),
              buildGuidelineText("✔ No fake pic, object or someone else"),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildGuidelineText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
