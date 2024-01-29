import 'package:flutter/material.dart';
import 'package:projeto/pages/home.dart';
import 'package:projeto/pages/widgets/eventCard.dart';

class SearchScreen extends StatelessWidget {
  final List<Event> searchResults;

  const SearchScreen({Key? key, required this.searchResults}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
        backgroundColor: Color(0xFF000B45),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 8.0), // Ajuste a distância conforme necessário
        child: ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                EventCard(
                  imageUrl: searchResults[index].imageUrl ?? "",
                  eventTitle: searchResults[index].eventTitle ?? "",
                  dateAndTime: searchResults[index].dateAndTime ?? "",
                  discordAccount: searchResults[index].discordAccount ?? "",
                  gameName: searchResults[index].gameName ?? "",
                  ageLimit: " ${searchResults[index].ageLimit}" ?? "",
                  description: searchResults[index].description ?? "",
                ),
                SizedBox(height: 16.0),
              ],
            );
          },
        ),
      ),
    );
  }
}
