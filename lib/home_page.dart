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
                                  width: 227,
                                  height: 28,
                                  child: Text(
                                    'Good Day, Ka-soil',
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
                  height: 295,
                  child: Center(
                    child: Container(
                      width: 350,
                      padding: const EdgeInsets.symmetric(horizontal:18, vertical: 18),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/home1.png'),
                          fit:BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
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
                                  width: 227,
                                  height: 28,
                                  child: Text(
                                    'What is pH?',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w800,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 11),
                                SizedBox(
                                  width: 323,
                                  child: Text(
                                    'Soil pH is a measure of the acidity or alkalinity of the soil.\n\nA pH value is actually a measure of hydrogen ion concentration. Because hydrogen ion concentration varies over a wide range, a logarithmic scale (pH) is used: for a pH decrease of 1, the acidity increases by a factor of 10.\n',
                                    style: TextStyle(
                                      color: Color(0xFFFCFCFC),
                                      fontSize: 18,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
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
                  height: 290,
                  child: Center(
                    child: Container(
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
                                  width: 227,
                                  height: 28,
                                  child: Text(
                                    'Soil pH',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w800,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 11),
                                SizedBox(
                                  width: 323,
                                  child: Text(
                                    'Soils can be naturally acid or alkaline, and this can be measured by testing their pH value.\nHaving the correct pH is important for healthy plant growth. Being aware of the long-term effects of different soil management practices on soil pH is also important. Research has demonstrated that some agricultural practices significantly alter soil pH.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  height: 340, //height of the container for effects
                  child: Center(
                    child: Container(
                      width: 350,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 300,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 227,
                                  height: 28,
                                  child: Text(
                                    'Effects',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w800,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                SizedBox(
                                  width: 323,
                                  child: Text(
                                    'The development of strongly acidic soils (less than 5.5 pH) can result in poor plant growth as a result of one or more of the following factors:\n\naluminum toxicity\nmanganese toxicity\ncalcium deficiency\nmagnesium deficiency\nlow levels of essential plant nutrients such as phosphorus and molybdenum.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),                  
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


