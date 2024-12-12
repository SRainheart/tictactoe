import 'dart:io';

class TicTacToe {
  late int size;
  late List<List<String>> board;
  String currentPlayer = 'X';

  TicTacToe(this.size) {
    board = List.generate(size, (_) => List.filled(size, '-'));
  }

  void printBoard() {
    for (var row in board) {
      print(row.join(' '));
    }
  }

  bool makeMove(int row, int col) {
    if (row >= 0 &&
        row < size &&
        col >= 0 &&
        col < size &&
        board[row][col] == '-') {
      board[row][col] = currentPlayer;
      return true;
    }
    return false;
  }

  bool checkWinner() {
    for (int i = 0; i < size; i++) {
      if (board[i].every((cell) => cell == currentPlayer)) {
        return true;
      }
    }
    for (int i = 0; i < size; i++) {
      if (List.generate(size, (index) => board[index][i])
          .every((cell) => cell == currentPlayer)) {
        return true;
      }
    }
    if (List.generate(size, (index) => board[index][index])
        .every((cell) => cell == currentPlayer)) {
      return true;
    }
    if (List.generate(size, (index) => board[index][size - index - 1])
        .every((cell) => cell == currentPlayer)) {
      return true;
    }
    return false;
  }

  bool isBoardFull() {
    for (var row in board) {
      if (row.contains('-')) {
        return false;
      }
    }
    return true;
  }

  void switchPlayer() {
    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
  }
}

void main() {
  print("Добро пожаловать в игру Крестики-Нолики!");
  print("Введите размер поля (например, 3 для 3x3): ");
  var sizeInput = stdin.readLineSync();
  var size = int.tryParse(sizeInput ?? '3') ?? 3;
  if (size < 3) {
    print("Размер слишком мал, устанавливаю 3.");
    size = 3;
  }
  var game = TicTacToe(size);
  while (true) {
    game.printBoard();
    print(
        "Игрок ${game.currentPlayer}, введите номер строки и столбца (0-${size - 1}) или 'выход' для завершения игры: ");
    var input = stdin.readLineSync();
    if (input?.toLowerCase() == 'выход') {
      print("Игра завершена.");
      break;
    }
    var moves = input?.split(' ');
    if (moves != null && moves.length == 2) {
      var row = int.tryParse(moves[0]);
      var col = int.tryParse(moves[1]);
      if (row != null && col != null && game.makeMove(row, col)) {
        if (game.checkWinner()) {
          game.printBoard();
          print("Игрок ${game.currentPlayer} победил!");
          break;
        } else if (game.isBoardFull()) {
          game.printBoard();
          print("Ничья!");
          break;
        }
        game.switchPlayer();
      } else {
        print("Некорректный ход. Попробуйте снова.");
      }
    } else {
      print("Некорректный ввод. Введите два числа, разделённые пробелом.");
    }
  }
}
