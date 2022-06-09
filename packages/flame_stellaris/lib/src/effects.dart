import 'package:flame/components.dart';
import 'package:flame/effects.dart';

/// {@tempate glow_effect}
/// Effect used on the glowing auras of a star.
/// {@endtemplate glow_effect}
class GlowEffect extends ScaleEffect {
  /// {@macro glow_effect}
  GlowEffect(double value, double time)
      : super.by(
          Vector2.all(value),
          InfiniteEffectController(
            SequenceEffectController(
              [
                LinearEffectController(time),
                ReverseLinearEffectController(time),
              ],
            ),
          ),
        );
}
