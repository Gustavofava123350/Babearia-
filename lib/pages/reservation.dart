import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  String _selectedService = 'Corte de Cabelo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reservation')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/wallpaper.jpg'), // Certifique-se de que o caminho está correto
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar(
                firstDay: DateTime(2020, 1, 1),
                lastDay: DateTime(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  saveReservation(_selectedService, _selectedDay);
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Escolha uma Categoria de Estilo:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Expanded(
                child: ListView(
                  children: [
                    StyleCategory(categoryName: 'Corte de Cabelo', icon: Icons.content_cut, onSelect: () => _selectedService = 'Corte de Cabelo'),
                    StyleCategory(categoryName: 'Coloração', icon: Icons.brush, onSelect: () => _selectedService = 'Coloração'),
                    StyleCategory(categoryName: 'Estilo', icon: Icons.style, onSelect: () => _selectedService = 'Estilo'),
                    StyleCategory(categoryName: 'Barba', icon: Icons.style_outlined, onSelect: () => _selectedService = 'Barba'),
                    StyleCategory(categoryName: 'Corte de barba', icon: Icons.content_cut_rounded, onSelect: () => _selectedService = 'Corte de barba'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void saveReservation(String service, DateTime date) {
  FirebaseFirestore.instance.collection('reservations').add({
    'service': service,
    'date': date.toIso8601String(),
    'timestamp': FieldValue.serverTimestamp(),
  });
}

class StyleCategory extends StatelessWidget {
  final String categoryName;
  final IconData icon;
  final VoidCallback onSelect;

  const StyleCategory({super.key, required this.categoryName, required this.icon, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(categoryName),
        onTap: () {
          // Ação ao selecionar categoria
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selecionado: $categoryName')),
          );
          onSelect();
        },
      ),
    );
  }
}
