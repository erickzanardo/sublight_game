import 'package:flame/components.dart';
import 'package:flame_stellaris/flame_stellaris.dart';

class StellarisBackground extends PositionComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    positionType = PositionType.widget;
    const stellaris = FlatStellarisGenerator();
    await add(
      stellaris.generateStarryBackground(
        size: (gameRef.size * 1.5)..round(),
      ),
    );
  }

  @override
  void update(double dt) {
    position = -gameRef.camera.position * 0.08;
  }
}
