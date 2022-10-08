import 'package:interactive_cli/src/context.dart';
import 'package:dart_console/dart_console.dart';

abstract class InteractiveLines<T> {
  final context = Context();
  renderLines() => context.render(render());
  T? _return;

  void onInit() {}
  void onFinish(T) {}

  List<String> render();

  void react(
    Key pressedKey,
    Function(T value) finish,
  );

  T load() {
    onInit();
    renderLines();
    while (true) {
      react(
        context.readKey(),
        (value) {
          _return = value;
        },
      );
      if (_return != null) {
        context.clearRender();
        onFinish(_return!);
        return _return!;
      } else {
        renderLines();
      }
    }
  }
}
