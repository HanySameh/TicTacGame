import 'package:flutter/material.dart';
import 'package:tic_tac/game_logic.dart';

class TicTacLayout extends StatefulWidget {
  const TicTacLayout({Key? key}) : super(key: key);

  @override
  State<TicTacLayout> createState() => _TicTacLayoutState();
}

class _TicTacLayoutState extends State<TicTacLayout> {
  String activePlayer = 'x';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  bool isSwitched = false;
  Game game = Game();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? Column(
                children: [
                  SwitchListTile.adaptive(
                      activeColor: Colors.blue,
                      value: isSwitched,
                      title: const Text(
                        'play with onuther player',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      }),
                  Text(
                    'it\'s $activePlayer turn'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.all(16.0),
                      crossAxisCount: 3,
                      mainAxisSpacing: 9.0,
                      crossAxisSpacing: 9.0,
                      childAspectRatio: 1.0,
                      children: List.generate(
                          9,
                          (index) => InkWell(
                                borderRadius: BorderRadius.circular(16.0),
                                onTap: gameOver ? null : (() => onTap(index)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: Theme.of(context).shadowColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      Players.playerX.contains(index)
                                          ? 'x'
                                          : Players.playerO.contains(index)
                                              ? 'o'
                                              : '',
                                      style: TextStyle(
                                        color: Players.playerX.contains(index)
                                            ? Colors.blue
                                            : Colors.red,
                                        fontSize: 50.0,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),
                  Text(
                    result,
                    style: const TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        Players.playerX = [];
                        Players.playerO = [];
                        activePlayer = 'x';
                        gameOver = false;
                        turn = 0;
                        result = '';
                      });
                    },
                    icon: const Icon(Icons.replay),
                    label: const Text(
                      'Replay',
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).splashColor),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SwitchListTile.adaptive(
                            activeColor: Colors.blue,
                            value: isSwitched,
                            title: const Text(
                              'play with onuther player',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                              });
                            }),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'it\'s $activePlayer turn'.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          result,
                          style: const TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              Players.playerX = [];
                              Players.playerO = [];
                              activePlayer = 'x';
                              gameOver = false;
                              turn = 0;
                              result = '';
                            });
                          },
                          icon: const Icon(Icons.replay),
                          label: const Text(
                            'Replay',
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).splashColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.all(16.0),
                      crossAxisCount: 3,
                      mainAxisSpacing: 9.0,
                      crossAxisSpacing: 9.0,
                      childAspectRatio: 1.0,
                      children: List.generate(
                          9,
                          (index) => InkWell(
                                borderRadius: BorderRadius.circular(16.0),
                                onTap: gameOver ? null : (() => onTap(index)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: Theme.of(context).shadowColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      Players.playerX.contains(index)
                                          ? 'x'
                                          : Players.playerO.contains(index)
                                              ? 'o'
                                              : '',
                                      style: TextStyle(
                                        color: Players.playerX.contains(index)
                                            ? Colors.blue
                                            : Colors.red,
                                        fontSize: 50.0,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),
                ],
              ),
      )),
    );
  }

  onTap(int index) async {
    if ((Players.playerX.isEmpty || !Players.playerX.contains(index)) &&
        (Players.playerO.isEmpty || !Players.playerO.contains(index))) {
      game.startGame(index, activePlayer);
      updaeState();
      if (!isSwitched && !gameOver && turn != 9) {
        await game.outoPlay(activePlayer);
        updaeState();
      }
    }
  }

  void updaeState() {
    setState(() {
      turn++;
      activePlayer = (activePlayer == 'x') ? 'o' : 'x';
      String winnerPlayer = game.checkWinner();
      if (winnerPlayer != '') {
        gameOver = true;
        result = winnerPlayer;
      } else if (!gameOver && turn == 9) {
        result = 'It\'s Draw!';
      }
    });
  }
}
