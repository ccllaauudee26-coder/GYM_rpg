import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class LocationSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const LocationSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const locations = [
      "HOME",
      "GYM",
      "BOTH",
    ];

    return Row(
      children: locations.map((location) {
        final bool isSelected =
            selected == location;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: location == locations.last
                  ? 0
                  : AppSpacing.sm,
            ),
            child: GestureDetector(
              onTap: () {
                onChanged(location);
              },
              child: AnimatedContainer(
                duration:
                    const Duration(milliseconds: 180),
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.surface,
                  borderRadius:
                      BorderRadius.circular(
                    AppSpacing.radiusMedium,
                  ),
                ),
                child: Text(
                  location,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: isSelected
                        ? FontWeight.w800
                        : FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}