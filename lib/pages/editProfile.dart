import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:projeto/pages/widgets/baseWidget.dart';
import 'package:projeto/pages/widgets/inputText.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userAgeController = TextEditingController();
  TextEditingController userTagController = TextEditingController();
  TextEditingController userBioController = TextEditingController();
  TextEditingController userDiscordController = TextEditingController();
  TextEditingController userPhotoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call the function that checks and requests permissions here
    checkAndRequestPermissions();
  }

  Future<void> checkAndRequestPermissions() async {
    // Check and request necessary permissions here
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.location,
      Permission.storage,
    ].request();

    if (statuses[Permission.camera] == PermissionStatus.denied) {
      // Additional logic to handle camera permission denial
    }

    if (statuses[Permission.location] == PermissionStatus.restricted) {
      // Additional logic to handle location restrictions
    }

    if (statuses[Permission.storage] == PermissionStatus.denied) {
      // Additional logic to handle storage permission denial
    }
  }

  Future<void> _saveProfile() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      String apiUrl = 'https://backend-q4m5.onrender.com/users';

      Map<String, dynamic> profileData = {
        "name": userNameController.text,
        "username": userTagController.text,
        "age": userAgeController.text,
        "bio": userBioController.text,
        "discordAccount": userDiscordController.text,
        "photo": userPhotoController.text,
        // Add other profile data as needed
      };

      var response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(profileData),
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully');
        // Show a success pop-up
        _showSuccessDialog();

        // Navigate to the baseWidget (correntIndexPage[3])
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BaseWidget(
                    currentPageIndex: 3,
                  )),
        );
      } else {
        print('Failed to update profile. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        // Handle error, e.g., show an error message
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  // Function to show a success pop-up
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Successful'),
          content: Text('You have successfully logged in.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fechar o diálogo
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Color(0xFF000B45),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputText(text: "Name", controller: userNameController),
              SizedBox(height: 16.0),
              InputText(text: "username", controller: userTagController),
              SizedBox(height: 16.0),
              InputText(text: "Age", controller: userAgeController),
              SizedBox(height: 16.0),
              InputText(
                  text: "Bio", controller: userBioController, maxLines: 3),
              SizedBox(height: 16.0),
              InputText(text: "Photo Link", controller: userPhotoController),
              SizedBox(height: 16.0),
              InputText(
                  text: "Discord Account", controller: userDiscordController),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  List<Media>? results = await ImagesPicker.pick(
                    pickType: PickType.image,
                  );
                },
                child: Text("GALERIA"),
              ),
              ElevatedButton(
                onPressed: () {
                  ImagesPicker.openCamera(
                    pickType: PickType.image,
                  );
                },
                child: Text("CAMARA"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _saveProfile();
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
                  child: Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
