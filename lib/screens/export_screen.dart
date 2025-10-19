import 'package:flutter/material.dart';
import '../services/export_service.dart';

class ExportScreen extends StatelessWidget {
  const ExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text("Export Data"),
        backgroundColor: Colors.pink[200],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "Export baby events and moods",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pink[900],
              ),
            ),
            const SizedBox(height: 40),
            _buildExportButton(
              context,
              "Export Last 7 Days (JSON)",
              () => ExportService.exportData(7),
            ),
            const SizedBox(height: 20),
            _buildExportButton(
              context,
              "Export Last 30 Days (JSON)",
              () => ExportService.exportData(30),
            ),
            const SizedBox(height: 20),
            _buildExportButton(
              context,
              "Export Last 7 Days (CSV)",
              () => ExportService.exportCSV(7),
            ),
            const SizedBox(height: 20),
            _buildExportButton(
              context,
              "Export Last 30 Days (CSV)",
              () => ExportService.exportCSV(30),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExportButton(
    BuildContext context,
    String text,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink[300],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 16),
        ),
        child: Text(text),
      ),
    );
  }
}
