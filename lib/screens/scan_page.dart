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
// import 'package:http/http.dart' as http;
// import 'dart:convert';
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
//   Map<String, dynamic>? productInfo;
//   bool isLoading = false;
//   String? errorMessage;
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
//   Future<Map<String, dynamic>> getProductInfo(String barcode) async {
//     final url = 'https://world.openfoodfacts.org/api/v0/product/$barcode.json';
//     final response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       if (data['status'] == 1) {
//         final product = data['product'];
//         return {
//           'name': product['product_name'] ?? 'Unknown',
//           'brand': product['brands'] ?? 'Unknown',
//           'category': product['categories'] ?? 'Unknown',
//           'ingredients': product['ingredients_text'] ?? 'Not available',
//           'vegan_status': (product['ingredients_analysis_tags'] ?? []).contains('en:vegan'),
//           'vegetarian_status': (product['ingredients_analysis_tags'] ?? []).contains('en:vegetarian'),
//           'allergens': (product['allergens_tags'] ?? []).map((e) => e.toString().replaceAll('en:', '')).toList(),
//         };
//       } else {
//         throw Exception('Product not found');
//       }
//     } else {
//       throw Exception('Failed to fetch product info');
//     }
//   }
//
//   void handleBarcodeDetection(String barcode) async {
//     setState(() {
//       barcodeText = barcode;
//       isLoading = true;
//       errorMessage = null;
//       productInfo = null;
//     });
//
//     try {
//       final result = await getProductInfo(barcode);
//       setState(() {
//         productInfo = result;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Failed to fetch product information';
//         isLoading = false;
//       });
//     }
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
//           MobileScanner(
//             controller: MobileScannerController(
//               facing: CameraFacing.back,
//               torchEnabled: false,
//             ),
//             onDetect: (capture) {
//               final List<Barcode> barcodes = capture.barcodes;
//               for (final barcode in barcodes) {
//                 if (barcode.rawValue != null && barcodeText != barcode.rawValue) {
//                   handleBarcodeDetection(barcode.rawValue!);
//                   break;
//                 }
//               }
//             },
//           ),
//
//           // Transparent Overlay
//           Container(
//             decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
//           ),
//           ClipPath(
//             clipper: ScannerOverlayClipper(),
//             child: Container(color: Colors.transparent),
//           ),
//
//           // Scanner frame with animation
//           Center(
//             child: Container(
//               width: 250,
//               height: 250,
//               child: Stack(
//                 children: [
//                   // Corners
//                   _buildCorner(Alignment.topLeft),
//                   _buildCorner(Alignment.topRight),
//                   _buildCorner(Alignment.bottomLeft),
//                   _buildCorner(Alignment.bottomRight),
//
//                   // Animated line
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
//                               colors: [Colors.transparent, Colors.green, Colors.green, Colors.transparent],
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
//           // Hint text
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
//                   style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ),
//           ),
//
//           // Result container
//           if (barcodeText != null)
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 margin: EdgeInsets.all(20),
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: isLoading ? Colors.orange : (errorMessage != null ? Colors.red : Colors.green),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     if (isLoading) ...[
//                       CircularProgressIndicator(color: Colors.white),
//                       SizedBox(height: 8),
//                       Text("Fetching product info...", style: TextStyle(color: Colors.white)),
//                     ] else if (errorMessage != null) ...[
//                       Icon(Icons.error, color: Colors.white),
//                       SizedBox(height: 8),
//                       Text("Error", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//                       Text(errorMessage!, style: TextStyle(color: Colors.white)),
//                     ] else if (productInfo != null) ...[
//                       Icon(Icons.check_circle, color: Colors.white),
//                       SizedBox(height: 8),
//                       Text("Product Found!", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//                       SizedBox(height: 8),
//                       _buildInfo("Barcode", barcodeText!),
//                       _buildInfo("Name", productInfo!['name']),
//                       _buildInfo("Brand", productInfo!['brand']),
//                       _buildInfo("Category", productInfo!['category']),
//                       _buildInfo("Ingredients", productInfo!['ingredients']),
//                       _buildInfo("Vegan", productInfo!['vegan_status'] ? "Yes ✅" : "No ❌"),
//                       _buildInfo("Vegetarian", productInfo!['vegetarian_status'] ? "Yes ✅" : "No ❌"),
//                       _buildInfo(
//                         "Allergens",
//                         (productInfo!['allergens'] as List).isNotEmpty
//                             ? (productInfo!['allergens'] as List).join(', ')
//                             : "None",
//                       ),
//                     ],
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           barcodeText = null;
//                           productInfo = null;
//                           errorMessage = null;
//                           isLoading = false;
//                         });
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: isLoading ? Colors.orange : (errorMessage != null ? Colors.red : Colors.green),
//                       ),
//                       child: Text("Scan Again"),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCorner(Alignment alignment) {
//     return Align(
//       alignment: alignment,
//       child: Container(
//         width: 30,
//         height: 30,
//         decoration: BoxDecoration(
//           border: Border(
//             top: alignment == Alignment.topLeft || alignment == Alignment.topRight
//                 ? BorderSide(color: Colors.green, width: 4)
//                 : BorderSide.none,
//             bottom: alignment == Alignment.bottomLeft || alignment == Alignment.bottomRight
//                 ? BorderSide(color: Colors.green, width: 4)
//                 : BorderSide.none,
//             left: alignment == Alignment.topLeft || alignment == Alignment.bottomLeft
//                 ? BorderSide(color: Colors.green, width: 4)
//                 : BorderSide.none,
//             right: alignment == Alignment.topRight || alignment == Alignment.bottomRight
//                 ? BorderSide(color: Colors.green, width: 4)
//                 : BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfo(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2.0),
//       child: Text(
//         "$label: $value",
//         style: TextStyle(color: Colors.white, fontSize: 14),
//       ),
//     );
//   }
// }
//
// // Scanner overlay
// class ScannerOverlayClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
//     double scanAreaSize = 250;
//     double left = (size.width - scanAreaSize) / 2;
//     double top = (size.height - scanAreaSize) / 2;
//     Path holePath = Path()..addRect(Rect.fromLTWH(left, top, scanAreaSize, scanAreaSize));
//     return Path.combine(PathOperation.difference, path, holePath);
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }



