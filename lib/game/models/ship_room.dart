import 'package:equatable/equatable.dart';
import 'package:sublight_game/game/models/models.dart';

class ShipRoom extends Equatable {
  const ShipRoom({this.module});

  final ShipModule? module;

  @override
  List<Object?> get props => [module];
}
