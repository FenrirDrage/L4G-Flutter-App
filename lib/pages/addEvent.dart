import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projeto/pages/widgets/baseWidget.dart';
import 'package:projeto/pages/widgets/dropdownInput.dart';
import 'package:projeto/pages/widgets/inputText.dart';
import 'package:projeto/pages/widgets/selectedDate.dart';
import 'package:projeto/pages/widgets/selectedTime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController ageLimitController = TextEditingController();
  TextEditingController localController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController discordAccountController = TextEditingController();
  TextEditingController thumnailGameController = TextEditingController();
  String selectedGame = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  List<String> games = []; // Lista de jogos

  @override
  void initState() {
    super.initState();
    _fetchGames();
  }

  Future<void> _fetchGames() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      String apiUrl = 'https://backend-q4m5.onrender.com/games';

      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        dynamic responseBody = json.decode(response.body);
        if (responseBody is List) {
          setState(() {
            games = responseBody
                .map<String>((game) => game['name'] as String)
                .toList();
            if (games.isNotEmpty) {
              selectedGame = games[0];
            }
          });
        } else {
          print('Unexpected response from API');
        }
      } else {
        print('Failed to fetch games. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (err) {
      print('Error fetching games: $err');
    }
  }

  Future<void> _saveEvent() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      String apiUrl = 'https://backend-q4m5.onrender.com/events';

      Map<String, dynamic> eventData = {
        "name": eventNameController.text,
        "nameGame": selectedGame,
        "thumbnailGame": thumnailGameController.text,
        "discordAccount": discordAccountController.text,
        "date": selectedDate.toIso8601String(),
        "hour": selectedTime.format(context),
        "ageLimit": ageLimitController.text,
        "local": localController.text,
        "description": descriptionController.text,
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(eventData),
      );

      if (response.statusCode == 201) {
        print('Event saved successfully');
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => BaseWidget(currentPageIndex: 3),
        ));
      } else {
        print('Failed to save event. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        // Handle error, e.g., show an error message
      }
    } catch (e) {
      print('Error saving event: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Event"),
        backgroundColor: Color(0xFF000B45),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputText(
                text: "Event Name",
                controller: eventNameController,
              ),
              SizedBox(height: 16.0),
              InputText(
                text: "Favorite game photo",
                controller: thumnailGameController,
              ),
              SizedBox(height: 16.0),
              DropdownInput(
                text: "Game",
                selectedGame: selectedGame,
                games: games.map((game) {
                  return DropdownMenuItem<String>(
                    value: game,
                    child: Text(game),
                  );
                }).toList(),
                onGameSelected: (game) {
                  setState(() {
                    selectedGame = game;
                  });
                },
              ),
              SizedBox(height: 16.0),
              DateTimePicker(
                text: "Date",
                initialDateTime: selectedDate,
                onDateTimeSelected: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TimePicker(
                text: "Hour",
                initialTime: selectedTime,
                onTimeSelected: (newTime) {
                  setState(() {
                    selectedTime = newTime;
                  });
                },
              ),
              SizedBox(height: 16.0),
              InputText(
                text: "Discord Account",
                controller: discordAccountController,
              ),
              SizedBox(height: 16.0),
              InputText(
                text: "Age Limit",
                controller: ageLimitController,
              ),
              SizedBox(height: 16.0),
              InputText(
                text: "Local",
                controller: localController,
              ),
              SizedBox(height: 16.0),
              InputText(
                text: "Description",
                controller: descriptionController,
                maxLines: 3,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _saveEvent();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF000B45),
                  foregroundColor: Colors.white,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                ),
                child: Container(
                  height: 36,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
