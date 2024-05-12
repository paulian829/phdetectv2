import 'package:flutter/material.dart';

class SnapTipsOverlay extends StatelessWidget {
  final VoidCallback onDismiss;

  SnapTipsOverlay({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Snap Tips',
                style: TextStyle(
                  color: Color(0xFF006D18),
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Follow this guide for accurate results:',
                style: TextStyle(
                  color: Color(0xFF006D18),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5), //adjust the space around the image
                        child: ClipRRect(
                          borderRadius:  BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/snap1.png', 
                            width: 200, 
                            // height: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFF006D18),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                          ), 
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5), //adjust the space around the image
                        child: ClipRRect(
                          borderRadius:  BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/snap2.png', 
                            width: 200, 
                            // height: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red[900],
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                          ), 
                          child: Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 2),
              ElevatedButton(
                onPressed: onDismiss,
                child: Text(
                  'Dismiss',
                  style: TextStyle(
                  color: Color(0xFF006D18),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
