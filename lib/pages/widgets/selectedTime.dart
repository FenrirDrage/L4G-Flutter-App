import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  final String text;
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onTimeSelected;

  TimePicker({
    Key? key,
    required this.text,
    required this.initialTime,
    required this.onTimeSelected,
  }) : super(key: key);

  String getTime() {
    return '${initialTime.hour}:${initialTime.minute}';
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null && picked != initialTime) {
      onTimeSelected(picked);
    }
  }

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
        SizedBox(height: 4.0),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => _selectTime(context),
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
              child: Text('Selecionar Hora'),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Text(
                'Hora: ${getTime()}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
