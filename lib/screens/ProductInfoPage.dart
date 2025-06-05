// import 'package:flutter/material.dart';
// import 'api_service.dart';
//
// class ProductInfoPage extends StatefulWidget {
//   final String barcode;
//
//   ProductInfoPage({required this.barcode});
//
//   @override
//   _ProductInfoPageState createState() => _ProductInfoPageState();
// }
//
// class _ProductInfoPageState extends State<ProductInfoPage> {
//   Map<String, dynamic>? productData;
//   bool loading = true;
//   String? error;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchProductData();
//   }
//
//   Future<void> fetchProductData() async {
//     try {
//       final data = await ApiService.getProductInfo(widget.barcode);
//       setState(() {
//         productData = data;
//         loading = false;
//       });
//     } catch (e) {
//       setState(() {
//         error = e.toString();
//         loading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (loading) return Scaffold(body: Center(child: CircularProgressIndicator()));
//     if (error != null) return Scaffold(body: Center(child: Text('Error: $error')));
//
//     return Scaffold(
//       appBar: AppBar(title: Text(productData?['product_name'] ?? 'Product Info')),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Brand: ${productData?['brands']}', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 8),
//             Text('Quantity: ${productData?['quantity']}', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 8),
//             Text('Nutrition Grade: ${productData?['nutrition_grades']}', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 16),
//             Text('Mood Prediction:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Text('${productData?['mood_prediction']['mood'] ?? 'N/A'}'),
//             SizedBox(height: 16),
//             Text('Detected Allergens:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Text('${productData?['allergen_info']['detected_allergens'].join(', ') ?? 'None'}'),
//             SizedBox(height: 16),
//             Text('Diet Type: ${productData?['diet_analysis']['diet_type']}', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 16),
//             Text('Health Score: ${productData?['health_score']}', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 16),
//             Text('Recommendations:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             ...(productData?['recommendations'] as List<dynamic>).map((r) => Text('- $r')).toList(),
//           ],
//         ),
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'api_service.dart';
//
// class ProductInfoPage extends StatefulWidget {
//   final String barcode;
//
//   ProductInfoPage({required this.barcode});
//
//   @override
//   _ProductInfoPageState createState() => _ProductInfoPageState();
// }
//
// class _ProductInfoPageState extends State<ProductInfoPage> with TickerProviderStateMixin {
//   Map<String, dynamic>? productData;
//   bool loading = true;
//   String? error;
//   late AnimationController _fadeController;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _fadeController = AnimationController(
//       duration: Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
//     );
//     fetchProductData();
//   }
//
//   @override
//   void dispose() {
//     _fadeController.dispose();
//     super.dispose();
//   }
//
//   Future<void> fetchProductData() async {
//     try {
//       final data = await ApiService.getProductInfo(widget.barcode);
//       setState(() {
//         productData = data;
//         loading = false;
//       });
//       _fadeController.forward();
//     } catch (e) {
//       setState(() {
//         error = e.toString();
//         loading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (loading) {
//       return Scaffold(
//         backgroundColor: Colors.green.shade50,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.green.withOpacity(0.3),
//                       blurRadius: 20,
//                       spreadRadius: 5,
//                     ),
//                   ],
//                 ),
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade600),
//                   strokeWidth: 3,
//                 ),
//               ),
//               SizedBox(height: 24),
//               Text(
//                 'Analyzing Product...',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.green.shade700,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     if (error != null) {
//       return Scaffold(
//         backgroundColor: Colors.green.shade50,
//         body: Center(
//           child: Container(
//             margin: EdgeInsets.all(24),
//             padding: EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.red.withOpacity(0.1),
//                   blurRadius: 20,
//                   spreadRadius: 5,
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   Icons.error_outline,
//                   size: 64,
//                   color: Colors.red.shade400,
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Oops! Something went wrong',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey.shade800,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   error!,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//                 SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green.shade600,
//                     foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   child: Text('Try Again'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: Colors.green.shade50,
//       appBar: AppBar(
//         title: Text(
//           productData?['product_name'] ?? 'Product Info',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.green.shade600,
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Product Header Card
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.green.shade600, Colors.green.shade400],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.green.withOpacity(0.3),
//                       blurRadius: 15,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.qr_code, color: Colors.white, size: 28),
//                         SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             productData?['product_name'] ?? 'Unknown Product',
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16),
//                     Text(
//                       'Barcode: ${widget.barcode}',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white.withOpacity(0.9),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: 24),
//
//               // Basic Info Section
//               _buildInfoSection(
//                 'Basic Information',
//                 Icons.info_outline,
//                 [
//                   _buildInfoItem('Brand', productData?['brands'] ?? 'N/A', Icons.business),
//                   _buildInfoItem('Quantity', productData?['quantity'] ?? 'N/A', Icons.scale),
//                   _buildInfoItem('Nutrition Grade', productData?['nutrition_grades'] ?? 'N/A', Icons.grade),
//                 ],
//               ),
//
//               SizedBox(height: 20),
//
//               // Health Score Section
//               _buildHealthScoreSection(),
//
//               SizedBox(height: 20),
//
//               // Mood Prediction Section
//               _buildMoodSection(),
//
//               SizedBox(height: 20),
//
//               // Allergens Section
//               _buildAllergensSection(),
//
//               SizedBox(height: 20),
//
//               // Diet Analysis Section
//               _buildDietSection(),
//
//               SizedBox(height: 20),
//
//               // Recommendations Section
//               _buildRecommendationsSection(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoSection(String title, IconData icon, List<Widget> children) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.green.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.green.shade100,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(icon, color: Colors.green.shade600, size: 20),
//               ),
//               SizedBox(width: 12),
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey.shade800,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           ...children,
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoItem(String label, String value, IconData icon) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 12),
//       child: Row(
//         children: [
//           Icon(icon, size: 18, color: Colors.green.shade600),
//           SizedBox(width: 10),
//           Text(
//             '$label: ',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey.shade700,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey.shade800,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHealthScoreSection() {
//     final healthScore = productData?['health_score'];
//     final score = healthScore is num ? healthScore.toDouble() : 0.0;
//     final scoreColor = score >= 70 ? Colors.green : score >= 40 ? Colors.orange : Colors.red;
//
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.green.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: scoreColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(Icons.favorite, color: scoreColor, size: 20),
//               ),
//               SizedBox(width: 12),
//               Text(
//                 'Health Score',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey.shade800,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           Row(
//             children: [
//               Text(
//                 '${score.toInt()}',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: scoreColor,
//                 ),
//               ),
//               Text(
//                 '/100',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey.shade600,
//                 ),
//               ),
//               Spacer(),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: scoreColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   score >= 70 ? 'Excellent' : score >= 40 ? 'Good' : 'Poor',
//                   style: TextStyle(
//                     color: scoreColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           LinearProgressIndicator(
//             value: score / 100,
//             backgroundColor: Colors.grey.shade200,
//             valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMoodSection() {
//     final mood = productData?['mood_prediction']?['mood'] ?? 'N/A';
//     final moodIcon = _getMoodIcon(mood);
//     final moodColor = _getMoodColor(mood);
//
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.green.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: moodColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(moodIcon, color: moodColor, size: 20),
//               ),
//               SizedBox(width: 12),
//               Text(
//                 'Mood Prediction',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey.shade800,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: moodColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: moodColor.withOpacity(0.3)),
//             ),
//             child: Row(
//               children: [
//                 Icon(moodIcon, color: moodColor, size: 24),
//                 SizedBox(width: 12),
//                 Text(
//                   mood,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: moodColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAllergensSection() {
//     final allergens = productData?['allergen_info']?['detected_allergens'] as List<dynamic>? ?? [];
//
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.green.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.red.shade100,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(Icons.warning, color: Colors.red.shade600, size: 20),
//               ),
//               SizedBox(width: 12),
//               Text(
//                 'Detected Allergens',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey.shade800,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           allergens.isEmpty
//               ? Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.green.shade50,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.green.shade200),
//             ),
//             child: Row(
//               children: [
//                 Icon(Icons.check_circle, color: Colors.green.shade600, size: 20),
//                 SizedBox(width: 8),
//                 Text(
//                   'No allergens detected',
//                   style: TextStyle(
//                     color: Colors.green.shade700,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           )
//               : Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: allergens.map((allergen) => Container(
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: Colors.red.shade50,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.red.shade200),
//               ),
//               child: Text(
//                 allergen.toString(),
//                 style: TextStyle(
//                   color: Colors.red.shade700,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             )).toList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDietSection() {
//     final dietType = productData?['diet_analysis']?['diet_type'] ?? 'N/A';
//     final dietColor = _getDietColor(dietType);
//     final dietIcon = _getDietIcon(dietType);
//
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.green.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: dietColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(dietIcon, color: dietColor, size: 20),
//               ),
//               SizedBox(width: 12),
//               Text(
//                 'Diet Type',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey.shade800,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: dietColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: dietColor.withOpacity(0.3)),
//             ),
//             child: Row(
//               children: [
//                 Icon(dietIcon, color: dietColor, size: 24),
//                 SizedBox(width: 12),
//                 Text(
//                   dietType,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: dietColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRecommendationsSection() {
//     final recommendations = productData?['recommendations'] as List<dynamic>? ?? [];
//
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.green.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade100,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(Icons.lightbulb_outline, color: Colors.blue.shade600, size: 20),
//               ),
//               SizedBox(width: 12),
//               Text(
//                 'Recommendations',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey.shade800,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           ...recommendations.map((recommendation) => Container(
//             margin: EdgeInsets.only(bottom: 12),
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.blue.shade50,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.blue.shade100),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Icon(Icons.arrow_forward_ios, color: Colors.blue.shade600, size: 16),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: Text(
//                     recommendation.toString(),
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.blue.shade800,
//                       height: 1.4,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )).toList(),
//         ],
//       ),
//     );
//   }
//
//   IconData _getMoodIcon(String mood) {
//     switch (mood.toLowerCase()) {
//       case 'happy':
//       case 'positive':
//         return Icons.sentiment_very_satisfied;
//       case 'sad':
//       case 'negative':
//         return Icons.sentiment_very_dissatisfied;
//       case 'neutral':
//         return Icons.sentiment_neutral;
//       default:
//         return Icons.sentiment_neutral;
//     }
//   }
//
//   Color _getMoodColor(String mood) {
//     switch (mood.toLowerCase()) {
//       case 'happy':
//       case 'positive':
//         return Colors.green;
//       case 'sad':
//       case 'negative':
//         return Colors.red;
//       case 'neutral':
//         return Colors.orange;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   Color _getDietColor(String dietType) {
//     switch (dietType.toLowerCase()) {
//       case 'vegan':
//         return Colors.green;
//       case 'vegetarian':
//         return Colors.green.shade400;
//       case 'non-vegetarian':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   IconData _getDietIcon(String dietType) {
//     switch (dietType.toLowerCase()) {
//       case 'vegan':
//         return Icons.eco;
//       case 'vegetarian':
//         return Icons.local_florist;
//       case 'non-vegetarian':
//         return Icons.restaurant;
//       default:
//         return Icons.restaurant_menu;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'api_service.dart';

class ProductInfoPage extends StatefulWidget {
  final String barcode;

  ProductInfoPage({required this.barcode});

  @override
  _ProductInfoPageState createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> with TickerProviderStateMixin {
  Map<String, dynamic>? productData;
  bool loading = true;
  String? error;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    fetchProductData();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> fetchProductData() async {
    try {
      final data = await ApiService.getProductInfo(widget.barcode);
      setState(() {
        productData = data;
        loading = false;
      });
      _fadeController.forward();
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        backgroundColor: Colors.green.shade50,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade600),
                  strokeWidth: 3,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Analyzing Product...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (error != null) {
      return Scaffold(
        backgroundColor: Colors.green.shade50,
        body: Center(
          child: Container(
            margin: EdgeInsets.all(24),
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red.shade400,
                ),
                SizedBox(height: 16),
                Text(
                  'Oops! Something went wrong',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  error!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text('Try Again'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: Text(
          productData?['basic_info']?['product_name'] ?? 'Product Info',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green.shade600,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Header Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade600, Colors.green.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.qr_code, color: Colors.white, size: 28),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            productData?['basic_info']?['product_name'] ?? 'Unknown Product',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Barcode: ${widget.barcode}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Basic Info Section
              _buildInfoSection(
                'Basic Information',
                Icons.info_outline,
                [
                  _buildInfoItem('Brand', productData?['basic_info']?['brand'] ?? 'N/A', Icons.business),
                  _buildInfoItem('Category', productData?['basic_info']?['category'] ?? 'N/A', Icons.category),
                  _buildInfoItem('Quantity', productData?['basic_info']?['quantity'] ?? 'N/A', Icons.scale),
                ],
              ),

              SizedBox(height: 20),

              // Nutrition Information Section
              _buildNutritionSection(),

              SizedBox(height: 20),

              // Mood Prediction Section
              _buildMoodSection(),

              SizedBox(height: 20),

              // Allergens Section
              _buildAllergensSection(),

              SizedBox(height: 20),

              // Diet Analysis Section
              _buildDietSection(),

              SizedBox(height: 20),

              // Disease Risk Assessment Section
              _buildDiseaseRiskSection(),

              SizedBox(height: 20),

              // Ingredients Section
              _buildIngredientsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, IconData icon, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.green.shade600, size: 20),
              ),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.green.shade600),
          SizedBox(width: 10),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionSection() {
    final nutrients = productData?['nutrient_content_per_100g'] as Map<String, dynamic>? ?? {};

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.restaurant, color: Colors.blue.shade600, size: 20),
              ),
              SizedBox(width: 12),
              Text(
                'Nutrition (per 100g)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          if (nutrients.isEmpty)
            Text(
              'No nutrition information available',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            ...nutrients.entries.map((entry) => _buildNutrientItem(entry.key, entry.value)).toList(),
        ],
      ),
    );
  }

  Widget _buildNutrientItem(String nutrient, dynamic value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nutrient,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodSection() {
    final moodPrediction = productData?['mood_prediction'] as Map<String, dynamic>? ?? {};
    final moodEffects = moodPrediction['mood_effects'] as List<dynamic>? ?? [];
    final description = moodPrediction['description'] ?? 'No mood prediction available';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.psychology, color: Colors.purple.shade600, size: 20),
              ),
              SizedBox(width: 12),
              Text(
                'Mood Prediction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.purple.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.purple.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (moodEffects.isNotEmpty) ...[
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: moodEffects.map((effect) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.purple.shade300),
                      ),
                      child: Text(
                        effect.toString().replaceAll('_', ' ').toUpperCase(),
                        style: TextStyle(
                          color: Colors.purple.shade700,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllergensSection() {
    final allergenCheck = productData?['allergen_check'] as Map<String, dynamic>? ?? {};
    final allergens = allergenCheck['allergens_found'] as List<dynamic>? ?? [];
    final containsAllergens = allergenCheck['contains_allergens'] ?? false;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: containsAllergens ? Colors.red.shade100 : Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  containsAllergens ? Icons.warning : Icons.shield,
                  color: containsAllergens ? Colors.red.shade600 : Colors.green.shade600,
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Allergen Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          !containsAllergens
              ? Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green.shade600, size: 20),
                SizedBox(width: 8),
                Text(
                  'No allergens detected',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.red.shade600, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Allergens detected: ${allergens.length}',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: allergens.map((allergen) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.red.shade300),
                  ),
                  child: Text(
                    allergen.toString().toUpperCase(),
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDietSection() {
    final dietCheck = productData?['diet_check'] as Map<String, dynamic>? ?? {};
    final dietType = dietCheck['diet_type'] ?? 'unknown';
    final isVegan = dietCheck['is_vegan'] ?? false;
    final isVegetarian = dietCheck['is_vegetarian'] ?? false;
    final nonCompliantIngredients = dietCheck['non_compliant_ingredients'] as List<dynamic>? ?? [];

    final dietColor = _getDietColor(dietType);
    final dietIcon = _getDietIcon(dietType);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: dietColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(dietIcon, color: dietColor, size: 20),
              ),
              SizedBox(width: 12),
              Text(
                'Diet Compatibility',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: dietColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: dietColor.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(dietIcon, color: dietColor, size: 24),
                    SizedBox(width: 12),
                    Text(
                      dietType.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: dietColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    _buildDietBadge('Vegan', isVegan),
                    SizedBox(width: 8),
                    _buildDietBadge('Vegetarian', isVegetarian),
                  ],
                ),
                if (nonCompliantIngredients.isNotEmpty) ...[
                  SizedBox(height: 12),
                  Text(
                    'Non-compliant ingredients:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: nonCompliantIngredients.map((ingredient) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.orange.shade300),
                      ),
                      child: Text(
                        ingredient.toString(),
                        style: TextStyle(
                          color: Colors.orange.shade700,
                          fontSize: 12,
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDietBadge(String label, bool isCompliant) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isCompliant ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompliant ? Colors.green.shade300 : Colors.red.shade300,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isCompliant ? Icons.check : Icons.close,
            size: 14,
            color: isCompliant ? Colors.green.shade700 : Colors.red.shade700,
          ),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isCompliant ? Colors.green.shade700 : Colors.red.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiseaseRiskSection() {
    final diseaseRisk = productData?['disease_risk_assessment'] as Map<String, dynamic>? ?? {};
    final hasRisks = diseaseRisk['has_risks'] ?? false;
    final riskCategories = diseaseRisk['risk_categories'] as List<dynamic>? ?? [];
    final riskDetails = diseaseRisk['risk_details'] as Map<String, dynamic>? ?? {};

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: hasRisks ? Colors.orange.shade100 : Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  hasRisks ? Icons.health_and_safety : Icons.favorite,
                  color: hasRisks ? Colors.orange.shade600 : Colors.green.shade600,
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Health Risk Assessment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          !hasRisks
              ? Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green.shade600, size: 20),
                SizedBox(width: 8),
                Text(
                  'No significant health risks detected',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.orange.shade600, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Risk categories found: ${riskCategories.length}',
                      style: TextStyle(
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              ...riskCategories.map((category) {
                final ingredients = riskDetails[category] as List<dynamic>? ?? [];
                return Container(
                  margin: EdgeInsets.only(bottom: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.toString().replaceAll('_', ' ').toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange.shade700,
                        ),
                      ),
                      if (ingredients.isNotEmpty) ...[
                        SizedBox(height: 6),
                        Text(
                          'Ingredients: ${ingredients.join(', ')}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange.shade600,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsSection() {
    final ingredients = productData?['ingredients'] as Map<String, dynamic>? ?? {};
    final fullList = ingredients['full_list'] ?? '';
    final ingredientsArray = ingredients['ingredients_array'] as List<dynamic>? ?? [];

    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
    BoxShadow(
    color: Colors.green.withOpacity(0.1),
    blurRadius: 10,
    offset: Offset(0, 3),
    ),
    ],
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    children: [
    Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
    color: Colors.teal.shade100,
    borderRadius: BorderRadius.circular(8),
    ),
      child: Icon(Icons.list, color: Colors.teal.shade600, size: 20),
    ),
      SizedBox(width: 12),
      Text(
        'Ingredients',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade800,
        ),
      ),
    ],
    ),
      SizedBox(height: 16),
      if (fullList.isNotEmpty) ...[
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Ingredients List:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                fullList,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.teal.shade600,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
      ],
      if (ingredientsArray.isNotEmpty) ...[
        Text(
          'Individual Ingredients:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ingredientsArray.map((ingredient) => Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.teal.shade300),
            ),
            child: Text(
              ingredient.toString(),
              style: TextStyle(
                color: Colors.teal.shade700,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
      if (fullList.isEmpty && ingredientsArray.isEmpty)
        Text(
          'No ingredients information available',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
    ],
    ),
    );
  }

  Color _getDietColor(String dietType) {
    switch (dietType.toLowerCase()) {
      case 'vegan':
        return Colors.green;
      case 'vegetarian':
        return Colors.lightGreen;
      case 'non-vegetarian':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getDietIcon(String dietType) {
    switch (dietType.toLowerCase()) {
      case 'vegan':
        return Icons.eco;
      case 'vegetarian':
        return Icons.spa;
      case 'non-vegetarian':
        return Icons.restaurant;
      default:
        return Icons.help_outline;
    }
  }
}
