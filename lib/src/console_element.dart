import 'package:dart_console/dart_console.dart';
import 'package:interactive_cli/src/console_tools.dart';

abstract class ConsoleElement<T> {
  final _consoleTools = ConsoleTools();
  T? _return;

  void onInit(ConsoleTools consoleTools) {}
  void onFinish(ConsoleTools consoleTools) {}

  List<String> render(ConsoleTools consoleTools);

  void react(
    Key pressedKey,
    Function(T) finish,
    Function reload,
  );

  T load() {
    onInit(_consoleTools);
    _consoleTools.render(render(_consoleTools));
    while (true) {
      react(
        _consoleTools.readKey(),
        (T value) => _return = value,
        () => _consoleTools.render(render(_consoleTools)),
      );
      if (_return != null) {
        _consoleTools.clearRender();
        onFinish(_consoleTools);
        return _return!;
      }
    }
  }
}
