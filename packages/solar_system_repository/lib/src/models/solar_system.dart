// Reference
// https://elite-dangerous.fandom.com/wiki/Stars#Main_Sequence_Stars_(O,_B,_A,_F,_G,_K,_M)

import 'package:equatable/equatable.dart';

/// {@template star_definition}
/// Model with the definitions of stars.
/// {@endtemplate}
class StarDefinition {
  /// {@macro star_definition}
  const StarDefinition({
    required this.probability,
    required this.scaleMin,
    required this.scaleMax,
  });

  /// A value between 0 and 1 which tells a probability of encountering
  /// this star in the galaxy.
  final double probability;

  /// A double representing the minimal size of this star comparing to Sol.
  final double scaleMin;

  /// A double representing the maximum size of this star comparing to Sol.
  final double scaleMax;
}

/// {@template star_type}
/// Enum listing the types of stars on the galaxy,
/// check its [StarDefinition] more info on each type.
/// {@endtemplate}
enum StarType {
  /// O
  o(StarDefinition(probability: 0.002, scaleMin: 15, scaleMax: 90)),

  /// B
  b(StarDefinition(probability: 0.017, scaleMin: 2, scaleMax: 16)),

  /// B
  a(StarDefinition(probability: 0.06, scaleMin: 1.4, scaleMax: 2.1)),

  /// F
  f(StarDefinition(probability: 0.12, scaleMin: 1, scaleMax: 1.4)),

  /// G
  g(StarDefinition(probability: 0.9, scaleMin: 0.8, scaleMax: 1.2)),

  /// K
  k(StarDefinition(probability: 0.25, scaleMin: 0.6, scaleMax: 0.9)),

  /// M
  m(StarDefinition(probability: 0.46, scaleMin: 0.2, scaleMax: 0.5));

  /// {@macro star_type}
  const StarType(this.definition);

  /// Contains the information and definitions of this star type.
  final StarDefinition definition;
}

/// {@template star}
/// Modal representing a Star.
class Star extends Equatable {
  /// {@macro star}
  const Star({
    required this.type,
    required this.scale,
  });

  /// [StarType] of this star.
  final StarType type;

  /// scale in solar masses of this star.
  final double scale;

  @override
  List<Object> get props => [type, scale];
}
