import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:population_repository/population_repository.dart';
import 'package:solar_system_repository/solar_system_repository.dart';
import 'package:sublight_game/game/game.dart';
import 'package:sublight_game/l10n/l10n.dart';
import 'package:sublight_game/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: sublightTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => const PopulationRepository()),
          RepositoryProvider(create: (_) => SolarSystemRepository()),
        ],
        child: const GamePage(),
      ),
    );
  }
}
