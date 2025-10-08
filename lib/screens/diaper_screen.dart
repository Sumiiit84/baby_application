import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/event.dart';

class DiaperScreen extends StatefulWidget {
  const DiaperScreen({super.key});

  @override
  State<DiaperScreen> createState() => _DiaperScreenState();
}

class _DiaperScreenState extends State<DiaperScreen> {
  String _type = "Wet";

  Future<void> _saveDiaper() async {
    final box = Hive.box('events');
    final event = Event(
      type: EventType.diaper,
      details: _type,
      timestamp: DateTime.now(),
    );
    await box.add(event.toJson());

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Diaper change saved: $_type"),
        backgroundColor: Colors.pink[300],
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text("Log Diaper Change"),
        backgroundColor: Colors.pink[200],
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Diaper Type",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<String>(
                  value: _type,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items:
                      ["Wet", "Dirty", "Mixed"].map((t) {
                        return DropdownMenuItem(value: t, child: Text(t));
                      }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _type = val!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveDiaper,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[300],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text("Save Diaper Change"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
