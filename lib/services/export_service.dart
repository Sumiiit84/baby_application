import 'dart:convert';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

class ExportService {
  /// Get temporary directory safely
  static Future<String> _getTempPath() async {
    try {
      final dir = await getTemporaryDirectory();
      return dir.path;
    } catch (e) {
      debugPrint("❌ Error getting temp path: $e");
      rethrow;
    }
  }

  /// Export data as JSON
  static Future<void> exportData(int days) async {
    try {
      final now = DateTime.now();
      final fromDate = now.subtract(Duration(days: days));

      final eventsBox = await Hive.openBox('events');
      final moodsBox = await Hive.openBox('moods');

      final List<Map<String, dynamic>> exportList = [];

      // Events
      for (var e in eventsBox.values) {
        try {
          final data = Map<String, dynamic>.from(e);
          final time = DateTime.parse(data['timestamp']);
          if (time.isAfter(fromDate)) {
            exportList.add({
              'type': data['type'],
              'details': data['details'],
              'timestamp': time.toIso8601String(),
            });
          }
        } catch (err) {
          debugPrint("⚠️ Skipping invalid event: $err");
        }
      }

      // Moods
      for (var key in moodsBox.keys) {
        try {
          final data = Map<String, dynamic>.from(moodsBox.get(key));
          final time = DateTime.parse(data['timestamp']);
          if (time.isAfter(fromDate)) {
            exportList.add({
              'type': 'mood',
              'details': 'Mood: ${data['value']}, Note: ${data['note']}',
              'timestamp': time.toIso8601String(),
            });
          }
        } catch (err) {
          debugPrint("⚠️ Skipping invalid mood: $err");
        }
      }

      exportList.sort(
        (a, b) => DateTime.parse(
          b['timestamp'],
        ).compareTo(DateTime.parse(a['timestamp'])),
      );

      final jsonData = jsonEncode(exportList);

      final tempPath = await _getTempPath();
      final file = File('$tempPath/baby_mood_export_${days}days.json');
      await file.writeAsString(jsonData);

      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Baby & Mood Tracker – last $days days (JSON)');
      debugPrint("✅ Exported JSON successfully to ${file.path}");
    } catch (e, s) {
      debugPrint("❌ Export JSON failed: $e\n$s");
    }
  }

  /// Export data as CSV
  static Future<void> exportCSV(int days) async {
    try {
      final now = DateTime.now();
      final fromDate = now.subtract(Duration(days: days));

      final eventsBox = await Hive.openBox('events');
      final moodsBox = await Hive.openBox('moods');

      final buffer = StringBuffer();
      buffer.writeln('Type,Details,Timestamp');

      // Events
      for (var e in eventsBox.values) {
        try {
          final data = Map<String, dynamic>.from(e);
          final time = DateTime.parse(data['timestamp']);
          if (time.isAfter(fromDate)) {
            buffer.writeln(
              '"${data['type']}","${data['details']}","${DateFormat('yyyy-MM-dd HH:mm').format(time)}"',
            );
          }
        } catch (err) {
          debugPrint("⚠️ Skipping invalid event row: $err");
        }
      }

      // Moods
      for (var key in moodsBox.keys) {
        try {
          final data = Map<String, dynamic>.from(moodsBox.get(key));
          final time = DateTime.parse(data['timestamp']);
          if (time.isAfter(fromDate)) {
            buffer.writeln(
              '"Mood","Mood: ${data['value']}, Note: ${data['note']}","${DateFormat('yyyy-MM-dd HH:mm').format(time)}"',
            );
          }
        } catch (err) {
          debugPrint("⚠️ Skipping invalid mood row: $err");
        }
      }

      final csvData = buffer.toString();

      final tempPath = await _getTempPath();
      final file = File('$tempPath/baby_mood_export_${days}days.csv');
      await file.writeAsString(csvData);

      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Baby & Mood Tracker – last $days days (CSV)');
      debugPrint("✅ Exported CSV successfully to ${file.path}");
    } catch (e, s) {
      debugPrint("❌ Export CSV failed: $e\n$s");
    }
  }
}
