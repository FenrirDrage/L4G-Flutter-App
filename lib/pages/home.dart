import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/pages/searchPage.dart';
import 'package:projeto/pages/widgets/eventCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<Event> events = [];

  get allEvents => null;
  //String? _token;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    String apiUrl = 'https://backend-q4m5.onrender.com/events';

    try {
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print(response);

      if (response.statusCode == 200) {
        dynamic responseBody = json.decode(response.body);
        if (responseBody is List) {
          setState(() {
            events =
                responseBody.map((event) => Event.fromJson(event)).toList();
          });
        } else {
          print('Unexpected response from API');
        }
      } else {
        print('Failed to fetch events. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
      // ignore: empty_catches
    } catch (err) {
      // Handle errors
    }
  }

  void _navigateToSearchScreen(List<Event> searchResults) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchScreen(searchResults: searchResults),
      ),
    );
  }

  void _filterEvents(String searchTerm) {
    List<Event> searchResults = events
        .where((event) =>
            event.gameName!.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();

    _navigateToSearchScreen(searchResults);
  }

  @override
  Widget build(BuildContext context) {
    print('Number of events: ${events.length}'); // Add this line
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Color(0xFF000B45),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            width: 380,
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: const Color.fromARGB(255, 0, 0, 0)),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onSubmitted: (searchTerm) {
                      _filterEvents(
                          searchTerm); // Agora, passe o searchTerm para _filterEvents
                    },
                    decoration: InputDecoration(
                      hintText: 'Search a game event',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    EventCard(
                      imageUrl: events[index].imageUrl ?? "",
                      eventTitle: events[index].eventTitle ?? "",
                      dateAndTime: events[index].dateAndTime ?? "",
                      discordAccount: events[index].discordAccount ?? "",
                      gameName: events[index].gameName ?? "",
                      ageLimit: " ${events[index].ageLimit}" ?? "",
                      description: events[index].description ?? "",
                    ),
                    SizedBox(height: 16.0),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class Event {
  final String? imageUrl;
  final String? eventTitle;
  final String? dateAndTime;
  final String? discordAccount;
  final String? gameName;
  final int? ageLimit;
  final String? description;

  Event({
    required this.imageUrl,
    required this.eventTitle,
    required this.dateAndTime,
    required this.discordAccount,
    required this.gameName,
    required this.ageLimit,
    required this.description,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      imageUrl: json['thumbnailGame'],
      eventTitle: json['name'],
      dateAndTime: json['date'],
      discordAccount: json['discordAccount'],
      gameName: json['nameGame'],
      ageLimit: json['ageLimit'],
      description: json['description'],
    );
  }
}
