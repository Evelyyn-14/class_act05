import 'dart:math';

import 'package:flutter/material.dart';

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

  // Function to increase happiness and update hunger when playing with the pet
  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      _updateHunger();
      _decreaseEnergy();
    });
  }

  // Function to decrease hunger and update happiness when feeding the pet
  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      _updateHappiness();
      _increaseEnergy();
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
    });
  }

  //Increase energy level slightly when feeding the pet
  void _increaseEnergy(){
    setState(() {
      energyLevel = (energyLevel + 10).clamp(0, 100);
    });
  }

  void _decreaseEnergy(){
    setState(() {
      energyLevel = (energyLevel - 10).clamp(0, 100);
    });
  }

  void _updateEnergy(){
    if (energyLevel < 30){
      energyLevel = (energyLevel + 20).clamp(0, 100);
    } else {
      energyLevel = (energyLevel - 10).clamp(0, 100);
    }
  }

  //Increase energy level slightly when feeding the pet
  /*void _increaseEnergy(){
    setState(() {
      energyLevel = (energyLevel + 10).clamp(0, 100);
    });
  }

  void _decreaseEnergy(){
    setState(() {
      energyLevel = (energyLevel - 10).clamp(0, 100);
    });
  }

  void _updateEnergy(){
    if (energyLevel < 30){
      energyLevel = (energyLevel + 20).clamp(0, 100);
    } else {
      energyLevel = (energyLevel - 10).clamp(0, 100);
    }
  }*/

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
            Text(
              'Name: $petName',
              style: TextStyle(fontSize: 20.0),
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
            ElevatedButton(
              onPressed: _playWithPet,
              child: Text('Play with Your Pet'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _feedPet,
              child: Text('Feed Your Pet'),
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
