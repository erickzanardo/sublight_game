import 'package:sublight_game/game/models/models.dart';

enum ShipModule {
  bridge(ShipModifier.noEffects()),
  livingQuarters(ShipModifier(space: 20, sblSpeed: 0, impulseSpeed: 0)),
  sblDriver(ShipModifier(space: 0, sblSpeed: 0.1, impulseSpeed: 0)),
  impulseDriver(ShipModifier(space: 0, sblSpeed: 0, impulseSpeed: 0.2));

  const ShipModule(this.modifier);

  final ShipModifier modifier;
}
