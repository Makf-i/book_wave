import 'package:book_wave/screens/available.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DateTime? _selectedDate;

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Boat Tickets",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Container(
              height: 150,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: [
                  TextButton.icon(
                    onPressed: _datePicker,
                    label: Text(_selectedDate == null
                        ? "Select date"
                        : DateFormat.yMd().format(_selectedDate!)),
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.lightBlue)),
                  ),
                  TextButton(
                      onPressed: _selectedDate == null
                          ? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please select a date"),
                                ),
                              );
                            }
                          : () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AvailableBoats(
                                    date: _selectedDate!,
                                  ),
                                ),
                              );
                            },
                      child: const Text("Show available boats"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
