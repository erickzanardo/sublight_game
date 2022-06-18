import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:sublight_game/theme/border.dart';

export 'theme.dart';

const usedScheme = FlexScheme.green;

final _flexThemeData = FlexThemeData.dark(
  scheme: usedScheme,
  fontFamily: 'Firealistic',
);

const _backgroundOpacity = .6;

final sublightTheme = _flexThemeData.copyWith(
  dialogTheme: DialogTheme(
    backgroundColor: _flexThemeData.dialogBackgroundColor.withOpacity(
      _backgroundOpacity,
    ),
    shape: SublightBorder(
      color: _flexThemeData.primaryColorLight,
    ),
  ),
  cardTheme: CardTheme(
    color: _flexThemeData.cardColor.withOpacity(
      _backgroundOpacity,
    ),
    shape: SublightBorder(color: _flexThemeData.primaryColorLight),
  ),
  iconTheme: IconThemeData(color: _flexThemeData.primaryColor),
);
