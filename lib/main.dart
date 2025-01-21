import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synthlyzr/demo_screen.dart';
import 'package:synthlyzr/main_widget.dart';

void main() {
  runApp(ProviderScope(
    child: MainWidget(),
  ));
}
