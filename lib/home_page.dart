import 'package:flutter/material.dart';
import 'package:phdetect/camera_screen.dart';
import 'package:phdetect/history_screen.dart';
import 'package:phdetect/main.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _pickFile(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles();

      if (result !=null) {
        String? filePath = result.files.single.path;
        print('File picked: $filePath');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255,18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          Home(),
        ]),
        bottomNavigationBar: Container(
          height: 80,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.camera,
                  size: 45,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'Soil History',
              ),
            ],
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            currentIndex: 0,
            onTap: (index) {
              if(index == 0) {
          
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraScreen(cameras)
                  )
                );
              } else if (index == 2) {
                                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryScreen()
                  )
                );
                
              }
            }
          ),
        )
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xFFFCFCFC),
        child: Column(
          children: [
            Container(
              width: 428,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Color(0xFFFCFCFC),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 64,
                    child: Center(
                      child: Container(
                        width: 350,
                        padding: const EdgeInsets.symmetric(horizontal:18, vertical: 18),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 350,
                                    height: 28,
                                    child: Text(
                                      'Kumusta, Ka-soil!',
                                      style: TextStyle(
                                        color: Color(0xFF006D18),
                                        fontSize: 27,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w800,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                      height: 320,
                      child: Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 350,
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/home1.png'),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),  
                          ],
                        ),
                      )
                    ),
                  Container(
                    height: 340,
                    child: Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 350,
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/home2.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 350,
                    child: Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 350,
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/home3.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}


