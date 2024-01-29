import 'package:flutter/material.dart';

class MiniEventCard extends StatelessWidget {
  final String imageUrl;
  final String eventTitle;
  final String userName;
  final String dateAndTime;
  final String discordAccount;
  final String gameName;
  final String ageLimit;
  final String description;

  MiniEventCard({
    required this.imageUrl,
    required this.eventTitle,
    required this.userName,
    required this.dateAndTime,
    required this.discordAccount,
    required this.gameName,
    required this.ageLimit,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showEventDetails(context);
      },
      child: Container(
        width: 120,
        height: 200,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Color(0xFF000B45),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(3, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0), // Adiciona padding à imagem
              child: Container(
                width: 80,
                height: 62, // Reduz a altura para acomodar o padding
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                eventTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0), // Ajusta o padding geral
              child: ElevatedButton(
                onPressed: () {
                  _showEventDetails(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Color(0xFF000B45), // Cor do texto
                  side: BorderSide(color: Colors.blue), // Borda azul
                ),
                child: Text(
                  'Ver mais',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEventDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Stack(
            children: [
              Container(
                height: 500,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFF000B45),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventTitle,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          image: DecorationImage(
                            image: AssetImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: "Nome do Utilizador: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: "$userName",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: "Data / Hora: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: "$dateAndTime",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: "Discord account: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: "$discordAccount",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: "Nome do jogo: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: "$gameName",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: "Idade limite: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: "$ageLimit",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                  children: [
                                TextSpan(
                                  text: "Descrição: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: "$description",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ])))
                    ]),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

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
