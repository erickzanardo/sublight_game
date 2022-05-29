import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  const Gap._({super.key, required this.value});

  const Gap.verticalSmall({Key? key})
      : this._(
          key: key,
          value: const Offset(0, 8),
        );

  const Gap.verticalMedium({Key? key})
      : this._(
          key: key,
          value: const Offset(0, 16),
        );

  const Gap.verticalBig({Key? key})
      : this._(
          key: key,
          value: const Offset(0, 32),
        );

  const Gap.horizontalSmall({Key? key})
      : this._(
          key: key,
          value: const Offset(8, 0),
        );

  const Gap.horizontalMedium({Key? key})
      : this._(
          key: key,
          value: const Offset(16, 0),
        );

  const Gap.horizontalBig({Key? key})
      : this._(
          key: key,
          value: const Offset(32, 0),
        );

  final Offset value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: value.dx, height: value.dy);
  }
}
