import 'package:app_task_demo/common/widgets.dart';
import 'package:app_task_demo/routing/routes.dart';
import 'package:app_task_demo/shared_preferences/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  BirthdayScreenState createState() => BirthdayScreenState();
}

class BirthdayScreenState extends State<BirthdayScreen> {
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

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    if (_yearController.text.isNotEmpty &&
        _monthController.text.isNotEmpty &&
        _dayController.text.isNotEmpty) {
      try {
        initialDate = DateTime(
          int.parse(_yearController.text),
          int.parse(_monthController.text),
          int.parse(_dayController.text),
        );

        // Ensure the i nitial date does not exceedd the last date
        if (initialDate.isAfter(DateTime.now())) {
          initialDate = DateTime.now();
        }
      } catch (e) {
        initialDate = DateTime.now();
      }
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.purple,
              onPrimary: Colors.white,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dayController.text = picked.day.toString().padLeft(2, '0');
        _monthController.text = picked.month.toString().padLeft(2, '0');
        _yearController.text = picked.year.toString();
      });
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
              Text(
                AppLocalizations.of(context).birthdayQuestion,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildDateInputField(
                          label: AppLocalizations.of(context).day,
                          controller: _dayController,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).nextFocus();
                          },
                          textInputAction: TextInputAction.next,
                          hintText: 'DD',
                          readOnly: false,
                          maxLength: 2,
                          context: context),
                      const SizedBox(width: 10),
                      buildDateInputField(
                          label: AppLocalizations.of(context).month,
                          controller: _monthController,
                          hintText: 'MM',
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).nextFocus();
                          },
                          readOnly: false,
                          maxLength: 2,
                          context: context),
                      const SizedBox(width: 10),
                      buildDateInputField(
                          label: AppLocalizations.of(context).year,
                          controller: _yearController,
                          textInputAction: TextInputAction.done,
                          hintText: 'YYYY',
                          readOnly: false,
                          maxLength: 4,
                          context: context),
                    ],
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        _errorMessage!,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      width: 190,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Theme.of(context).colorScheme.outline),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            AppLocalizations.of(context).chooseDate,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
