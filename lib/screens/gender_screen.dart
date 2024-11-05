import 'package:app_task_demo/common/widgets.dart';
import 'package:app_task_demo/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderSelectionScreen extends StatelessWidget {
  const GenderSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).genderQuestion,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 20),
        Text(AppLocalizations.of(context).genderHelperText,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Theme.of(context).colorScheme.outline)),
        const SizedBox(height: 20),
        Column(
          children: [
            buildDateInputField(
                onTap: () {
                  context.push(Routes.addPhotoScreen);
                },
                width: double.infinity,
                value: AppLocalizations.of(context).genderMale,
                readOnly: true,
                context: context),
            const SizedBox(height: 16),
            buildDateInputField(
                onTap: () {
                  context.push(Routes.addPhotoScreen);
                },
                width: double.infinity,
                value: AppLocalizations.of(context).genderFemale,
                readOnly: true,
                context: context),
            const SizedBox(height: 16),
            buildDateInputField(
                onTap: () {
                  context.push(Routes.addPhotoScreen);
                },
                width: double.infinity,
                value: AppLocalizations.of(context).genderOther,
                readOnly: true,
                context: context),
          ],
        ),
      ],
    );
  }
}
