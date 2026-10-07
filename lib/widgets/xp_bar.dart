import 'package:flutter/material.dart';

class XPBar extends StatelessWidget {
  final double progress;

  const XPBar({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 12,
        backgroundColor: Colors.grey.shade800,
        valueColor: const AlwaysStoppedAnimation(
          Color(0xFF7B61FF),
        ),
      ),
    );
  }
}