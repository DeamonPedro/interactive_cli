import 'dart:io';

import 'package:dart_console/dart_console.dart';
import 'package:collection/collection.dart';

final _console = Console();

class ConsoleTools {
  final Coordinate _cursorOrigin = _console.cursorPosition!;
  List<String> _currentRender = [];

  ConsoleTools() {
    _saveCursorPosition();
  }

  void _saveCursorPosition() {
    stdout.write('\x1b[s');
  }

  void _restoreCursorPosition() {
    stdout.write('\x1b[u');
  }

  void clearRender() {
    _restoreCursorPosition();
    for (var line in _currentRender) {
      _console.eraseLine();
      _console.cursorDown();
    }
    _restoreCursorPosition();
    _currentRender = [];
  }

  void hideCursor() => _console.hideCursor();

  void showCursor() => _console.showCursor();

  void render(List<String> lines) {
    _restoreCursorPosition();
    lines.forEachIndexed((index, line) {
      if (!_currentRender.asMap().containsKey(index) ||
          _currentRender[index] != line) {
        _console.eraseLine();
        stdout.write(line);
        stdout.write(_console.newLine);
      } else {
        _console.cursorDown();
      }
    });
    for (var i = lines.length; i < _currentRender.length; i++) {
      _console.eraseLine();
      _console.cursorDown();
    }
    _currentRender = lines;
  }

  Key readKey() => _console.readKey();
}
