import 'package:flutter/material.dart';
import 'package:solar_system_repository/solar_system_repository.dart';

extension StarX on Star {
  double get size => 30 * scale;

  List<Color> get palette {
    switch (type) {
      case StarType.m:
        return [Colors.orangeAccent, Colors.red];
      case StarType.k:
        return [Colors.orange, Colors.yellowAccent];
      case StarType.g:
      case StarType.f:
        return [Colors.yellow, Colors.white];
      case StarType.a:
        return [Colors.lightBlueAccent, Colors.white];
      case StarType.b:
        return [Colors.blueGrey, Colors.white];
      case StarType.o:
        return [Colors.blueAccent, Colors.white];
    }
  }

  String get starClass {
    return type.name.toUpperCase();
  }

  String get description {
    switch (type) {
      case StarType.m:
        return '''
Red stars that form the bulk of the main sequence stars in the galaxy. Have low mass, as is their surface temperature.
Class M star systems tend to contain many icy bodies and rocky ice worlds.
''';
      case StarType.k:
        return '''
Yellow-orange main sequence stars with a long and generally stable life. They range in mass from 0.6 to 0.9 solar masses and have a surface temperature reaching 5,000 K.
Class K star systems are the most likely to contain water worlds and rocky bodies.
''';
      case StarType.g:
        return '''
White-yellow main sequence stars. They range in mass from 0.8 to 1.2 solar masses and have a surface temperature reaching 6,000 K.
Class G star systems are one of the most likely to contain Earth-like worlds.
''';
      case StarType.f:
        return '''
White main sequence stars. They range in mass from 1 to 1.4 solar masses and have a surface temperature reaching 7,600 K.
Class F star systems are one of the most likely to contain Earth-like worlds.
''';
      case StarType.a:
        return '''
Hot white or bluish white main sequence stars. They range in mass from 1.4 to 2.1 solar masses and have a surface temperature reaching 10,000 K.
Class A star systems often contain high metal content worlds and metal-rich bodies.
''';
      case StarType.b:
        return '''
Very luminous blue-white stars. They range in mass from 2 to 16 solar masses and have a surface temperature reaching 30,000 K. Their lifetimes are shorter than most main sequence stars.
Class B star systems rarely contain terrestrial bodies. One of the most likely to host a stellar nursery.
''';
      case StarType.o:
        return '''
The most luminous and massive main sequence stars in the galaxy. They range in mass from 15 to 90 solar masses and burn very brightly indeed, with a surface temperature reaching 52,000 K so appear very blue. They are very short lived with lifetimes of 1 - 10 million years, ending in supernova.
Class O star systems rarely contain terrestrial bodies. One of the most likely to host a stellar nursery.
''';
    }
  }
}
