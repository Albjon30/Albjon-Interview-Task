import 'package:flutter/material.dart';

/// A typedef that defines a function type for creating dialog options.
///
/// The `DialogOptionBuilder` is a function that returns a `Map<String, T?>`
/// where each entry represents a button inc the dialog. The map's keys are
/// the button labels, and the values are the return values when the
/// respective button is pressed.
///
/// Exp:
/// ```dart
/// DialogOptionBuilder<MyEnum> optionBuilder = () {
///   return {
///     'Option 1': MyEnum.option1,
///     'Cancel': null,
///   };
/// };
/// ```
typedef DialogOptionBuilder<T> = Map<String, T?> Function();

/// Displays a generic dialog with a title, content, and customizable options.
///
/// The [showGenericDialog] function creates a modal dialog that displays a
/// title and content text, and renders a list of buttons based on the
/// [optionBuilder]. Each button returns a specific value when pressed, or
/// closes the dialog with no value if the button's value is `null`.
///
/// This function is generic, allowing you to specify the type [T] of the
/// returned value. It is useful for creating customizable dialogs without
/// hardcoding the options and values.
///
/// - [context]: The [BuildContext] to display the dialog in.
/// - [title]: The title text displayed at the top of the dialog.
/// - [content]: The content text displayed in the main area of the dialog.
/// - [optionBuilder]: A function that returns a map of button labels to values.
///   The dialog will create a button for each key-value pair in the map. When
///   a button is pressed, its value is returned and the dialog is dismissed.
///
/// Exap:
/// ```dart
/// showGenericDialog<MyEnum>(
///   context: context,
///   title: 'Select Option',
///   content: 'Choose an option from below:',
///   optionBuilder: () => {
///     'Option 1': MyEnum.option1,
///     'Option 2': MyEnum.option2,
///     'Cancel': null,
///   },
/// );
/// ```
Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder<T> optionBuilder,
}) {
  final options = optionBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.keys.map((optionTitle) {
          final T? value = options[optionTitle];
          return TextButton(
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(optionTitle),
          );
        }).toList(),
      );
    },
  );
}
