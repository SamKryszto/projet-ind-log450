import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WordLink',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WordLink',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24.0,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [Colors.green, Colors.blue],
                ).createShader(bounds);
              },
              child: Text(
                'WordLink',
                style: TextStyle(
                  fontSize: 50.0,
                  color:
                      Colors.white, // This color will be masked by the gradient
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlayPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ), // Set text color to white
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
              child: Text('Play'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ), // Set text color to white
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
              child: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayPage extends StatefulWidget {
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  bool _blueLetter = false;
  static const int timerDuration = 60;
  late Timer _timer;
  int _remainingTime = timerDuration;

  // these variables are used as an example to set up the UI, they should actually be set by the backend from a dictionnary (.csv)
  String startWord = 'pan';
  String endWord = 'planter';
  List<Letter> modifiedWord = [
    Letter(value: 'p', index: 0, isStart: true),
    Letter(value: 'a', index: 1, isStart: true),
    Letter(value: 'n', index: 2, isStart: true),
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _checkBlueLetter() {
  int blueCount = modifiedWord.where((letter) => !letter.isStart).length;
  _blueLetter = blueCount == 1;
}

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
        if (_remainingTime <= 0) {
          _timer.cancel();
          _showTimeUpDialog();
        }
      });
    });
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Time\'s Up!'),
          content: Text('Your time has run out...'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                      (route) => false,
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => PlayPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: Text(
                    'Restart',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void onLetterSelected(String letter) {
    setState(() {
      modifiedWord.add(Letter(value: letter, index: modifiedWord.length));
      if (isMatchWithWords(modifiedWord)) {
        // Turn all letters to isStart = true
        for (var i = 0; i < modifiedWord.length; i++) {
          modifiedWord[i] = Letter(
            value: modifiedWord[i].value,
            index: modifiedWord[i].index,
            isStart: true,
          );
        }
        // Update the color of the modified word
        setState(() {});
      }
      _checkBlueLetter();
      checkMatchEndWord();
    });
  }

  bool isMatchEndWord() {
    String currentWord = modifiedWord.map((letter) => letter.value).join();
    return currentWord == endWord;
  }

  void checkMatchEndWord() {
    if (isMatchEndWord()) {
      _timer.cancel(); // Stop the timer
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You have completed the word puzzle.'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                        (route) => false,
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 12.0,
                      ),
                    ),
                    child: Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => PlayPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 12.0,
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }
  }

  void onLetterAdded(Letter letter, int index) {
    setState(() {
      // Remove the element at the specified index
      modifiedWord.removeWhere((element) => element.index == letter.index);

      // Loop through the modifiedWord list
      for (int i = 0; i < modifiedWord.length; i++) {
        // If the letter is green (part of the word list), set it as not movable
        // If the index is greater than or equal to the added letter index
        if (modifiedWord[i].index >= index) {
          // Increment the index of the letter
          modifiedWord[i] = Letter(
            value: modifiedWord[i].value,
            index: modifiedWord[i].index + 1,
            isStart: modifiedWord[i].isStart,
          );
        }
      }

      // Insert the new letter at the specified index
      modifiedWord.insert(index, Letter(value: letter.value, index: index));

      // Check if the modified word is one of the allowed words
      if (isMatchWithWords(modifiedWord)) {
        // Turn all letters to isStart = true
        for (var i = 0; i < modifiedWord.length; i++) {
          modifiedWord[i] = Letter(
            value: modifiedWord[i].value,
            index: modifiedWord[i].index,
            isStart: true,
          );
        }
        // Update the color of the modified word
        setState(() {});
      }
      checkMatchEndWord();
      _checkBlueLetter();
    });
  }

  // Function to check if the word should be green
  bool isMatchWithWords(modifiedword) {
    List<String> allowedWords = ['pan', 'plan', 'plant', 'plante', 'planter'];
    String currentWord = modifiedWord.map((letter) => letter.value).join();
    return allowedWords.contains(currentWord);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Start and End Word Box
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  startWord,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 10), // Add some spacing between the words
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 32.0,
                ),
                SizedBox(
                    width:
                        10), // Add some spacing between the arrow and the word
                Text(
                  endWord,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
          ),
          // Timer Display
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _remainingTime <= 10
                    ? [Colors.red, Color.fromARGB(255, 207, 124, 124)]
                    : [Colors.blue, Colors.green],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Time Remaining: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '$_remainingTime s',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ModifiedWord
          Expanded(
            child: ModifiedWord(
              modifiedWord: modifiedWord,
              onLetterAdded: onLetterAdded,
            ),
          ),
          // Add padding at the bottom
          SizedBox(height: 16.0),
          // Alphabet
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Alphabet(
              onLetterSelected: onLetterSelected,
              allLettersGreen: _blueLetter,
              updateAlphabetState:
                  _checkBlueLetter, // Pass the callback function
            ),
          ),
        ],
      ),
    );
  }
}

class ModifiedWord extends StatefulWidget {
  final List<Letter> modifiedWord;
  final Function(Letter, int) onLetterAdded;

  ModifiedWord({
    required this.modifiedWord,
    required this.onLetterAdded,
  });

  @override
  _ModifiedWordState createState() => _ModifiedWordState();
}

class _ModifiedWordState extends State<ModifiedWord> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.modifiedWord.map((letter) {
          return Draggable<Letter>(
            data: letter,
            feedback: Material(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  letter.value,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            child: DragTarget<Letter>(
              onWillAcceptWithDetails: (details) {
                return true;
              },
              onAcceptWithDetails: (details) {
                widget.onLetterAdded(details.data, letter.index);
              },
              builder: (context, candidateData, rejectedData) {
                return ModifiedLetter(letter: letter);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ModifiedLetter extends StatefulWidget {
  final Letter letter;

  ModifiedLetter({required this.letter});

  @override
  _ModifiedLetterState createState() => _ModifiedLetterState();
}

class _ModifiedLetterState extends State<ModifiedLetter> {
  late Color color;

  @override
  void initState() {
    super.initState();
    updateColor();
  }

  @override
  void didUpdateWidget(covariant ModifiedLetter oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateColor();
  }

  void updateColor() {
    setState(() {
      color = widget.letter.isStart ? Colors.green : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        widget.letter.value,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

// letters can be added to the modified word by clicking on them, but we need to implement a drag and drop for these as well
class Alphabet extends StatelessWidget {
  final List<String> letters = 'abcdefghijklmnopqrstuvwxyz'.split('');

  final Function(String) onLetterSelected;
  final bool allLettersGreen;
  final VoidCallback updateAlphabetState; // Callback function

  Alphabet(
      {required this.onLetterSelected,
      required this.allLettersGreen,
      required this.updateAlphabetState});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 5,
        runSpacing: 5,
        children: letters.map((letter) {
          return GestureDetector(
            onTap: allLettersGreen
                ? null
                : () {
                    onLetterSelected(letter);
                    updateAlphabetState(); // Call the callback function here
                  },
            child: Container(
              width: 30,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 2),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: allLettersGreen ? Colors.grey : Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  letter,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'English'; // Default language
  String _customDictionaryUri = ''; // URI for custom dictionary

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Language:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedLanguage = newValue;
                    });
                  }
                },
                items: <String>['English', 'French']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                icon: Icon(Icons.arrow_drop_down),
              ),
              SizedBox(height: 20.0),
              Text(
                'Custom Dictionary URI:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter URI for custom dictionary',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _customDictionaryUri = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Letter {
  final String value;
  final int index;
  final bool isStart;

  Letter({
    required this.value,
    required this.index,
    this.isStart = false, // Default value is false
  });
}
