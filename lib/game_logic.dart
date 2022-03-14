// ignore_for_file: unnecessary_this

import 'dart:math';

class Players {
  static const x = 'x';
  static const o = 'o';
  static const empty = '';
  static List<int> playerX = [];
  static List<int> playerO = [];
}

extension ContainAll on List {
  bool containAll(int x, int y, [z]) {
    if (z == null) {
      return contains(x) && contains(y);
    } else {
      return contains(x) && contains(y) && contains(z);
    }
  }
}

class Game {
  void startGame(int index, String activePlayer) {
    if (activePlayer == 'x') {
      Players.playerX.add(index);
    } else {
      Players.playerO.add(index);
    }
  }

  Future<void> outoPlay(activePlayer) async {
    int index = 0;
    List<int> emptyCells = [];

    for (var i = 0; i < 9; i++) {
      if (!(Players.playerX.contains(i) || Players.playerO.contains(i))) {
        emptyCells.add(i);
      }
    }

    Random random = Random();
    int randomIndex = random.nextInt(emptyCells.length);
    index = emptyCells[randomIndex];
    startGame(index, activePlayer);
  }

  String checkWinner() {
    String winner = '';
    if (Players.playerX.containAll(0, 1, 2) ||
        Players.playerX.containAll(3, 4, 5) ||
        Players.playerX.containAll(6, 7, 8) ||
        Players.playerX.containAll(0, 4, 8) ||
        Players.playerX.containAll(2, 4, 6) ||
        Players.playerX.containAll(0, 3, 6) ||
        Players.playerX.containAll(1, 4, 7) ||
        Players.playerX.containAll(2, 5, 8)) {
      winner = 'X is Winner';
    } else if (Players.playerO.containAll(0, 1, 2) ||
        Players.playerO.containAll(3, 4, 5) ||
        Players.playerO.containAll(6, 7, 8) ||
        Players.playerO.containAll(0, 4, 8) ||
        Players.playerO.containAll(2, 4, 6) ||
        Players.playerO.containAll(0, 3, 6) ||
        Players.playerO.containAll(1, 4, 7) ||
        Players.playerO.containAll(2, 5, 8)) {
      winner = 'O is Winner';
    } else {
      winner = '';
    }
    return winner;
  }
}
