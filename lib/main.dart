import 'dart:math';
import 'dart:async';
//EVELYN ESCOBEDO + MYLA NEWBY

import 'package:flutter/material.dart';
TextEditingController text1 = TextEditingController();
Timer? timer1;
void main() {
  runApp(MaterialApp(
    home: DigitalPetApp(),
  ));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
  
}


class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "Your Pet";
  int happinessLevel = 50;
  int hungerLevel = 50;
  int energyLevel = 50;
  Color petColor = Colors.yellow;
  String mood = "Neutral";
  String moodEmoji = 'https://emojiisland.com/cdn/shop/products/Emoji_Icon_-_Smiling_medium.png?v=1571606089';
  String selectedActivity = 'Play';
  Timer? _winTimer;
  bool _hasWon = false;
  void _setName() {
    setState(() {
      petName = text1.text;
    });
  }

  // Function to start the win timer
  void _startWinTimer() {
    _winTimer?.cancel();
    _winTimer = Timer(Duration(minutes: 1), () {
      if (happinessLevel > 80) {
        setState(() {
          _hasWon = true;
        });
        _showWinDialog();
      }
    });
  }

  // Function to show win dialog
  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("You Win!"),
        content: Text("Congratulations! Your pet is very happy!"),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  // Function to show game over dialog
  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Game Over!"),
        content: Text("Your pet has died of hunger!"),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  // Function to check for win/loss conditions
  void _checkWinLossConditions() {
    if (happinessLevel > 80) {
      _startWinTimer();
    } else {
      _winTimer?.cancel();
    }

    if (hungerLevel == 100 && happinessLevel <= 10) {
      _showGameOverDialog();
    }
  }
  Timer? timer1;

  void _hungerTime () {
    timer1 = Timer.periodic(const Duration(seconds: 30), (timer) {
      // Check if the tick number is 5
      if (hungerLevel != 0) {
          //timer.cancel();
          setState( () {
            hungerLevel -= 10;
          });          
      }
    });
  }

  // Function to increase happiness and update hunger when playing with the pet
  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      _updateHunger();
      _decreaseEnergy();
      _checkWinLossConditions();
    });
  }

  // Function to decrease hunger and update happiness when feeding the pet
  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      _updateHappiness();
      _increaseEnergy();
      _checkWinLossConditions();
    });
  }

  // Update happiness based on hunger level
  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    } else {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
    }
    _updateMood();
  }

  // Increase hunger level slightly when playing with the pet
  void _updateHunger() {
    hungerLevel = (hungerLevel + 5).clamp(0, 100);
    if (hungerLevel > 100) {
      hungerLevel = 100;
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    }
    _updateMood();
  }

  void _updateMood() {
    setState(() {
      if (happinessLevel > 70) {
        mood = "Happy";
        petColor = Colors.green;
        moodEmoji = 'https://emojiisland.com/cdn/shop/products/Emoji_Icon_-_Smiling_medium.png?v=1571606089';
      } else if (happinessLevel < 30) {
        mood = "Unhappy";
        petColor = Colors.red;
        moodEmoji = 'https://static.vecteezy.com/system/resources/previews/038/512/164/non_2x/a-3d-sad-face-emoji-2-on-a-transparent-background-free-png.png';
      } else {
        mood = "Neutral";
        petColor = Colors.yellow;
        moodEmoji = 'https://static-00.iconduck.com/assets.00/neutral-face-emoji-2048x1974-qdahu9yw.png';
      }
      _hungerTime();
    });
  }

  //Increase energy level slightly when feeding the pet
  void _increaseEnergy(){
    setState(() {
      energyLevel = (energyLevel + 10).clamp(0, 100);
    });
  }

  // Decrease energy level when playing with the pet
  void _decreaseEnergy(){
    setState(() {
      energyLevel = (energyLevel - 10).clamp(0, 100);
    });
  }

  // Function to handle activity selection
  void _selectActivity(String? activity) {
    setState(() {
      selectedActivity = activity!;
    });
  }

  // Function to perform the selected activity
  void _performActivity() {
    if (selectedActivity == 'Play') {
      _playWithPet();
    } else if (selectedActivity == 'Feed') {
      _feedPet();
    }
  }

  var activities = ['Play', 'Feed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Input Pet Name',
              ),
              controller: text1,
            ),
            ElevatedButton(
              onPressed: _setName, 
              child: Text("Confirm Name"),
            ),
            Text(
              'Name: $petName',
              style: TextStyle(fontSize: 20.0, color: petColor),
            ),
            SizedBox(height: 16.0),
            Text(
              'Happiness Level: $happinessLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Hunger Level: $hungerLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Mood: $mood',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height:8.0),
            Padding(
              padding: EdgeInsets.all(8.0), 
              child: Image.network(moodEmoji, height: 30, width: 30)),
            SizedBox(height: 32.0),
            DropdownButton<String>(
              value: selectedActivity,
              icon: const Icon(Icons.keyboard_arrow_down),    
              items: activities.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                _selectActivity(newValue);
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _performActivity,
              child: Text('Perform Activity'),
            ),
            Text(
              'Energy Level: $energyLevel',
              
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 8.0),
            LinearProgressIndicator(
              value: energyLevel / 100,
              minHeight: 10.0,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
