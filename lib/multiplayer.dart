import 'package:flutter/material.dart';
import 'dart:math';

class MultiplayerPage extends StatefulWidget {
  @override
  _MultiplayerPageState createState() => _MultiplayerPageState();
}

class _MultiplayerPageState extends State<MultiplayerPage> {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ""));
  String currentPlayer = "X";
  String winner = "";
  int xScore = 0;
  int oScore = 0;
  int ties = 0;

  List<List<int>> xMoves = [];
  List<List<int>> oMoves = [];
  List<List<int>> xPendingMoves = [];
  List<List<int>> oPendingMoves = [];

  void onTileTap(int row, int col) {
    if (board[row][col] == "" && winner == "") {
      setState(() {
        // Place the mark on the board
        board[row][col] = currentPlayer;

        // Track moves for "X" and "O"
        if (currentPlayer == "X") {
          xMoves.add([row, col]);

          // Check if 3rd X move is placed
          if (xMoves.length > 3) {
            List<int> firstMove = xMoves.removeAt(0);
            xPendingMoves.add(firstMove); // Add to pending for X
            board[firstMove[0]][firstMove[1]] = ""; // Clear oldest X move
          }
        } else {
          oMoves.add([row, col]);
          if (oMoves.length > 3) {
            List<int> firstMove = oMoves.removeAt(0);
            oPendingMoves.add(firstMove); // Add to pending for O
            board[firstMove[0]][firstMove[1]] = ""; // Clear oldest O move
          }
        }

        // Check for winner after the move
        winner = checkWinner();

        // Switch player
        if (winner == "") {
          currentPlayer = currentPlayer == "X" ? "O" : "X";
        } else {
          if (winner == "X") xScore++;
          if (winner == "O") oScore++;
          if (winner == "Tie") ties++;
        }
      });
    }
  }

  int minimax(List<List<String>> board, bool isMaximizing) {
    String result = checkWinner();

    if (result == "O") return 10;
    if (result == "X") return -10;
    if (boardIsFull(board)) return 0;

    if (isMaximizing) {
      int bestScore = -10000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == "") {
            board[i][j] = "O";
            int score = minimax(board, false);
            board[i][j] = "";
            bestScore = max(score, bestScore);
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = 10000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == "") {
            board[i][j] = "X";
            int score = minimax(board, true);
            board[i][j] = "";
            bestScore = min(score, bestScore);
          }
        }
      }
      return bestScore;
    }
  }

  bool boardIsFull(List<List<String>> board) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == "") return false;
      }
    }
    return true;
  }

  String checkWinner() {
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
    for (var row in board) {
      if (row.contains("")) return "";
    }
    return "Tie";
  }

  void resetGame() {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, ""));
      winner = "";
      currentPlayer = "X";
      xMoves.clear();
      oMoves.clear();
      xPendingMoves.clear();
      oPendingMoves.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A2E),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Display Turn
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "X",
                style: TextStyle(fontSize: 30, color: Colors.tealAccent),
              ),
              SizedBox(width: 10),
              Text(
                "O",
                style: TextStyle(fontSize: 30, color: Colors.amberAccent),
              ),
              SizedBox(width: 20),
              Text(
                "$currentPlayer TURN",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),

          // Board
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (row) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (col) {
                  // Change color only after 3rd X move
                  bool isOldestX = xMoves.length >= 3 &&
                      xMoves.first[0] == row &&
                      xMoves.first[1] == col;

                  return GestureDetector(
                    onTap: () => onTileTap(row, col),
                    child: Container(
                      margin: EdgeInsets.all(8),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: (board[row][col] == "X" &&
                                isOldestX &&
                                winner == "")
                            ? Colors.grey[850]
                            : Color(0xFF16213E),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87,
                            offset: Offset(0, 4),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          board[row][col],
                          style: TextStyle(
                            fontSize: 50,
                            color: board[row][col] == "X"
                                ? Colors.tealAccent
                                : Colors.amberAccent,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            }),
          ),

          // Scores
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildScoreCard("X (Player)", xScore, Colors.tealAccent),
              _buildScoreCard("O (Player)", oScore, Colors.amberAccent),
            ],
          ),

          // Reset Button
          ElevatedButton(
            onPressed: resetGame,
            child: Text("RESET GAME"),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard(String player, int score, Color color) {
    return Column(
      children: [
        Text(
          player,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            score.toString(),
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
