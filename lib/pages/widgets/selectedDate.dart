import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatelessWidget {
  final String text;
  final DateTime initialDateTime;
  final Function(DateTime) onDateTimeSelected;

  DateTimePicker({
    Key? key,
    required this.text,
    required this.initialDateTime,
    required this.onDateTimeSelected,
  }) : super(key: key);

  String getDate() {
    return DateFormat("dd-MM-yyyy").format(initialDateTime);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != initialDateTime) {
      onDateTimeSelected(DateTime(
        picked.year,
        picked.month,
        picked.day,
        initialDateTime.hour,
        initialDateTime.minute,
      ));
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(initialDateTime));

    if (picked != null) {
      onDateTimeSelected(DateTime(
        initialDateTime.year,
        initialDateTime.month,
        initialDateTime.day,
        picked.hour,
        picked.minute,
      ));
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
        Row(
          children: [
            ElevatedButton(
              onPressed: () => _selectDate(context),
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
              child: Text('Selecionar Data'),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Text(
                'Data: ${getDate()}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
