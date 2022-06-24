/// {@template age_range_mapping}
/// Model that maps an age range to a percent of a subject.
/// {@endtemplate}
class AgeRangeRiskMapping {
  /// {@macro age_range_mapping}
  const AgeRangeRiskMapping({
    required this.from,
    required this.to,
    required this.percent,
  });

  /// Start of the age range.
  final int from;

  /// End of the age range.
  final int to;

  /// Percent of the subject that is in the age range.
  final double percent;
}

const _naturalDeathRisk = [
  AgeRangeRiskMapping(from: 0, to: 40, percent: 0),
  AgeRangeRiskMapping(from: 41, to: 60, percent: 0.01),
  AgeRangeRiskMapping(from: 61, to: 80, percent: 0.1),
  AgeRangeRiskMapping(from: 81, to: 90, percent: 0.2),
];

AgeRangeRiskMapping Function(int) _riskMapping(
    List<AgeRangeRiskMapping> mappings) {
  // TODO cache the value for performance.
  return (age) => mappings.firstWhere(
        (mapping) => mapping.from <= age && age <= mapping.to,
        orElse: () => mappings.last,
      );
}

/// Returns the [AgeRangeRiskMapping] for the given age regarding natural
/// death risk.
final naturalDeathRiskMapping = _riskMapping(_naturalDeathRisk);
