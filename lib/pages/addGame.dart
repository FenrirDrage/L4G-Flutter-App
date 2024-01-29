import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:projeto/pages/widgets/baseWidget.dart';
import 'package:projeto/pages/widgets/inputText.dart';

class AddGame extends StatefulWidget {
  const AddGame({Key? key}) : super(key: key);

  @override
  State<AddGame> createState() => _AddGameState();
}

class _AddGameState extends State<AddGame> {
  // Controllers para os campos de input
  TextEditingController gameNameController = TextEditingController();
  TextEditingController gameThumbnailController = TextEditingController();
  TextEditingController gameGenreController = TextEditingController();
  TextEditingController gamePlataformController = TextEditingController();
  // LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Game"),
        backgroundColor: Color(0xFF000B45),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputText(text: "Name", controller: gameNameController),
              SizedBox(height: 16.0),
              Text(
                "Thumnail",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF000B45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    minimumSize: Size(150.0, 0),
                  ),
                  onPressed: () async {
                    List<Media>? results = await ImagesPicker.pick(
                      pickType: PickType.image,
                    );
                  },
                  child: Text("Select")),
              SizedBox(height: 16.0),
              InputText(text: "Thumbnail", controller: gameThumbnailController),
              SizedBox(height: 16.0),
              InputText(text: "Genre", controller: gameGenreController),
              SizedBox(height: 16.0),
              InputText(text: "Plataform", controller: gamePlataformController),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BaseWidget(
                        currentPageIndex:
                            3), // Define o índice para 3 (Profile)
                  ));
                  //! Lógica para salvar os dados
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
