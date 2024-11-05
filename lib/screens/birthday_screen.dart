import 'package:app_task_demo/common/widgets.dart';
import 'package:app_task_demo/routing/routes.dart';
import 'package:app_task_demo/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  _BirthdayScreenState createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadSavedDate();
  }

  Future<void> _loadSavedDate() async {
    final date = await PreferencesHelper.getDate();

    setState(() {
      if (date['day'] != null) _dayController.text = date['day']!;
      if (date['month'] != null) _monthController.text = date['month']!;
      if (date['year'] != null) _yearController.text = date['year']!;
    });
  }

  String? _validateDate() {
    final day = int.tryParse(_dayController.text);
    final month = int.tryParse(_monthController.text);
    final year = int.tryParse(_yearController.text);

    if (day == null || month == null || year == null) {
      return 'Please enter a valid date';
    }

    if (day < 1 ||
        day > 31 ||
        month < 1 ||
        month > 12 ||
        year < 1900 ||
        year > DateTime.now().year) {
      return 'Invalid date';
    }

    // Check if the date actually exists
    try {
      DateTime(year, month, day);
    } catch (e) {
      return 'Invalid date';
    }

    return null;
  }

  Future<void> _saveDate() async {
    await PreferencesHelper.saveDate(
        _dayController.text, _monthController.text, _yearController.text);
  }

  void _onSubmit() {
    setState(() {
      _errorMessage = _validateDate();
    });

    if (_errorMessage == null) {
      _saveDate(); // Save date to SharedPreferences
      context.push(Routes.nicknameScreen);
    }
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
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
                    controller: _dayController,
                    hintText: 'DD',
                    readOnly: false,
                    maxLength: 2,
                  ),
                  const SizedBox(width: 20),
                  buildDateInputField(
                    label: "Month",
                    controller: _monthController,
                    readOnly: false,
                    hintText: 'MM',
                    maxLength: 2,
                  ),
                  const SizedBox(width: 20),
                  buildDateInputField(
                    label: "Year",
                    controller: _yearController,
                    readOnly: false,
                    hintText: 'YYYY',
                    maxLength: 4,
                  ),
                ],
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
            ],
          ),
        ),
        FloatingButton(
          onPressed: _onSubmit,
        ),
      ],
    );
  }
}
