import 'package:dashbook/dashbook.dart';
import 'package:example/stories/flat/stories.dart';
import 'package:example/stories/gradient/stories.dart';
import 'package:flutter/material.dart';

void main() {
  final dashbook = Dashbook(theme: ThemeData.dark());

  addFlatStories(dashbook);
  addGradientStories(dashbook);

  runApp(dashbook);
}
