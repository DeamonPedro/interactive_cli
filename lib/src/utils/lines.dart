import 'dart:math';

Map<int, String> linesDiff(List<String> current, List<String> input) {
  final maxLen = max(current.length, input.length);
  final currentLines = current.asMap();
  final inputLines = input.asMap();
  final result = <int, String>{};
  for (var index = 0; index < maxLen; index++) {
    if (currentLines[index] != inputLines[index]) {
      if (inputLines[index] == null) {
        result[index] = '';
      } else {
        result[index] = inputLines[index]!;
      }
    }
  }
  return result;
}
