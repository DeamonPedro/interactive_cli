import 'dart:io';

import 'package:dart_console/dart_console.dart';
import 'package:interactive_cli/src/cursor_position.dart';

class ConsoleTools {
  final Console _console = Console();
  int get columns => stdout.terminalColumns;
  int get rows => stdout.terminalLines;

  int currentRow = 0;

  ConsoleTools() {
    moveCursorToColumn(0);
  }

  void resetCursor() {
    moveCursorToRow(0);
    moveCursorToColumn(0);
  }

  void setCursorPosition(CursorPosition position) {
    moveCursorToRow(position.row);
    moveCursorToColumn(position.col);
  }

  void moveCursorDown({int count = 1}) {
    for (var i = 0; i < count; i++) {
      _console.write(_console.newLine);
      currentRow++;
    }
  }

  void moveCursorUp({int count = 1}) {
    for (var i = 0; i < count; i++) {
      _console.cursorUp();
      currentRow--;
    }
  }

  void moveCursorToRow(int row) {
    final diff = row - currentRow;
    if (diff > 0) {
      moveCursorDown(count: diff);
    } else if (diff < 0) {
      moveCursorUp(count: diff.abs());
    }
  }

  void moveCursorToColumn(int column) => stdout.write('\x1b[${column + 1}G');

  void moveCursorRight({int count = 1}) => stdout.write('\x1b[${count}C');

  void moveCursorLeft({int count = 1}) => stdout.write('\x1b[${count}D');

  void write(String text) => _console.write(text);

  void eraseLine() => _console.eraseLine();

  void showCursor() => _console.showCursor();

  void hideCursor() => _console.hideCursor();

  void clearScreen() => _console.clearScreen();

  Key readKey() => _console.readKey();
}
