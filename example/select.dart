import 'package:interactive_cli/interactive_cli.dart';
import 'package:collection/collection.dart';

class Select extends InteractiveLines<int> {
  final List<String> options;
  int _selectedOption;

  Select({
    required this.options,
    int defaultOption = 0,
  }) : _selectedOption = defaultOption;

  @override
  void onInit() {
    //context.hideCursor();
  }

  @override
  void onFinish(res) {
    print(res);
    context.showCursor();
  }

  @override
  List<String> render() {
    context.setCursorPosition(column: 1, row: 1);
    return options.mapIndexed((index, element) {
      if (index == _selectedOption) {
        return '> $element';
      } else {
        return element;
      }
    }).toList();
  }

  void _up() {
    if (_selectedOption > 0) {
      _selectedOption--;
    } else {
      _selectedOption = options.length - 1;
    }
  }

  void _down() {
    if (_selectedOption < options.length - 1) {
      _selectedOption++;
    } else {
      _selectedOption = 0;
    }
  }

  @override
  react(Key pressedKey, Function(int value) finish) {
    if (pressedKey.controlChar == ControlCharacter.arrowUp) {
      _up();
    } else if (pressedKey.controlChar == ControlCharacter.arrowDown) {
      _down();
    } else if (pressedKey.controlChar == ControlCharacter.enter) {
      finish(_selectedOption);
    }
  }
}
