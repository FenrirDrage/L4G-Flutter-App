import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DropdownInput extends StatefulWidget {
  final String text;
  final String selectedGame;
  final List<DropdownMenuItem<String>> games;
  final Function(String) onGameSelected;

  DropdownInput(
      {Key? key,
      required this.text,
      required this.selectedGame,
      required this.games,
      required this.onGameSelected})
      : super(key: key);

  @override
  _DropdownInputState createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {
  late String selectedGame;

  @override
  void initState() {
    super.initState();
    selectedGame = widget.selectedGame;
    _fetchGames();
  }

  Future<void> _fetchGames() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    String apiUrl = 'https://backend-q4m5.onrender.com/games';

    try {
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
          List<DropdownMenuItem<String>> gameItems = responseBody
              .map<DropdownMenuItem<String>>((game) => DropdownMenuItem<String>(
                    value: game['name'] as String,
                    child: Text(game['name'] as String),
                  ))
              .toList();

          setState(() {
            widget.games.clear();
            widget.games.addAll(gameItems);

            // Verifique se o valor selecionado ainda está na lista
            if (!widget.games.any((item) => item.value == selectedGame)) {
              selectedGame = widget.games.isNotEmpty
                  ? widget.games
                          .firstWhere((item) => item.value != null,
                              orElse: () => DropdownMenuItem<String>(
                                  value: '', child: Text('')))
                          .value ??
                      ''
                  : '';
              widget.onGameSelected(selectedGame);
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
      // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedGame,
          onChanged: (value) {
            setState(() {
              selectedGame = value!;
            });
            widget.onGameSelected(value!);
          },
          items: widget.games,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xFF000B45),
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xFF000B45),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xFF000B45),
                width: 2.0,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
