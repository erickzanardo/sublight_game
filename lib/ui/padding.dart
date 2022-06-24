import 'package:flutter/material.dart';

class SublightPadding extends Padding {
  const SublightPadding({
    required super.padding,
    super.key,
  });

  const SublightPadding.horizontalSmall({super.key, super.child})
      : super(
          padding: const EdgeInsets.symmetric(horizontal: 8),
        );

  const SublightPadding.horizontalMedium({super.key, super.child})
      : super(
          padding: const EdgeInsets.symmetric(horizontal: 16),
        );

  const SublightPadding.horizontalBig({super.key, super.child})
      : super(
          padding: const EdgeInsets.symmetric(horizontal: 32),
        );

  const SublightPadding.verticalSmall({super.key, super.child})
      : super(
          padding: const EdgeInsets.symmetric(vertical: 8),
        );

  const SublightPadding.verticalMedium({super.key, super.child})
      : super(
          padding: const EdgeInsets.symmetric(vertical: 16),
        );

  const SublightPadding.verticalBig({super.key, super.child})
      : super(
          padding: const EdgeInsets.symmetric(vertical: 32),
        );
}