//
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'foodinfo.dart';
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
//   Map<String, dynamic>? productInfo;
//   bool isLoading = false;
//   String? errorMessage;
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
//   Future<Map<String, dynamic>> getProductInfo(String barcode) async {
//     final response = await http.get(
//       Uri.parse('https://world.openfoodfacts.org/api/v0/product/$barcode.json'),
//     );
//
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load product info');
//     }
//   }
//
//   void handleBarcodeDetection(String barcode) async {
//     setState(() {
//       barcodeText = barcode;
//       isLoading = true;
//       errorMessage = null;
//       productInfo = null;
//     });
//
//     try {
//       final result = await getProductInfo(barcode);
//       setState(() {
//         productInfo = result;
//         isLoading = false;
//       });
//
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ProductInfoPage(product: result),
//         ),
//       );
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Failed to fetch product information';
//         isLoading = false;
//       });
//     }
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
//           MobileScanner(
//             controller: MobileScannerController(
//               facing: CameraFacing.back,
//               torchEnabled: false,
//             ),
//             onDetect: (capture) {
//               final List<Barcode> barcodes = capture.barcodes;
//               for (final barcode in barcodes) {
//                 if (barcode.rawValue != null && barcodeText != barcode.rawValue) {
//                   handleBarcodeDetection(barcode.rawValue!);
//                   break;
//                 }
//               }
//             },
//           ),
//
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
//           ClipPath(
//             clipper: ScannerOverlayClipper(),
//             child: Container(
//               color: Colors.black.withOpacity(0.5),
//             ),
//           ),
//
//           Center(
//             child: Container(
//               width: 250,
//               height: 250,
//               child: Stack(
//                 children: [
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
//         ],
//       ),
//     );
//   }
// }
//
// class ScannerOverlayClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
//
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
//
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'foodinfo.dart';
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
//   Map<String, dynamic>? productInfo;
//   bool isLoading = false;
//   String? errorMessage;
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//
//   // Custom API endpoint
//   static const String baseUrl = 'https://b2a4-113-199-208-250.ngrok-free.app';
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
//   Future<Map<String, dynamic>> getProductInfo(String barcode) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/api/product/$barcode'),
//         headers: {
//           'Content-Type': 'application/json',
//           'ngrok-skip-browser-warning': 'true', // Skip ngrok browser warning
//         },
//       );
//
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return data;
//       } else if (response.statusCode == 404) {
//         throw Exception('Product not found');
//       } else {
//         throw Exception('Server error: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching product info: $e');
//       throw Exception('Failed to load product info: $e');
//     }
//   }
//
//   // Fallback method to try OpenFoodFacts if custom API fails
//   Future<Map<String, dynamic>> getProductInfoFromOpenFoodFacts(String barcode) async {
//     final response = await http.get(
//       Uri.parse('https://world.openfoodfacts.org/api/v0/product/$barcode.json'),
//     );
//
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load product info from OpenFoodFacts');
//     }
//   }
//
//   void handleBarcodeDetection(String barcode) async {
//     setState(() {
//       barcodeText = barcode;
//       isLoading = true;
//       errorMessage = null;
//       productInfo = null;
//     });
//
//     try {
//       // Try custom API first
//       Map<String, dynamic> result;
//       try {
//         result = await getProductInfo(barcode);
//       } catch (e) {
//         print('Custom API failed, trying OpenFoodFacts: $e');
//         // Fallback to OpenFoodFacts
//         result = await getProductInfoFromOpenFoodFacts(barcode);
//       }
//
//       setState(() {
//         productInfo = result;
//         isLoading = false;
//       });
//
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ProductInfoPage(product: result),
//         ),
//       );
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Failed to fetch product information: ${e.toString()}';
//         isLoading = false;
//       });
//
//       // Show error dialog
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text(errorMessage ?? 'Unknown error occurred'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
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
//           MobileScanner(
//             controller: MobileScannerController(
//               facing: CameraFacing.back,
//               torchEnabled: false,
//             ),
//             onDetect: (capture) {
//               final List<Barcode> barcodes = capture.barcodes;
//               for (final barcode in barcodes) {
//                 if (barcode.rawValue != null && barcodeText != barcode.rawValue) {
//                   handleBarcodeDetection(barcode.rawValue!);
//                   break;
//                 }
//               }
//             },
//           ),
//
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
//           ClipPath(
//             clipper: ScannerOverlayClipper(),
//             child: Container(
//               color: Colors.black.withOpacity(0.5),
//             ),
//           ),
//
//           Center(
//             child: Container(
//               width: 250,
//               height: 250,
//               child: Stack(
//                 children: [
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
//           // Loading indicator
//           if (isLoading)
//             Container(
//               color: Colors.black.withOpacity(0.5),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//                     ),
//                     SizedBox(height: 16),
//                     Text(
//                       'Fetching product information...',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
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
// class ScannerOverlayClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
//
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
//
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'ProductInfoPage.dart'; // Make sure this displays the parsed result
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
//   Map<String, dynamic>? productInfo;
//   bool isLoading = false;
//   String? errorMessage;
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//
//   final String backendUrl = 'https://8ac8-113-199-208-250.ngrok-free.app/barcode';
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
//   Future<Map<String, dynamic>> getProductInfo(String barcode) async {
//     final response = await http.post(
//       Uri.parse(backendUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'barcode': barcode}),
//     );
//
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load product info from backend');
//     }
//   }
//
//   void handleBarcodeDetection(String barcode) async {
//     setState(() {
//       barcodeText = barcode;
//       isLoading = true;
//       errorMessage = null;
//       productInfo = null;
//     });
//
//     try {
//       final result = await getProductInfo(barcode);
//       setState(() {
//         productInfo = result;
//         isLoading = false;
//       });
//
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ProductInfoPage(
//             barcode: barcode,
//             product: result,
//           ),
//         ),
//       );
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Failed to fetch product information from backend';
//         isLoading = false;
//       });
//     }
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
//           MobileScanner(
//             controller: MobileScannerController(
//               facing: CameraFacing.back,
//               torchEnabled: false,
//             ),
//             onDetect: (capture) {
//               final List<Barcode> barcodes = capture.barcodes;
//               for (final barcode in barcodes) {
//                 if (barcode.rawValue != null && barcodeText != barcode.rawValue) {
//                   handleBarcodeDetection(barcode.rawValue!);
//                   break;
//                 }
//               }
//             },
//           ),
//
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
//               ),
//             ),
//           ),
//
//           ClipPath(
//             clipper: ScannerOverlayClipper(),
//             child: Container(
//               color: Colors.black.withOpacity(0.5),
//             ),
//           ),
//
//           Center(
//             child: Container(
//               width: 250,
//               height: 250,
//               child: Stack(
//                 children: [
//                   ..._buildScannerCorners(),
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
//         ],
//       ),
//     );
//   }
//
//   List<Widget> _buildScannerCorners() {
//     return [
//       Positioned(
//         top: 0,
//         left: 0,
//         child: _cornerBorder(top: true, left: true),
//       ),
//       Positioned(
//         top: 0,
//         right: 0,
//         child: _cornerBorder(top: true, right: true),
//       ),
//       Positioned(
//         bottom: 0,
//         left: 0,
//         child: _cornerBorder(bottom: true, left: true),
//       ),
//       Positioned(
//         bottom: 0,
//         right: 0,
//         child: _cornerBorder(bottom: true, right: true),
//       ),
//     ];
//   }
//
//   Widget _cornerBorder({bool top = false, bool bottom = false, bool left = false, bool right = false}) {
//     return Container(
//       width: 30,
//       height: 30,
//       decoration: BoxDecoration(
//         border: Border(
//           top: top ? BorderSide(color: Colors.green, width: 4) : BorderSide.none,
//           bottom: bottom ? BorderSide(color: Colors.green, width: 4) : BorderSide.none,
//           left: left ? BorderSide(color: Colors.green, width: 4) : BorderSide.none,
//           right: right ? BorderSide(color: Colors.green, width: 4) : BorderSide.none,
//         ),
//       ),
//     );
//   }
// }
//
// class ScannerOverlayClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
//
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

//
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'ProductInfoPage.dart'; // Make sure this displays the parsed result
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
//   void handleBarcodeDetection(String barcode) async {
//     setState(() {
//       barcodeText = barcode;
//     });
//
//     // Navigate directly to ProductInfoPage - it will handle the API call
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ProductInfoPage(
//           barcode: barcode,
//         ),
//       ),
//     );
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
//           MobileScanner(
//             controller: MobileScannerController(
//               facing: CameraFacing.back,
//               torchEnabled: false,
//             ),
//             onDetect: (capture) {
//               final List<Barcode> barcodes = capture.barcodes;
//               for (final barcode in barcodes) {
//                 if (barcode.rawValue != null && barcodeText != barcode.rawValue) {
//                   handleBarcodeDetection(barcode.rawValue!);
//                   break;
//                 }
//               }
//             },
//           ),
//
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
//               ),
//             ),
//           ),
//
//           ClipPath(
//             clipper: ScannerOverlayClipper(),
//             child: Container(
//               color: Colors.black.withOpacity(0.5),
//             ),
//           ),
//
//           Center(
//             child: Container(
//               width: 250,
//               height: 250,
//               child: Stack(
//                 children: [
//                   ..._buildScannerCorners(),
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
//         ],
//       ),
//     );
//   }
//
//   List<Widget> _buildScannerCorners() {
//     return [
//       Positioned(
//         top: 0,
//         left: 0,
//         child: _cornerBorder(top: true, left: true),
//       ),
//       Positioned(
//         top: 0,
//         right: 0,
//         child: _cornerBorder(top: true, right: true),
//       ),
//       Positioned(
//         bottom: 0,
//         left: 0,
//         child: _cornerBorder(bottom: true, left: true),
//       ),
//       Positioned(
//         bottom: 0,
//         right: 0,
//         child: _cornerBorder(bottom: true, right: true),
//       ),
//     ];
//   }
//
//   Widget _cornerBorder({bool top = false, bool bottom = false, bool left = false, bool right = false}) {
//     return Container(
//       width: 30,
//       height: 30,
//       decoration: BoxDecoration(
//         border: Border(
//           top: top ? BorderSide(color: Colors.green, width: 4) : BorderSide.none,
//           bottom: bottom ? BorderSide(color: Colors.green, width: 4) : BorderSide.none,
//           left: left ? BorderSide(color: Colors.green, width: 4) : BorderSide.none,
//           right: right ? BorderSide(color: Colors.green, width: 4) : BorderSide.none,
//         ),
//       ),
//     );
//   }
// }
//
// class ScannerOverlayClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
//
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
import 'ProductInfoPage.dart'; // Make sure this displays the parsed result

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with TickerProviderStateMixin {
  String? barcodeText;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late MobileScannerController _scannerController;
  bool _isScanning = true;

  @override
  void initState() {
    super.initState();

    // Initialize scanner controller
    _scannerController = MobileScannerController(
      facing: CameraFacing.back,
      torchEnabled: false,
    );

    // Initialize animation
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)
    );
    _animationController.repeat(reverse: true);
  }

  void handleBarcodeDetection(String barcode) async {
    if (!_isScanning) return; // Prevent multiple scans

    setState(() {
      barcodeText = barcode;
      _isScanning = false;
    });

    // Stop scanning
    await _scannerController.stop();

    // Navigate to ProductInfoPage
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductInfoPage(
            barcode: barcode,
          ),
        ),
      ).then((_) {
        // Reset scanning state when returning from ProductInfoPage
        if (mounted) {
          setState(() {
            _isScanning = true;
          });
          _scannerController.start();
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scannerController.dispose(); // Properly dispose scanner controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Scan Barcode"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Camera view
          MobileScanner(
            controller: _scannerController,
            onDetect: (capture) {
              if (!_isScanning) return;

              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null &&
                    barcode.rawValue!.isNotEmpty &&
                    barcodeText != barcode.rawValue) {
                  handleBarcodeDetection(barcode.rawValue!);
                  break;
                }
              }
            },
          ),

          // Dark overlay with transparent scanning area
          CustomPaint(
            painter: ScannerOverlayPainter(),
            child: Container(),
          ),

          // Scanning frame with corners and animated line
          Center(
            child: Container(
              width: 250,
              height: 250,
              child: Stack(
                children: [
                  // Corner borders
                  ..._buildScannerCorners(),

                  // Animated scanning line
                  if (_isScanning)
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Positioned(
                          top: _animation.value * 220,
                          left: 10,
                          right: 10,
                          child: Container(
                            height: 3,
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
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),

          // Instruction text
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  _isScanning
                      ? "Align barcode within the frame"
                      : "Processing...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          // Torch toggle button
          Positioned(
            bottom: 50,
            right: 20,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.green,
              onPressed: () {
                _scannerController.toggleTorch();
              },
              child: Icon(
                Icons.flash_on,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildScannerCorners() {
    return [
      // Top-left corner
      Positioned(
        top: 0,
        left: 0,
        child: _cornerBorder(top: true, left: true),
      ),
      // Top-right corner
      Positioned(
        top: 0,
        right: 0,
        child: _cornerBorder(top: true, right: true),
      ),
      // Bottom-left corner
      Positioned(
        bottom: 0,
        left: 0,
        child: _cornerBorder(bottom: true, left: true),
      ),
      // Bottom-right corner
      Positioned(
        bottom: 0,
        right: 0,
        child: _cornerBorder(bottom: true, right: true),
      ),
    ];
  }

  Widget _cornerBorder({
    bool top = false,
    bool bottom = false,
    bool left = false,
    bool right = false
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          top: top ? BorderSide(color: Colors.green, width: 4) : BorderSide.none,
          bottom: bottom ? BorderSide(color: Colors.green, width: 4) : BorderSide.none,
          left: left ? BorderSide(color: Colors.green, width: 4) : BorderSide.none,
          right: right ? BorderSide(color: Colors.green, width: 4) : BorderSide.none,
        ),
      ),
    );
  }
}

// Custom painter for the scanner overlay
class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    // Calculate the scanning area
    const double scanAreaSize = 250;
    final double left = (size.width - scanAreaSize) / 2;
    final double top = (size.height - scanAreaSize) / 2;

    // Create the full screen path
    final fullScreenPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create the scanning area path (hole)
    final scanningAreaPath = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, scanAreaSize, scanAreaSize),
        Radius.circular(12),
      ));

    // Subtract the scanning area from the full screen
    final overlayPath = Path.combine(
      PathOperation.difference,
      fullScreenPath,
      scanningAreaPath,
    );

    canvas.drawPath(overlayPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}