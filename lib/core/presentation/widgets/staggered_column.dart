import 'package:flutter/material.dart';
import 'fade_in_slide.dart';

/// A Column that automatically wraps its children in a staggered [FadeInSlide] transition.
class StaggeredColumn extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final List<Widget> children;
  final int baseDelayMs;
  final int stepDelayMs;

  const StaggeredColumn({
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    required this.children,
    this.baseDelayMs = 0,
    this.stepDelayMs = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: List.generate(children.length, (index) {
        return FadeInSlide(
          delay: Duration(milliseconds: baseDelayMs + (index * stepDelayMs)),
          child: children[index],
        );
      }),
    );
  }
}
