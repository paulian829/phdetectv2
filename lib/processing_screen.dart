import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
                // ... (existing code)
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProcessingScreen extends StatefulWidget {
  final String imagePath;

  ProcessingScreen(this.imagePath);

  @override
  _ProcessingScreenState createState() => _ProcessingScreenState();
}
class Record {
  final String imagePath;
  final String pHLevel;
  final String pHLevelText;
  final List<String> cropSuggestions;

  Record({
    required this.imagePath,
    required this.pHLevel,
    required this.pHLevelText,
    required this.cropSuggestions,
  });

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'pHLevel': pHLevel,
      'pHLevelText': pHLevelText,
      'cropSuggestions': cropSuggestions,
    };
  }

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      imagePath: json['imagePath'],
      pHLevel: json['pHLevel'],
      pHLevelText: json['pHLevelText'],
      cropSuggestions: List<String>.from(json['cropSuggestions']),
    );
  }
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  String _pHLevel = '';
  String _pHLevelPredictedPercentage = '';
  String _pHLevelText = '';
  List<String> _cropSuggestions = [];

  @override
  void initState() {
    super.initState();
    _sendImageToAPI();
  }



Future<void> _sendImageToAPI() async {
  // Read the image file as bytes
  File imageFile = File(widget.imagePath);
  List<int> imageBytes = await imageFile.readAsBytes();

  // Create the request payload as form data
  var request = http.MultipartRequest('POST', Uri.parse('https://libanglang777.com/upload-image'));
  request.files.add(http.MultipartFile.fromBytes('image', imageBytes, filename: 'image.jpg'));

  // Send the POST request to the API endpoint
  var response = await request.send();

  // Parse the response and update the pH level
  if (response.statusCode == 200) {
    var responseData = await response.stream.bytesToString();
    Map<String, dynamic> decodedData = json.decode(responseData);
    String pHLevel = decodedData['predicted_class_label'].toString();
    String pHLevelText = decodedData['soil_suggestion_text'].toString();
    String pHLevelPredictedPercentage = decodedData['predicted_percentage'].toString() + '%';
    // Extract the crop suggestions from the API response
    List<dynamic> cropSuggestionsData = decodedData['crops_suggestions'];
    List<String> cropSuggestions = cropSuggestionsData.cast<String>();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> recordsJson = prefs.getStringList('records') ?? [];

    Record newRecord = Record(
      imagePath: widget.imagePath,
      pHLevel: pHLevel,
      pHLevelText: pHLevelText,
      cropSuggestions: cropSuggestions,
    );

    recordsJson.add(json.encode(newRecord.toJson()));
    await prefs.setStringList('records', recordsJson);

    setState(() {
      _pHLevel = pHLevel;
      _pHLevelPredictedPercentage = pHLevelPredictedPercentage;
      _pHLevelText = pHLevelText;
      _cropSuggestions = cropSuggestions;
    });

  } else {
    // Handle API error
    print('API request failed with status code: ${response.statusCode}');
  }
}

  @override
  Widget build(BuildContext context) {
    //image processing logic here

return Scaffold(  
    appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Color(0xFF006D18),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      // title: Text('Processing Screen'),
    ),
    body: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.file(
                      File(widget.imagePath),
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/ph_scale.png',
                          // width: 300,
                          height: 180,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'pH level',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        // SizedBox(height: 2),
                        Text(
                          _pHLevel,
                          style: TextStyle(
                            color: Color(0xFF006D18),
                            fontSize: 35,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Accuracy',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                                                Text(
                          _pHLevelPredictedPercentage,
                          style: TextStyle(
                            color: Color(0xFF006D18),
                            fontSize: 35,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ]
                    )
                  ),
                  SizedBox(height: 8),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF006D18),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          _pHLevelText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ]
                    )
                  ),
                  SizedBox(height: 8),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Crop Recommendations',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  BulletList(cropSuggestions: _cropSuggestions),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: ProcessingScreen('path_to_image'),
    )
  ));
}