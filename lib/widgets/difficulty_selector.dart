import 'package:flutter/material.dart';

class DifficultySelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const DifficultySelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const difficulties = [
      "ALL",
      "Beginner",
      "Intermediate",
      "Advanced",
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: difficulties.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final difficulty =
              difficulties[index];

          final bool isSelected =
              selected == difficulty;

          return GestureDetector(
            onTap: () {
              onChanged(difficulty);
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF7B61FF)
                    : const Color(0xFF1E1E1E),
                borderRadius:
                    BorderRadius.circular(14),
              ),
              child: Text(
                difficulty,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: isSelected
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}