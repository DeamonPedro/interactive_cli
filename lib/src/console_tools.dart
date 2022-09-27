import 'dart:io';

import 'package:dart_console/dart_console.dart';

final _console = Console();

class ConsoleTools {
  final Coordinate _cursorOrigin = _console.cursorPosition!;
  List<String> _currentRender = [];
  int get _currentRenderLineCount => _currentRender.length;

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
    for (var i = 0; i < _currentRenderLineCount; i++) {
      _console.eraseLine();
      _console.cursorDown();
    }
    _restoreCursorPosition();
    _currentRender = [];
  }

  void hideCursor() => _console.hideCursor();

  void showCursor() => _console.showCursor();

  void render(List<String> lines) {
    clearRender();
    for (var line in lines) {
      _console.write(line);
      _console.write(_console.newLine);
    }
    _currentRender = lines;
  }

  Key readKey() => _console.readKey();
}
