import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final int? maxLines; // Adicionado para suportar maxLines

  InputText(
      {Key? key, required this.text, required this.controller, this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 4.0,
        ),
        TextFormField(
          maxLines:
              maxLines, // Usando o maxLines fornecido ou nulo se não for fornecido
          controller: controller,
          decoration: InputDecoration(
            // labelText: 'Nome do Evento',
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
      ],
    );
  }
}
