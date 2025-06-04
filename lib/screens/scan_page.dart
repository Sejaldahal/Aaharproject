// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
//
// class ScanPage extends StatefulWidget {
//   const ScanPage({Key? key}) : super(key: key);
//
//   @override
//   State<ScanPage> createState() => _ScanPageState();
// }
//
// class _ScanPageState extends State<ScanPage> {
//   String? barcodeText;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Scan Barcode"),
//         backgroundColor: Colors.green,
//       ),
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: MobileScannerController(
//               facing: CameraFacing.back,
//               torchEnabled: false,
//             ),
//             onDetect: (capture) {
//               final List<Barcode> barcodes = capture.barcodes;
//               for (final barcode in barcodes) {
//                 if (barcode.rawValue != null) {
//                   setState(() {
//                     barcodeText = barcode.rawValue!;
//                   });
//                   // You can also stop the camera after scan if needed
//                   // Navigator.pop(context, barcode.rawValue);
//                 }
//               }
//             },
//           ),
//           if (barcodeText != null)
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 padding: EdgeInsets.all(16),
//                 color: Colors.black.withOpacity(0.7),
//                 child: Text(
//                   "Scanned: $barcodeText",
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }


//
//
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
//
// class ScanPage extends StatefulWidget {
//   const ScanPage({Key? key}) : super(key: key);
//
//   @override
//   State<ScanPage> createState() => _ScanPageState();
// }
//
// class _ScanPageState extends State<ScanPage> with TickerProviderStateMixin {
//   String? barcodeText;
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     );
//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
//     _animationController.repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Scan Barcode"),
//         backgroundColor: Colors.green,
//       ),
//       body: Stack(
//         children: [
//           // Camera Scanner
//           MobileScanner(
//             controller: MobileScannerController(
//               facing: CameraFacing.back,
//               torchEnabled: false,
//             ),
//             onDetect: (capture) {
//               final List<Barcode> barcodes = capture.barcodes;
//               for (final barcode in barcodes) {
//                 if (barcode.rawValue != null) {
//                   setState(() {
//                     barcodeText = barcode.rawValue!;
//                   });
//                 }
//               }
//             },
//           ),
//
//           // Dark overlay with transparent scanning area
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(0.5),
//             ),
//             child: Center(
//               child: Container(
//                 width: 250,
//                 height: 250,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.transparent,
//                     width: 100,
//                   ),
//                 ),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     border: Border.all(color: Colors.transparent),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           // Create hole in overlay using ClipPath
//           ClipPath(
//             clipper: ScannerOverlayClipper(),
//             child: Container(
//               color: Colors.black.withOpacity(0.5),
//             ),
//           ),
//
//           // Scanning border frame
//           Center(
//             child: Container(
//               width: 250,
//               height: 250,
//               child: Stack(
//                 children: [
//                   // Corner borders
//                   Positioned(
//                     top: 0,
//                     left: 0,
//                     child: Container(
//                       width: 30,
//                       height: 30,
//                       decoration: BoxDecoration(
//                         border: Border(
//                           top: BorderSide(color: Colors.green, width: 4),
//                           left: BorderSide(color: Colors.green, width: 4),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 0,
//                     right: 0,
//                     child: Container(
//                       width: 30,
//                       height: 30,
//                       decoration: BoxDecoration(
//                         border: Border(
//                           top: BorderSide(color: Colors.green, width: 4),
//                           right: BorderSide(color: Colors.green, width: 4),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     child: Container(
//                       width: 30,
//                       height: 30,
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(color: Colors.green, width: 4),
//                           left: BorderSide(color: Colors.green, width: 4),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Container(
//                       width: 30,
//                       height: 30,
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(color: Colors.green, width: 4),
//                           right: BorderSide(color: Colors.green, width: 4),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // Animated scanning line
//                   AnimatedBuilder(
//                     animation: _animation,
//                     builder: (context, child) {
//                       return Positioned(
//                         top: _animation.value * 220,
//                         left: 0,
//                         right: 0,
//                         child: Container(
//                           height: 2,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.transparent,
//                                 Colors.green,
//                                 Colors.green,
//                                 Colors.transparent,
//                               ],
//                               stops: [0.0, 0.3, 0.7, 1.0],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // Instructions text
//           Positioned(
//             bottom: 150,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.7),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   "Align barcode within the frame",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           // Scanned result display
//           if (barcodeText != null)
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 margin: EdgeInsets.all(20),
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.check_circle, color: Colors.white, size: 30),
//                     SizedBox(height: 8),
//                     Text(
//                       "Scanned Successfully!",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       "$barcodeText",
//                       style: TextStyle(color: Colors.white, fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// // Custom clipper to create transparent scanning area
// class ScannerOverlayClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
//
//     // Create hole in the center
//     double scanAreaSize = 250;
//     double left = (size.width - scanAreaSize) / 2;
//     double top = (size.height - scanAreaSize) / 2;
//
//     Path holePath = Path();
//     holePath.addRect(Rect.fromLTWH(left, top, scanAreaSize, scanAreaSize));
//
//     return Path.combine(PathOperation.difference, path, holePath);
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }


