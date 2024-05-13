import 'package:flutter/material.dart';
import 'package:phdetect/home_page.dart';
import 'package:camera/camera.dart';

late List<CameraDescription> cameras;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'pHDetect',

      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(''),
      //   ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/ph_logo.png',
                      width: 300,
                      height: 300,
                    )
                  ],
                ),
              ),
            ),
            Container(
              // width: 150,
              // height: 50,
              margin: EdgeInsets.all(40),
              child: ElevatedButton(
                onPressed: () {
                  //Add your button functionality here
                  // Navigate to the next screen when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF006D18)),
                  minimumSize: MaterialStateProperty.all(Size(150, 60)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: Text('Start',
                  style: TextStyle(
                    fontSize: 27, // Adjust the font size
                    fontWeight: FontWeight.bold, // Make it bold
                    color: Colors.white, // Set text color
                  ),
                ),
              ),
            )
          ],)
      );
    }
  }


