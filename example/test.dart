import 'dart:io';

import 'package:dart_console/dart_console.dart';
import 'package:interactive_cli/src/console_tools.dart';
import 'package:interactive_cli/src/context.dart';
import 'package:collection/collection.dart';

void main(List<String> args) {
  ConsoleTools console = ConsoleTools();
  Context context = Context();

  int selected = 0;
  List<String> options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
    'Option 6',
    'Option 7',
    'Option 8',
    'Option 9',
  ];
  while (true) {
    context.render(options.mapIndexed((index, element) {
      if (index == selected) {
        return '> $element';
      } else {
        return element;
      }
    }).toList());
    final key = context.readKey();
    if (key.controlChar == ControlCharacter.arrowUp) {
      if (selected > 0) {
        selected--;
      } else {
        selected = options.length - 1;
      }
    } else if (key.controlChar == ControlCharacter.arrowDown) {
      if (selected < options.length - 1) {
        selected++;
      } else {
        selected = 0;
      }
    } else if (key.controlChar == ControlCharacter.enter) {
      break;
    } else if (key.controlChar == ControlCharacter.ctrlC) {
      exit(0);
    }
  }
}
