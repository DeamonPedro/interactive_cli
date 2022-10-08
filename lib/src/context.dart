import 'package:dart_console/dart_console.dart';
import 'package:interactive_cli/src/console_tools.dart';
import 'package:interactive_cli/src/cursor_position.dart';
import 'package:interactive_cli/src/utils/lines.dart';

class Context {
  final ConsoleTools _console = ConsoleTools();
  CursorPosition _cursorPosition = CursorPosition(0, 0);
  List<String> _currentRender = [];

  CursorPosition getCursorPosition() => _cursorPosition;

  void setCursorPosition({required int column, required int row}) {
    _cursorPosition = CursorPosition(column, row);
  }

  void moveCursorDown({int count = 1}) => _console.moveCursorDown(count: count);

  void moveCursorUp({int count = 1}) => _console.moveCursorUp(count: count);

  void moveCursorToRow(int row) => _console.moveCursorToRow(row);

  void moveCursorRight({int count = 1}) =>
      _console.moveCursorRight(count: count);

  void moveCursorLeft({int count = 1}) => _console.moveCursorLeft(count: count);

  void hideCursor() => _console.hideCursor();

  void showCursor() => _console.showCursor();

  void clearRender() {
    _console.resetCursor();
    for (var i = 0; i < _currentRender.length; i++) {
      _console.eraseLine();
      _console.moveCursorDown();
    }
    _console.resetCursor();
    _currentRender = [];
  }

  void render(List<String> lines) {
    _console.resetCursor();
    final diff = linesDiff(_currentRender, lines);
    diff.forEach((index, line) {
      _console.moveCursorToRow(index);
      _console.moveCursorToColumn(0);
      _console.eraseLine();
      _console.write(line);
    });
    _currentRender = lines;
    _console.setCursorPosition(_cursorPosition);
  }

  Key readKey() => _console.readKey();
}
