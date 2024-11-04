import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  const FloatingButton({super.key, required this.routeRedirection});

  final String routeRedirection;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          context.push(routeRedirection);
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.arrow_forward, color: Colors.black),
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(
      width: 1,
    ),
  );
}

Widget buildDateInputField({
  Function()? onTap,
  double? width,
  String? label,
  required String value,
  required bool readOnly,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      IntrinsicWidth(
        stepWidth: width ?? 0.0,
        child: TextFormField(
          onTap: onTap,
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.white, fontSize: 16),
            filled: true,
            fillColor: Colors.black.withOpacity(0.1),
            contentPadding: const EdgeInsets.all(20),
            border: outlineInputBorder(),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 20),
          initialValue: value,
          readOnly: readOnly,
          textAlign: TextAlign.center,
        ),
      ),
      if (label != null) ...{
        const SizedBox(height: 5),
        Text(label),
      }
    ],
  );
}
