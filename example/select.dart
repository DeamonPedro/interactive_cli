import 'package:dart_console/src/key.dart';
import 'package:interactive_cli/interactive_cli.dart';
import 'package:collection/collection.dart';

class Select extends ConsoleElement<int> {
  final List<String> options;
  int _selectedOption;

  Select({
    required this.options,
    int defaultOption = 0,
  }) : _selectedOption = defaultOption;

  @override
  void onInit(renderController) {
    renderController.hideCursor();
  }

  @override
  void onFinish(renderController) {
    renderController.showCursor();
  }

  @override
  List<String> render(renderController) {
    return options.mapIndexed((index, option) {
      if (index == _selectedOption) {
        return '> $option';
      } else {
        return option;
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
  react(Key pressedKey, Function(int) finish, Function reload) {
    if (pressedKey.controlChar == ControlCharacter.arrowUp) {
      _up();
      reload();
    } else if (pressedKey.controlChar == ControlCharacter.arrowDown) {
      _down();
      reload();
    } else if (pressedKey.controlChar == ControlCharacter.enter) {
      finish(_selectedOption);
    }
  }
}
