import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../models/event.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  Color _getEventColor(EventType type) {
    switch (type) {
      case EventType.feeding:
        return Colors.pink[200]!;
      case EventType.diaper:
        return Colors.green[200]!;
      case EventType.sleep:
        return Colors.deepPurple[200]!;
      default:
        return Colors.grey;
    }
  }

  IconData _getEventIcon(EventType type) {
    switch (type) {
      case EventType.feeding:
        return Icons.local_drink;
      case EventType.diaper:
        return Icons.baby_changing_station;
      case EventType.sleep:
        return Icons.bedtime;
      default:
        return Icons.event;
    }
  }

  String _formatTimestamp(DateTime time) {
    return DateFormat('MMM d, h:mm a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('events');

    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text("Timeline / History"),
        backgroundColor: Colors.pink[200],
        elevation: 0,
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.hourglass_empty, size: 60, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    "No events logged yet.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final events =
              box.values
                  .map((e) => Event.fromJson(Map<String, dynamic>.from(e)))
                  .toList()
                ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              final color = _getEventColor(event.type);
              final icon = _getEventIcon(event.type);
              final time = _formatTimestamp(event.timestamp);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color,
                    child: Icon(icon, color: Colors.white),
                  ),
                  title: Text(
                    event.details,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(time, style: const TextStyle(fontSize: 14)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
