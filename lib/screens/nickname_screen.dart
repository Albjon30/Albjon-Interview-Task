import 'package:app_task_demo/common/widgets.dart';
import 'package:app_task_demo/routing/routes.dart';
import 'package:app_task_demo/shared_preferences/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NicknameScreen extends StatefulWidget {
  const NicknameScreen({super.key});

  @override
  State<NicknameScreen> createState() => _NicknameScreenState();
}

class _NicknameScreenState extends State<NicknameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadNickname();
  }

  Future<void> _loadNickname() async {
    final nickname = await PreferencesHelper.getNickname();

    setState(() {
      if (nickname != null) {
        _nicknameController.text = nickname;
      }
    });
  }

  String? _validateName() {
    final nickname = _nicknameController.text;

    if (nickname.isEmpty) {
      return 'Please enter a nickname';
    }
    return null;
  }

  Future<void> _saveNickname() async {
    await PreferencesHelper.saveNickname(_nicknameController.text);
  }

  void _onSubmit() {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _errorMessage = _validateName();
    });

    if (_errorMessage == null) {
      _saveNickname(); // Save nickname to SharedPreferences
      context.push(Routes.genderScreen);
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose();
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
                AppLocalizations.of(context).chooseNickname,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20),
              buildDateInputField(
                  controller: _nicknameController,
                  readOnly: false,
                  hintText: AppLocalizations.of(context).nicknameLabel,
                  context: context,
                  maxLength: 25),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _errorMessage!,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Theme.of(context).colorScheme.error),
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
