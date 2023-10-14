import 'package:flutter/material.dart';

class FMMButton extends StatelessWidget {
  const FMMButton({
    super.key,
    this.label,
    this.child,
    Color? backgroundColor,
    required this.onPressed,
  })  : backgroundColor = backgroundColor ?? const Color(0xff6750A4),
        assert(
          label != null || child != null,
          'label ou child precisa ser diferente de null',
        );

  final Widget? child;
  final String? label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          onPressed == null ? Colors.grey.shade600 : backgroundColor,
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        child: child ??
            Text(
              label!,
              style: const TextStyle(color: Colors.white),
            ),
      ),
    );
  }
}
