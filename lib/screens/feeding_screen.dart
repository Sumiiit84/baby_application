import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/event.dart';

class FeedingScreen extends StatefulWidget {
  const FeedingScreen({super.key});

  @override
  State<FeedingScreen> createState() => _FeedingScreenState();
}

class _FeedingScreenState extends State<FeedingScreen> {
  String _type = "Breast";
  final _amountController = TextEditingController();

  Future<void> _saveFeeding() async {
    final amount = _amountController.text.trim();
    final parsedAmount = double.tryParse(amount);

    if (amount.isEmpty || parsedAmount == null || parsedAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please enter a valid amount in ml"),
          backgroundColor: Colors.pink[300],
        ),
      );
      return;
    }

    final box = Hive.box('events');
    final event = Event(
      type: EventType.feeding,
      details: "$_type - $amount ml",
      timestamp: DateTime.now(),
    );

    await box.add(event.toJson());

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Feeding saved: $_type - $amount ml"),
        backgroundColor: Colors.pink[300],
      ),
    );

    _amountController.clear();
    setState(() => _type = "Breast");

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text("Log Feeding"),
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
                "Feeding Type",
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
                      ["Breast", "Bottle", "Solid"].map((t) {
                        return DropdownMenuItem(value: t, child: Text(t));
                      }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _type = val!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: "Amount (ml)",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveFeeding,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[300],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text("Save Feeding"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
