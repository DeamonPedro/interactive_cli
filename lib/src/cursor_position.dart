class CursorPosition {
  final int col;
  final int row;

  CursorPosition(this.col, this.row);

  @override
  String toString() => '($col, $row)';
}
