import 'package:flutter/material.dart';

class MultiplayerPage extends StatefulWidget {
  @override
  _MultiplayerPageState createState() => _MultiplayerPageState();
}

class _MultiplayerPageState extends State<MultiplayerPage> {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ""));
  String currentPlayer = "X";
  Map<String, List<List<int>>> moveHistory = {"X": [], "O": []};
  List<List<double>> opacityBoard =
      List.generate(3, (_) => List.filled(3, 1.0));

  void onTileTap(int row, int col) {
    if (board[row][col] == "") {
      setState(() {
        board[row][col] = currentPlayer;
        moveHistory[currentPlayer]?.add([row, col]);

        // If the player has more than 3 moves, remove the oldest one
        if (moveHistory[currentPlayer]!.length > 3) {
          var oldMove = moveHistory[currentPlayer]?.removeAt(0);
          if (oldMove != null) {
            int oldRow = oldMove[0];
            int oldCol = oldMove[1];

            // Fade out the removed mark
            setState(() {
              opacityBoard[oldRow][oldCol] = 0.0;
            });

            Future.delayed(Duration(milliseconds: 300), () {
              setState(() {
                board[oldRow][oldCol] = "";
                opacityBoard[oldRow][oldCol] = 1.0;
              });
            });
          }
        }

        // Check for a winner
        String? winner = checkWinner();
        if (winner != null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Game Over"),
              content: Text("$winner wins! Congratulations!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    resetBoard();
                  },
                  child: Text("Play Again"),
                ),
              ],
            ),
          );
          return;
        }

        // Switch player
        currentPlayer = currentPlayer == "X" ? "O" : "X";
      });
    }
  }

  String? checkWinner() {
    // Check rows and columns
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] &&
          board[i][1] == board[i][2] &&
          board[i][0] != "") {
        return board[i][0];
      }
      if (board[0][i] == board[1][i] &&
          board[1][i] == board[2][i] &&
          board[0][i] != "") {
        return board[0][i];
      }
    }
    // Check diagonals
    if (board[0][0] == board[1][1] &&
        board[1][1] == board[2][2] &&
        board[0][0] != "") {
      return board[0][0];
    }
    if (board[0][2] == board[1][1] &&
        board[1][1] == board[2][0] &&
        board[0][2] != "") {
      return board[0][2];
    }
    return null;
  }

  void resetBoard() {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, ""));
      moveHistory = {"X": [], "O": []};
      opacityBoard = List.generate(3, (_) => List.filled(3, 1.0));
      currentPlayer = "X";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multiplayer Tic Tac Toe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (col) {
              return GestureDetector(
                onTap: () => onTileTap(row, col),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: opacityBoard[row][col],
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        board[row][col],
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: resetBoard,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
