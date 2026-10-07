import 'package:flutter/material.dart';

class ActivityWeek extends StatelessWidget {
  final List<bool> activeDays;

  const ActivityWeek({
    super.key,
    required this.activeDays,
  });

  @override
  Widget build(BuildContext context) {
    const labels = [
      "M",
      "T",
      "W",
      "T",
      "F",
      "S",
      "S",
    ];

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Text(
            "ACTIVITY",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            "Last 7 days",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: List.generate(
              7,
              (index) {
                final active =
                    index < activeDays.length &&
                    activeDays[index];

                return Column(
                  children: [
                    Text(
                      labels[index],
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    AnimatedContainer(
                      duration:
                          const Duration(
                        milliseconds: 250,
                      ),

                      width: 34,
                      height: 34,

                      decoration: BoxDecoration(
                        color: active
                            ? const Color(
                                0xFF7B61FF,
                              )
                            : const Color(
                                0xFF303030,
                              ),
                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),
                      ),

                      child: Icon(
                        active
                            ? Icons.check
                            : Icons.remove,
                        size: 18,
                        color: active
                            ? Colors.white
                            : Colors.white24,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}