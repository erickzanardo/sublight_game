// Reference
// https://elite-dangerous.fandom.com/wiki/Stars#Main_Sequence_Stars_(O,_B,_A,_F,_G,_K,_M)

/// {@template star_definition}
/// Model with the definitions of stars.
/// {@endtemplate}
class StarDefinition {
  /// {@macro star_definition}
  const StarDefinition({
    required this.probability,
  });

  /// A value between 0 and 1 which tells a probability of encountering
  /// this star in the galaxy.
  final double probability;
}

/// {@template star_type}
/// Enum listing the types of stars on the galaxy,
/// check its [StarDefinition] more info on each type.
/// {@endtemplate}
enum StarType {
  /// O
  o(StarDefinition(probability: 0.002)),

  /// B
  b(StarDefinition(probability: 0.017)),

  /// B
  a(StarDefinition(probability: 0.06)),

  /// F
  f(StarDefinition(probability: 0.12)),

  /// G
  g(StarDefinition(probability: 0.9)),

  /// K
  k(StarDefinition(probability: 0.25)),

  /// M
  m(StarDefinition(probability: 0.46));

  /// {@macro star_type}
  const StarType(this.definition);

  /// Contains the information and definitions of this star type.
  final StarDefinition definition;
}
