import 'package:app_task_demo/common/widgets.dart';
import 'package:app_task_demo/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  _BirthdayScreenState createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "When’s your\n birthday?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildDateInputField(
                  label: "Day",
                  value: selectedDate.day.toString(),
                  readOnly: false,
                ),
                const SizedBox(width: 20),
                buildDateInputField(
                  label: "Month",
                  value: selectedDate.month.toString(),
                  readOnly: false,
                ),
                const SizedBox(width: 20),
                buildDateInputField(
                  label: "Year",
                  value: selectedDate.year.toString(),
                  readOnly: false,
                ),
              ],
            ),
          ],
        ),
        const FloatingButton(
          routeRedirection: Routes.nicknameScreen,
        ),
      ],
    );
  }
}


