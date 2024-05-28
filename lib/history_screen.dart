import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:phdetect/processing_screen.dart';


class BulletList extends StatelessWidget {
  final List<String> cropSuggestions;

  BulletList({required this.cropSuggestions});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cropSuggestions.length,
            itemBuilder: (context, index) => ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(Icons.fiber_manual_record, color: Colors.black, size: 12),
              title: Text(
                cropSuggestions[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> _imagePaths = [];
  List<String> _pHLevels = [];
  List<String> _pHLevelTexts = [];
  List<List<String>> _cropSuggestions = [];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

Future<void> _loadSavedData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> recordsJson = prefs.getStringList('records') ?? [];
  List<Record> records = recordsJson.map((json) => Record.fromJson(jsonDecode(json))).toList();

  List<String> imagePaths = [];
  List<String> pHLevels = [];
  List<String> pHLevelTexts = [];
  List<List<String>> cropSuggestions = [];

  for (Record record in records) {
    imagePaths.add(record.imagePath);
    pHLevels.add(record.pHLevel);
    pHLevelTexts.add(record.pHLevelText);
    cropSuggestions.add(record.cropSuggestions);
  }

  setState(() {
    _imagePaths = imagePaths;
    _pHLevels = pHLevels;
    _pHLevelTexts = pHLevelTexts;
    _cropSuggestions = cropSuggestions;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: ListView.builder(
        itemCount: _imagePaths.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(
                    File(_imagePaths[index]),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'pH Level: ${_pHLevels[index]}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Description: ${_pHLevelTexts[index]}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Crop Recommendations:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      BulletList(cropSuggestions: _cropSuggestions[index]),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}