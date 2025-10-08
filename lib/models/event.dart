enum EventType { feeding, diaper, sleep }

class Event {
  final EventType type;
  final String details;
  final DateTime timestamp;

  Event({required this.type, required this.details, required this.timestamp});

  Map<String, dynamic> toJson() => {
    'type': type.toString(),
    'details': details,
    'timestamp': timestamp.toIso8601String(),
  };

  /// Convert JSON map back to Event
  static Event fromJson(Map<String, dynamic> json) {
    final typeString = json['type'] as String? ?? 'EventType.feeding';
    final matchedType = EventType.values.firstWhere(
      (e) => e.toString() == typeString,
      orElse: () => EventType.feeding,
    );

    return Event(
      type: matchedType,
      details: json['details'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
