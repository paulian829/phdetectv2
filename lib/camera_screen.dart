import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:phdetect/processing_screen.dart';
import 'package:phdetect/snap_tips.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraScreen(this.cameras);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int _currentIndex = 0;
  bool _isFlashOn = false;
  bool _showSnapTipsOverlay = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    // _controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
    // // _controller.initialize().then((_) {
    // //   if (!mounted) {
    // //     return;
    // //   }
    // //   setState(() {});
    // // });
    // _initializeControllerFuture = _controller.initialize();
  }

  Future<void> _initializeCamera() async {
    _controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
    await _initializeControllerFuture;
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;

      if (_currentIndex == 0) {
        _onPhotosTapped();
      } else if (_currentIndex == 1) {
        _onCapturePressed();
      } else if (_currentIndex == 2) {
        _toggleSnapTipsOverlay();
      }
    });
  }

  void _onCapturePressed() async {
    try {
      final image = await _controller.takePicture();
      print('Image saved to ${image.path}');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProcessingScreen(image.path),
        ),
      );
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

void _onPhotosTapped() async {
  try {
    PermissionStatus permissionStatus = await Permission.storage.request();
    if (permissionStatus.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        String? filePath = result.files.single.path;
        print('File picked: $filePath');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProcessingScreen(filePath!),
          ),
        );
      }
    } else {
      print('Permission denied');
    }
  } catch (e) {
    print('Error picking file: $e');
  }
}

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
      _controller.setFlashMode(
        _isFlashOn ? FlashMode.torch : FlashMode.off);
    });
  }

  void _switchCamera() async {
    final lensDirection = _controller.description.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.back) {
      newDescription = widget.cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    } else {
      newDescription = widget.cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back);
    }

    if (newDescription != _controller.description) {
      await _controller.dispose();
      _controller = CameraController(newDescription, ResolutionPreset.medium);
      _initializeControllerFuture = _controller.initialize();
      await _initializeControllerFuture;
      _toggleFlash(); //Reset flash state
    }
  }

  void _toggleSnapTipsOverlay() {
    setState(() {
      _showSnapTipsOverlay = !_showSnapTipsOverlay;

      // Set the current index to the camera button when SnapTips is dismissed
      if (!_showSnapTipsOverlay) {
        _currentIndex = 1; // Index of the camera button
      }
    });
  }

  @override
  Widget build(BuildContext context) {

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
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),//Display the camera preview
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    _isFlashOn ? Icons.flash_on : Icons.flash_off,
                    color: _isFlashOn ? Colors.green : Colors.black,
                  ),
                  onPressed: _toggleFlash,
                ),
                IconButton(
                  icon: Icon(
                    Icons.cameraswitch,
                    color: Colors.black,
                  ),
                  onPressed: _switchCamera,
                ),
              ],
            ),
          ),
          if (_showSnapTipsOverlay)
            SnapTipsOverlay(
              onDismiss: () {
                setState(() {
                  _showSnapTipsOverlay = false;
                });
              },
            ),
          Align(
            alignment:  Alignment.bottomCenter,
            child: Container(
              height: 145,
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: _onTabTapped,
                fixedColor: Color(0xFF006D18), // Set the color of the selected item
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_photo_alternate_outlined, size: 40),
                    label: 'Photos',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.camera, size: 80),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.help_outline_sharp, size: 40),
                    label: 'SnapTips',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

