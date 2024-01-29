// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapPicker extends StatefulWidget {
//   final String text;
//   final Function(LatLng) onLocationSelected;

//   const MapPicker({
//     Key? key,
//     required this.text,
//     required this.onLocationSelected,
//   }) : super(key: key);

//   @override
//   _MapPickerState createState() => _MapPickerState();
// }

// class _MapPickerState extends State<MapPicker> {
//   late GoogleMapController mapController;
//   LatLng? selectedCoordinates;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         onMapCreated: (controller) {
//           setState(() {
//             mapController = controller;
//           });
//         },
//         onTap: (latLng) {
//           setState(() {
//             selectedCoordinates = latLng;
//           });
//         },
//         initialCameraPosition: CameraPosition(
//           target: LatLng(0, 0),
//           zoom: 2,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Retorna as coordenadas selecionadas à tela anterior
//           widget.onLocationSelected(selectedCoordinates!);
//         },
//         child: Icon(Icons.check),
//       ),
//     );
//   }
// }
