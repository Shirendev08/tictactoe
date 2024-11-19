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
      debugShowCheckedModeBanner: false, // Disable the debug banner
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(
          0xFF1A1A2E), // Match the background color from the SingleplayerPage
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1A2E), // Match the background color
        elevation: 0, // Remove the shadow
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.gamepad,
                color: Colors.tealAccent, size: 30), // Tic Tac Toe Icon
            SizedBox(width: 10),
            Text(
              'Tic Tac Toe',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Color(0xFF00695C), // Darker color for the button (teal)
              elevation: 10, // Card shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  // Navigate to singleplayer page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SingleplayerPage()),
                  );
                },
                splashColor: Colors.tealAccent, // Splash effect on tap
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.gamepad,
                          color: Colors.white,
                          size: 40), // Larger icon for singleplayer
                      SizedBox(width: 10),
                      Text(
                        'Singleplayer',
                        style: TextStyle(
                          fontSize: 24, // Larger font size for the button text
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: Color(0xFFFFB300), // Darker color for the button (amber)
              elevation: 10, // Card shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  // Navigate to multiplayer page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MultiplayerPage()),
                  );
                },
                splashColor: Colors.amberAccent, // Splash effect on tap
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.people,
                          color: Colors.white,
                          size: 40), // Larger icon for multiplayer
                      SizedBox(width: 10),
                      Text(
                        'Multiplayer',
                        style: TextStyle(
                          fontSize: 24, // Larger font size for the button text
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
