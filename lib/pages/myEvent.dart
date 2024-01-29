import 'package:flutter/material.dart';
import 'package:projeto/pages/widgets/eventCard.dart';

class MyEvents extends StatefulWidget {
  const MyEvents({Key? key}) : super(key: key);

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  String selectedCategory = 'Favorites';

  // Lista fictícia de eventos (substitua por seus dados reais)
  List<EventData> events = [
    EventData(
      imageUrl:
          'https://media.gq-magazine.co.uk/photos/645b5c3c8223a5c3801b8b26/16:9/w_1280,c_limit/100-best-games-hp-b.jpg',
      eventTitle: 'TÍTULO DO EVENTO 1',
      userName: 'NOME DO USUÁRIO 1',
      dateAndTime: 'DATA E HORA 1',
    ),
    EventData(
      imageUrl:
          'https://www.lego.com/cdn/cs/set/assets/blt0f703dfbce999d88/Video-games-Juno-Carousel-card.jpg?fit=crop&format=jpg&quality=80&width=635&height=440&dpr=1',
      eventTitle: 'TÍTULO DO EVENTO 2',
      userName: 'NOME DO USUÁRIO 2',
      dateAndTime: 'DATA E HORA 2',
    ),
    // Adicione mais eventos conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Events"),
        backgroundColor: Color(0xFF000B45),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(height: 8.0),
          Container(
            height: 47,
            width: 390,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // !categoria selecionada como "Os Meus Eventos"
                      setState(() {
                        selectedCategory = 'Favorites';
                      });
                    },
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: selectedCategory == 'Favorites'
                            ? Color(0xFF000B45)
                            : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Favorites",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      //! Categoria selecionada como "Favoritos"
                      setState(() {
                        selectedCategory = 'Subscribed';
                      });
                    },
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: selectedCategory == 'Subscribed'
                            ? Color(0xFF000B45)
                            : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Subscribed',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //? DADOS DE EVENTOS
          SizedBox(
            height: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: events.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: EventCard(
                      imageUrl: events[index].imageUrl,
                      eventTitle: events[index].eventTitle,
                      dateAndTime: events[index].dateAndTime,
                      discordAccount: '',
                      gameName: '',
                      ageLimit: '',
                      description: '',
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Classe de dados do evento
class EventData {
  final String imageUrl;
  final String eventTitle;
  final String userName;
  final String dateAndTime;

  EventData({
    required this.imageUrl,
    required this.eventTitle,
    required this.userName,
    required this.dateAndTime,
  });
}