import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with TickerProviderStateMixin {
  String? barcodeText;
  Map<String, dynamic>? productInfo;
  bool isLoading = false;
  String? errorMessage;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.repeat(reverse: true);
  }

  Future<Map<String, dynamic>> getProductInfo(String barcode) async {
    final response = await http.get(
      Uri.parse('http://192.168.1.7:5000/product/$barcode'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product info');
    }
  }

  void handleBarcodeDetection(String barcode) async {
    setState(() {
      barcodeText = barcode;
      isLoading = true;
      errorMessage = null;
      productInfo = null;
    });

    try {
      final result = await getProductInfo(barcode);
      setState(() {
        productInfo = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to fetch product information';
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Barcode"),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          // Camera Scanner
          MobileScanner(
            controller: MobileScannerController(
              facing: CameraFacing.back,
              torchEnabled: false,
            ),
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null && barcodeText != barcode.rawValue) {
                  handleBarcodeDetection(barcode.rawValue!);
                  break; // Only process first barcode to avoid multiple calls
                }
              }
            },
          ),

          // Dark overlay with transparent scanning area
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
            child: Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 100,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.transparent),
                  ),
                ),
              ),
            ),
          ),

          // Create hole in overlay using ClipPath
          ClipPath(
            clipper: ScannerOverlayClipper(),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),

          // Scanning border frame
          Center(
            child: Container(
              width: 250,
              height: 250,
              child: Stack(
                children: [
                  // Corner borders
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.green, width: 4),
                          left: BorderSide(color: Colors.green, width: 4),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.green, width: 4),
                          right: BorderSide(color: Colors.green, width: 4),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.green, width: 4),
                          left: BorderSide(color: Colors.green, width: 4),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.green, width: 4),
                          right: BorderSide(color: Colors.green, width: 4),
                        ),
                      ),
                    ),
                  ),

                  // Animated scanning line
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Positioned(
                        top: _animation.value * 220,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.green,
                                Colors.green,
                                Colors.transparent,
                              ],
                              stops: [0.0, 0.3, 0.7, 1.0],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Instructions text
          Positioned(
            bottom: 150,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Align barcode within the frame",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          // Scanned result display
          if (barcodeText != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isLoading ? Colors.orange : (errorMessage != null ? Colors.red : Colors.green),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isLoading) ...[
                      CircularProgressIndicator(color: Colors.white),
                      SizedBox(height: 8),
                      Text(
                        "Fetching product info...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ] else if (errorMessage != null) ...[
                      Icon(Icons.error, color: Colors.white, size: 30),
                      SizedBox(height: 8),
                      Text(
                        "Error",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        errorMessage!,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ] else if (productInfo != null) ...[
                      Icon(Icons.check_circle, color: Colors.white, size: 30),
                      SizedBox(height: 8),
                      Text(
                        "Product Found!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Barcode: $barcodeText",
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            if (productInfo!['name'] != null)
                              Text(
                                "Name: ${productInfo!['name']}",
                                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            if (productInfo!['brand'] != null)
                              Text(
                                "Brand: ${productInfo!['brand']}",
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            if (productInfo!['category'] != null)
                              Text(
                                "Category: ${productInfo!['category']}",
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          barcodeText = null;
                          productInfo = null;
                          errorMessage = null;
                          isLoading = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: isLoading ? Colors.orange : (errorMessage != null ? Colors.red : Colors.green),
                      ),
                      child: Text("Scan Again"),
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

// Custom clipper to create transparent scanning area
class ScannerOverlayClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create hole in the center
    double scanAreaSize = 250;
    double left = (size.width - scanAreaSize) / 2;
    double top = (size.height - scanAreaSize) / 2;

    Path holePath = Path();
    holePath.addRect(Rect.fromLTWH(left, top, scanAreaSize, scanAreaSize));

    return Path.combine(PathOperation.difference, path, holePath);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}