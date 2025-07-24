import 'package:flutter/material.dart';

class VerticalStepProgressView extends StatelessWidget {
  final int curStep;
  final List<String> steps;
  final Color activeColor;
  final Color inactiveColor;
  final double lineHeight;

  const VerticalStepProgressView({
    super.key,
    required this.curStep,
    required this.steps,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.lineHeight = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(steps.length, (index) {
        bool isActive = index <= curStep;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isActive ? activeColor : inactiveColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
                if (index != steps.length - 1)
                  Container(
                    width: 2,
                    height: lineHeight,
                    color: isActive ? activeColor : inactiveColor,
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 2, bottom: 8),
                child: Text(
                  steps[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isActive ? activeColor : inactiveColor,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
