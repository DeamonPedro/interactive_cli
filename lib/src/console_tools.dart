import 'package:dart_console/dart_console.dart';

final _console = Console();

class ConsoleTools {
  final Coordinate _cursorOrigin = _console.cursorPosition!;
  List<String> _currentRender = [];
  int get _currentRenderLineCount => _currentRender.length;

  void clearRender() {
    _console.cursorPosition = _cursorOrigin;
    for (var i = 0; i < _currentRenderLineCount; i++) {
      _console.eraseLine();
      _console.cursorDown();
    }
    _console.cursorPosition = _cursorOrigin;
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