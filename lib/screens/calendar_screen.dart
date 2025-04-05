import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  Map<String, String> _notes = {};

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  // Lấy dữ liệu ghi chú từ SharedPreferences
  Future<void> _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notes = Map<String, String>.from(json.decode(prefs.getString('calendar_notes') ?? '{}'));
    });
  }

  // Lưu dữ liệu ghi chú vào SharedPreferences
  Future<void> _saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('calendar_notes', json.encode(_notes));
  }

  void _addNoteDialog() {
    TextEditingController _noteController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Đảm bảo không bị tràn màn hình
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Thêm ghi chú", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(hintText: "Nhập ghi chú"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Hủy"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _notes[_selectedDay.toIso8601String()] = _noteController.text;
                      _saveNotes();
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Lưu"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _deleteNote() {
    setState(() {
      _notes.remove(_selectedDay.toIso8601String());
      _saveNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lịch")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _selectedDay,
              calendarFormat: _calendarFormat,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Ghi chú: ${_notes[_selectedDay.toIso8601String()] ?? "Không có ghi chú"}",
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _addNoteDialog,
                        child: Text("Thêm ghi chú"),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _deleteNote,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: Text("Xóa ghi chú"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
