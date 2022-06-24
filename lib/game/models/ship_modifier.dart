import 'package:equatable/equatable.dart';

class ShipModifier extends Equatable {
  const ShipModifier({
    required this.space,
    required this.sblSpeed,
    required this.impulseSpeed,
    required this.peopleCapacity,
  });

  const ShipModifier.noEffects()
      : this(
          space: 0,
          sblSpeed: 0,
          impulseSpeed: 0,
          peopleCapacity: 0,
        );

  final int space;
  final double sblSpeed;
  final double impulseSpeed;
  final int peopleCapacity;

  ShipModifier operator +(ShipModifier other) {
    return copyWith(
      space: space + other.space,
      sblSpeed: sblSpeed + other.sblSpeed,
      impulseSpeed: impulseSpeed + other.impulseSpeed,
      peopleCapacity: peopleCapacity + other.peopleCapacity,
    );
  }

  ShipModifier copyWith({
    int? space,
    double? sblSpeed,
    double? impulseSpeed,
    int? peopleCapacity,
  }) {
    return ShipModifier(
      space: space ?? this.space,
      sblSpeed: sblSpeed ?? this.sblSpeed,
      impulseSpeed: impulseSpeed ?? this.impulseSpeed,
      peopleCapacity: peopleCapacity ?? this.peopleCapacity,
    );
  }

  @override
  List<Object?> get props => [space, sblSpeed, impulseSpeed, peopleCapacity];
}
