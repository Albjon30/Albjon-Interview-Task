import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContentAlignment extends StatelessWidget {
  final Widget child;

  const ContentAlignment({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 100,
          right: 25,
          left: 25,
          bottom: 25,
        ),
        child: child,
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final String image;

  const BackgroundImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            cacheWidth: 1000,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: onPressed,
        backgroundColor: Colors.white,
        child: const Icon(Icons.arrow_forward, color: Colors.black),
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(
      width: 1,
      color: color,
    ),
  );
}

Widget buildDateInputField(
    {TextEditingController? controller,
    FormFieldValidator<String>? validator,
    Function()? onTap,
    int? maxLength,
    double? width,
    String? label,
    String? hintText,
    String? value,
    required bool readOnly,
    required BuildContext context,
    Function(String)? onChanged,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    Function(String)? onFieldSubmitted}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      IntrinsicWidth(
        stepWidth: width ?? 0.0,
        child: TextFormField(
          controller: controller,
          onTap: onTap,
          maxLength: maxLength,
          focusNode: focusNode,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          inputFormatters: [
            LengthLimitingTextInputFormatter(maxLength)
          ], // Limit input to 4 characters
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.white, fontSize: 16),
            filled: true,
            hintText: hintText,
            fillColor: Colors.black.withOpacity(0.1),
            contentPadding: const EdgeInsets.all(20),
            border: outlineInputBorder(
                Theme.of(context).colorScheme.outlineVariant),
            counterText: '', // Hides the counter text below the TextFormField
          ),
          style: Theme.of(context).textTheme.titleMedium,
          initialValue: value,
          readOnly: readOnly,
          textAlign: TextAlign.center,
          validator: validator,
        ),
      ),
      if (label != null) ...{
        const SizedBox(height: 5),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Theme.of(context).colorScheme.outlineVariant),
        ),
      }
    ],
  );
}
