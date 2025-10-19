import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  double _moodValue = 3; // 1–5 scale
  final _noteController = TextEditingController();
  bool _alreadyLogged = false;

  @override
  void initState() {
    super.initState();
    _checkTodayMood();
  }

  Future<void> _checkTodayMood() async {
    final box = await Hive.openBox('moods');
    final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (box.containsKey(todayKey)) {
      final moodData = Map<String, dynamic>.from(box.get(todayKey));
      setState(() {
        _alreadyLogged = true;
        _moodValue = moodData['value']?.toDouble() ?? 3;
        _noteController.text = moodData['note'] ?? '';
      });
    }
  }

  Future<void> _saveMood() async {
    final box = await Hive.openBox('moods');
    final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final moodData = {
      'value': _moodValue,
      'note': _noteController.text.trim(),
      'timestamp': DateTime.now().toIso8601String(),
    };

    await box.put(todayKey, moodData);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Today's mood saved successfully!"),
        backgroundColor: Colors.pink[300],
      ),
    );

    Navigator.pop(context);
  }

  IconData _getMoodIcon(double value) {
    if (value <= 1.5) return Icons.sentiment_very_dissatisfied;
    if (value <= 2.5) return Icons.sentiment_dissatisfied;
    if (value <= 3.5) return Icons.sentiment_neutral;
    if (value <= 4.5) return Icons.sentiment_satisfied;
    return Icons.sentiment_very_satisfied;
  }

  Color _getMoodColor(double value) {
    if (value <= 1.5) return Colors.red[300]!;
    if (value <= 2.5) return Colors.orange[300]!;
    if (value <= 3.5) return Colors.amber[300]!;
    if (value <= 4.5) return Colors.lightGreen[300]!;
    return Colors.green[400]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text("Track Mood"),
        backgroundColor: Colors.pink[200],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                "How are you feeling today?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.pink[900],
                ),
              ),
              const SizedBox(height: 30),
              Icon(
                _getMoodIcon(_moodValue),
                color: _getMoodColor(_moodValue),
                size: 80,
              ),
              const SizedBox(height: 30),
              Slider(
                value: _moodValue,
                min: 1,
                max: 5,
                divisions: 4,
                label: _moodValue.toStringAsFixed(0),
                activeColor: _getMoodColor(_moodValue),
                onChanged:
                    _alreadyLogged
                        ? null
                        : (val) => setState(() => _moodValue = val),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _noteController,
                enabled: !_alreadyLogged,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Add an optional note...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _alreadyLogged ? null : _saveMood,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[300],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: Text(_alreadyLogged ? "Already Logged" : "Save Mood"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
