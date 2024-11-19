import 'package:flutter/material.dart';
import 'singleplayer.dart'; // Importing the Singleplayer page
import 'multiplayer.dart'; // Adjust the path if needed

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to singleplayer page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SingleplayerPage()),
                );
              },
              child: Text('Singleplayer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to multiplayer page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MultiplayerPage()),
                );
              },
              child: Text('Multiplayer'),
            ),
          ],
        ),
      ),
    );
  }
}
