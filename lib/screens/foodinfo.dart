// // //
// // // import 'package:flutter/material.dart';
// // //
// // // class ProductInfoPage extends StatelessWidget {
// // //   final Map<String, dynamic> product;
// // //
// // //   const ProductInfoPage({Key? key, required this.product}) : super(key: key);
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final productData = product['product'] ?? {};
// // //     final name = productData['product_name'] ?? 'Unknown';
// // //     final brand = productData['brands'] ?? 'N/A';
// // //     final category = productData['categories'] ?? 'N/A';
// // //     final ingredients = productData['ingredients_text'] ?? 'Not available';
// // //     final allergens = productData['allergens_tags'] ?? [];
// // //     final nutriments = productData['nutriments'] ?? {};
// // //
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text(name),
// // //         backgroundColor: Colors.green,
// // //       ),
// // //       body: SafeArea(
// // //         child: Padding(
// // //           padding: const EdgeInsets.all(16.0),
// // //           child: SingleChildScrollView(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text("Brand: $brand", style: TextStyle(fontSize: 18)),
// // //                 SizedBox(height: 10),
// // //                 Text("Category: $category", style: TextStyle(fontSize: 18)),
// // //                 SizedBox(height: 20),
// // //                 Text("Ingredients:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// // //                 SizedBox(height: 6),
// // //                 Text(ingredients),
// // //                 SizedBox(height: 20),
// // //                 if (allergens.isNotEmpty)
// // //                   Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Text("Allergens:",
// // //                           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
// // //                       ...List.generate(
// // //                         allergens.length,
// // //                             (index) => Text(
// // //                           allergens[index].replaceAll('en:', ''),
// // //                           style: TextStyle(color: Colors.red, fontSize: 16),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   )
// // //                 else
// // //                   Text("No allergens found", style: TextStyle(fontSize: 16, color: Colors.grey)),
// // //
// // //                 SizedBox(height: 30),
// // //                 Text("Nutrients (per 100g):", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// // //                 SizedBox(height: 10),
// // //                 GridView.count(
// // //                   crossAxisCount: 2,
// // //                   shrinkWrap: true,
// // //                   physics: NeverScrollableScrollPhysics(),
// // //                   childAspectRatio: 3,
// // //                   mainAxisSpacing: 8,
// // //                   crossAxisSpacing: 8,
// // //                   children: [
// // //                     _buildNutrientCard("Energy", "${nutriments['energy-kcal_100g'] ?? '-'} kcal"),
// // //                     _buildNutrientCard("Fat", "${nutriments['fat_100g'] ?? '-'} g"),
// // //                     _buildNutrientCard("Sat. Fat", "${nutriments['saturated-fat_100g'] ?? '-'} g"),
// // //                     _buildNutrientCard("Carbs", "${nutriments['carbohydrates_100g'] ?? '-'} g"),
// // //                     _buildNutrientCard("Sugars", "${nutriments['sugars_100g'] ?? '-'} g"),
// // //                     _buildNutrientCard("Fiber", "${nutriments['fiber_100g'] ?? '-'} g"),
// // //                     _buildNutrientCard("Protein", "${nutriments['proteins_100g'] ?? '-'} g"),
// // //                     _buildNutrientCard("Salt", "${nutriments['salt_100g'] ?? '-'} g"),
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildNutrientCard(String label, String value) {
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         color: Colors.green[50],
// // //         borderRadius: BorderRadius.circular(12),
// // //         border: Border.all(color: Colors.green.shade200),
// // //       ),
// // //       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
// // //           SizedBox(height: 4),
// // //           Text(value, style: TextStyle(color: Colors.black87)),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// // import 'package:flutter/material.dart';
// //
// // class ProductInfoPage extends StatelessWidget {
// //   final Map<String, dynamic> product;
// //
// //   const ProductInfoPage({Key? key, required this.product}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final productData = product['product'] ?? {};
// //     final name = productData['product_name'] ?? 'Unknown';
// //     final brand = productData['brands'] ?? 'N/A';
// //     final category = productData['categories'] ?? 'N/A';
// //     final ingredients = productData['ingredients_text'] ?? 'Not available';
// //     final allergens = productData['allergens_tags'] ?? [];
// //     final nutriments = productData['nutriments'] ?? {};
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(name),
// //         backgroundColor: Colors.green,
// //       ),
// //       body: LayoutBuilder(
// //         builder: (context, constraints) {
// //           return SingleChildScrollView(
// //             padding: const EdgeInsets.all(16.0),
// //             child: ConstrainedBox(
// //               constraints: BoxConstraints(minHeight: constraints.maxHeight),
// //               child: IntrinsicHeight(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text("Brand: $brand", style: TextStyle(fontSize: 18)),
// //                     SizedBox(height: 10),
// //                     Text("Category: $category", style: TextStyle(fontSize: 18)),
// //                     SizedBox(height: 20),
// //                     Text("Ingredients:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// //                     SizedBox(height: 6),
// //                     Text(ingredients),
// //                     SizedBox(height: 20),
// //                     if (allergens.isNotEmpty)
// //                       Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text("Allergens:",
// //                               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
// //                           ...allergens.map(
// //                                 (tag) => Text(
// //                               tag.replaceAll('en:', ''),
// //                               style: TextStyle(color: Colors.red, fontSize: 16),
// //                             ),
// //                           ),
// //                         ],
// //                       )
// //                     else
// //                       Text("No allergens found", style: TextStyle(fontSize: 16, color: Colors.grey)),
// //                     SizedBox(height: 30),
// //                     Text("Nutrients (per 100g):", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// //                     SizedBox(height: 10),
// //                     Wrap(
// //                       spacing: 8,
// //                       runSpacing: 8,
// //                       children: [
// //                         _buildNutrientCard("Energy", "${nutriments['energy-kcal_100g'] ?? '-'} kcal"),
// //                         _buildNutrientCard("Fat", "${nutriments['fat_100g'] ?? '-'} g"),
// //                         _buildNutrientCard("Sat. Fat", "${nutriments['saturated-fat_100g'] ?? '-'} g"),
// //                         _buildNutrientCard("Carbs", "${nutriments['carbohydrates_100g'] ?? '-'} g"),
// //                         _buildNutrientCard("Sugars", "${nutriments['sugars_100g'] ?? '-'} g"),
// //                         _buildNutrientCard("Fiber", "${nutriments['fiber_100g'] ?? '-'} g"),
// //                         _buildNutrientCard("Protein", "${nutriments['proteins_100g'] ?? '-'} g"),
// //                         _buildNutrientCard("Salt", "${nutriments['salt_100g'] ?? '-'} g"),
// //                       ],
// //                     ),
// //                     SizedBox(height: 20),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   Widget _buildNutrientCard(String label, String value) {
// //     return Container(
// //       width: 160,
// //       padding: EdgeInsets.all(12),
// //       decoration: BoxDecoration(
// //         color: Colors.green[50],
// //         borderRadius: BorderRadius.circular(12),
// //         border: Border.all(color: Colors.green.shade200),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
// //           SizedBox(height: 4),
// //           Text(value, style: TextStyle(color: Colors.black87)),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
//
// class ProductInfoPage extends StatelessWidget {
//   final Map<String, dynamic> product;
//
//   const ProductInfoPage({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     final productData = product['product'] ?? {};
//     final name = productData['product_name'] ?? 'Unknown';
//     final brand = productData['brands'] ?? 'N/A';
//     final category = productData['categories'] ?? 'N/A';
//     final ingredients = productData['ingredients_text'] ?? 'Not available';
//     final allergens = productData['allergens_tags'] ?? [];
//     final nutriments = productData['nutriments'] ?? {};
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(name),
//         backgroundColor: Colors.green,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Basic Info Section
//               _buildInfoSection([
//                 _buildInfoRow("Brand", brand),
//                 _buildInfoRow("Category", category),
//               ]),
//
//               const SizedBox(height: 20),
//
//               // Ingredients Section
//               _buildSectionTitle("Ingredients"),
//               const SizedBox(height: 8),
//               Text(
//                 ingredients,
//                 style: const TextStyle(fontSize: 16),
//               ),
//
//               const SizedBox(height: 20),
//
//               // Allergens Section
//               _buildSectionTitle("Allergens"),
//               const SizedBox(height: 8),
//               _buildAllergensSection(allergens),
//
//               const SizedBox(height: 20),
//
//               // Nutrients Section
//               _buildSectionTitle("Nutrients (per 100g)"),
//               const SizedBox(height: 12),
//               _buildNutrientsGrid(nutriments),
//
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoSection(List<Widget> children) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: children,
//     );
//   }
//
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Text(
//         "$label: $value",
//         style: const TextStyle(fontSize: 18),
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
//
//   Widget _buildAllergensSection(List allergens) {
//     if (allergens.isEmpty) {
//       return const Text(
//         "No allergens found",
//         style: TextStyle(fontSize: 16, color: Colors.grey),
//       );
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: allergens.map<Widget>((tag) {
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 4.0),
//           child: Text(
//             tag.toString().replaceAll('en:', ''),
//             style: const TextStyle(color: Colors.red, fontSize: 16),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildNutrientsGrid(Map<String, dynamic> nutriments) {
//     final nutrients = [
//       {"label": "Energy", "value": "${nutriments['energy-kcal_100g'] ?? '-'} kcal"},
//       {"label": "Fat", "value": "${nutriments['fat_100g'] ?? '-'} g"},
//       {"label": "Sat. Fat", "value": "${nutriments['saturated-fat_100g'] ?? '-'} g"},
//       {"label": "Carbs", "value": "${nutriments['carbohydrates_100g'] ?? '-'} g"},
//       {"label": "Sugars", "value": "${nutriments['sugars_100g'] ?? '-'} g"},
//       {"label": "Fiber", "value": "${nutriments['fiber_100g'] ?? '-'} g"},
//       {"label": "Protein", "value": "${nutriments['proteins_100g'] ?? '-'} g"},
//       {"label": "Salt", "value": "${nutriments['salt_100g'] ?? '-'} g"},
//     ];
//
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 2.5,
//         mainAxisSpacing: 8,
//         crossAxisSpacing: 8,
//       ),
//       itemCount: nutrients.length,
//       itemBuilder: (context, index) {
//         final nutrient = nutrients[index];
//         return _buildNutrientCard(
//           nutrient["label"] as String,
//           nutrient["value"] as String,
//         );
//       },
//     );
//   }
//
//   Widget _buildNutrientCard(String label, String value) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.green[50],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.green.shade200),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//           const SizedBox(height: 4),
//           Text(
//             value,
//             style: const TextStyle(
//               color: Colors.black87,
//               fontSize: 14,
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
// }


//New
// import 'package:flutter/material.dart';
//
// class ProductInfoPage extends StatelessWidget {
//   final Map<String, dynamic> product;
//
//   const ProductInfoPage({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     final productData = Map<String, dynamic>.from(product['product'] ?? {});
//     final name = productData['product_name']?.toString() ?? 'Unknown';
//     final brand = productData['brands']?.toString() ?? 'N/A';
//     final category = productData['categories']?.toString() ?? 'N/A';
//     final ingredients = productData['ingredients_text']?.toString() ?? 'Not available';
//     final allergens = List.from(productData['allergens_tags'] ?? []);
//     final nutriments = Map<String, dynamic>.from(productData['nutriments'] ?? {});
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(name),
//         backgroundColor: Colors.green,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Basic Info Section
//               _buildInfoSection([
//                 _buildInfoRow("Brand", brand),
//                 _buildInfoRow("Category", category),
//               ]),
//
//               const SizedBox(height: 20),
//
//               // Ingredients Section
//               _buildSectionTitle("Ingredients"),
//               const SizedBox(height: 8),
//               Text(
//                 ingredients,
//                 style: const TextStyle(fontSize: 16),
//               ),
//
//               const SizedBox(height: 20),
//
//               // Allergens Section
//               _buildSectionTitle("Allergens"),
//               const SizedBox(height: 8),
//               _buildAllergensSection(allergens),
//
//               const SizedBox(height: 20),
//
//               // Nutrients Section
//               _buildSectionTitle("Nutrients (per 100g)"),
//               const SizedBox(height: 12),
//               _buildNutrientsGrid(nutriments),
//
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoSection(List<Widget> children) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: children,
//     );
//   }
//
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Text(
//         "$label: $value",
//         style: const TextStyle(fontSize: 18),
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
//
//   Widget _buildAllergensSection(List allergens) {
//     if (allergens.isEmpty) {
//       return const Text(
//         "No allergens found",
//         style: TextStyle(fontSize: 16, color: Colors.grey),
//       );
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: allergens.map<Widget>((tag) {
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 4.0),
//           child: Text(
//             tag.toString().replaceAll('en:', ''),
//             style: const TextStyle(color: Colors.red, fontSize: 16),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildNutrientsGrid(Map<String, dynamic> nutriments) {
//     final nutrients = [
//       {"label": "Energy", "value": "${nutriments['energy-kcal_100g']?.toString() ?? '-'} kcal"},
//       {"label": "Fat", "value": "${nutriments['fat_100g']?.toString() ?? '-'} g"},
//       {"label": "Sat. Fat", "value": "${nutriments['saturated-fat_100g']?.toString() ?? '-'} g"},
//       {"label": "Carbs", "value": "${nutriments['carbohydrates_100g']?.toString() ?? '-'} g"},
//       {"label": "Sugars", "value": "${nutriments['sugars_100g']?.toString() ?? '-'} g"},
//       {"label": "Fiber", "value": "${nutriments['fiber_100g']?.toString() ?? '-'} g"},
//       {"label": "Protein", "value": "${nutriments['proteins_100g']?.toString() ?? '-'} g"},
//       {"label": "Salt", "value": "${nutriments['salt_100g']?.toString() ?? '-'} g"},
//     ];
//
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 2.8, // Increased to prevent overflow
//         mainAxisSpacing: 8,
//         crossAxisSpacing: 8,
//       ),
//       itemCount: nutrients.length,
//       itemBuilder: (context, index) {
//         final nutrient = nutrients[index];
//         return _buildNutrientCard(
//           nutrient["label"] as String,
//           nutrient["value"] as String,
//         );
//       },
//     );
//   }
//
//   Widget _buildNutrientCard(String label, String value) {
//     return Container(
//       padding: const EdgeInsets.all(10), // Reduced padding
//       decoration: BoxDecoration(
//         color: Colors.green[50],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.green.shade200),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min, // Added to prevent overflow
//         children: [
//           Flexible( // Wrapped in Flexible to prevent overflow
//             child: Text(
//               label,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 13, // Slightly smaller font
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           const SizedBox(height: 2), // Reduced spacing
//           Flexible( // Wrapped in Flexible to prevent overflow
//             child: Text(
//               value,
//               style: const TextStyle(
//                 color: Colors.black87,
//                 fontSize: 13, // Slightly smaller font
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ProductInfoPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductInfoPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productData = Map<String, dynamic>.from(product['product'] ?? {});
    final name = productData['product_name']?.toString() ?? 'Unknown';
    final brand = productData['brands']?.toString() ?? 'N/A';
    final category = productData['categories']?.toString() ?? 'N/A';
    final ingredients = productData['ingredients_text']?.toString() ?? 'Not available';
    final allergens = List.from(productData['allergens_tags'] ?? []);
    final nutriments = Map<String, dynamic>.from(productData['nutriments'] ?? {});

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Health & Dietary Analysis Section
              _buildHealthAnalysisSection(ingredients, allergens, nutriments, productData),

              const SizedBox(height: 20),

              // Basic Info Section
              _buildInfoSection([
                _buildInfoRow("Brand", brand),
                _buildInfoRow("Category", category),
              ]),

              const SizedBox(height: 20),

              // Ingredients Section
              _buildSectionTitle("Ingredients"),
              const SizedBox(height: 8),
              Text(
                ingredients,
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 20),

              // Allergens Section
              _buildSectionTitle("Allergens"),
              const SizedBox(height: 8),
              _buildAllergensSection(allergens),

              const SizedBox(height: 20),

              // Nutrients Section
              _buildSectionTitle("Nutrients (per 100g)"),
              const SizedBox(height: 12),
              _buildNutrientsGrid(nutriments),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthAnalysisSection(String ingredients, List allergens, Map<String, dynamic> nutriments, Map<String, dynamic> productData) {
    final analysis = _analyzeProduct(ingredients, allergens, nutriments, productData);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.green.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.health_and_safety, color: Colors.blue.shade700, size: 24),
              const SizedBox(width: 8),
              Text(
                "Health & Dietary Analysis",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: analysis.map((item) => _buildAnalysisChip(item)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisChip(Map<String, dynamic> analysis) {
    final IconData icon = analysis['icon'];
    final Color color = analysis['color'];
    final String label = analysis['label'];
    final String description = analysis['description'];

    return Tooltip(
      message: description,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _analyzeProduct(String ingredients, List allergens, Map<String, dynamic> nutriments, Map<String, dynamic> productData) {
    List<Map<String, dynamic>> analysis = [];

    // Convert ingredients to lowercase for analysis
    final ingredientsLower = ingredients.toLowerCase();

    // Dietary Analysis
    final dietaryAnalysis = _analyzeDietary(ingredientsLower, allergens);
    analysis.addAll(dietaryAnalysis);

    // Diabetes Analysis
    final diabetesAnalysis = _analyzeDiabetes(nutriments, ingredientsLower);
    analysis.addAll(diabetesAnalysis);

    // Allergen Analysis
    final allergenAnalysis = _analyzeAllergens(allergens);
    analysis.addAll(allergenAnalysis);

    // Nutritional Health Score
    final healthAnalysis = _analyzeNutritionalHealth(nutriments, ingredientsLower);
    analysis.addAll(healthAnalysis);

    return analysis;
  }

  List<Map<String, dynamic>> _analyzeDietary(String ingredients, List allergens) {
    List<Map<String, dynamic>> dietary = [];

    // Non-vegetarian indicators
    final nonVegIndicators = [
      'chicken', 'beef', 'pork', 'lamb', 'fish', 'seafood', 'meat', 'gelatin',
      'lard', 'bacon', 'ham', 'turkey', 'duck', 'tuna', 'salmon', 'shrimp'
    ];

    // Vegetarian but not vegan indicators
    final nonVeganIndicators = [
      'milk', 'cheese', 'butter', 'cream', 'yogurt', 'whey', 'casein',
      'lactose', 'egg', 'honey', 'albumin', 'mayonnaise'
    ];

    bool isNonVeg = nonVegIndicators.any((indicator) => ingredients.contains(indicator));
    bool hasAnimalProducts = nonVeganIndicators.any((indicator) => ingredients.contains(indicator));

    if (isNonVeg) {
      dietary.add({
        'icon': Icons.dining,
        'color': Colors.red.shade600,
        'label': 'Non-Vegetarian',
        'description': 'Contains meat, fish, or other animal-derived ingredients'
      });
    } else if (hasAnimalProducts) {
      dietary.add({
        'icon': Icons.eco,
        'color': Colors.orange.shade600,
        'label': 'Vegetarian',
        'description': 'Suitable for vegetarians but contains dairy/eggs'
      });
    } else {
      dietary.add({
        'icon': Icons.local_florist,
        'color': Colors.green.shade600,
        'label': 'Vegan',
        'description': 'Plant-based, no animal products detected'
      });
    }

    return dietary;
  }

  List<Map<String, dynamic>> _analyzeDiabetes(Map<String, dynamic> nutriments, String ingredients) {
    List<Map<String, dynamic>> diabetes = [];

    // Get sugar content
    final sugars = double.tryParse(nutriments['sugars_100g']?.toString() ?? '0') ?? 0;
    final carbs = double.tryParse(nutriments['carbohydrates_100g']?.toString() ?? '0') ?? 0;

    // Check for artificial sweeteners
    final artificialSweeteners = [
      'aspartame', 'sucralose', 'acesulfame', 'saccharin', 'stevia'
    ];
    bool hasArtificialSweeteners = artificialSweeteners.any((sweetener) =>
        ingredients.contains(sweetener));

    if (sugars > 20) {
      diabetes.add({
        'icon': Icons.warning,
        'color': Colors.red.shade600,
        'label': 'High Sugar',
        'description': 'High sugar content (${sugars.toStringAsFixed(1)}g per 100g) - Not suitable for diabetics'
      });
    } else if (sugars > 10) {
      diabetes.add({
        'icon': Icons.info,
        'color': Colors.orange.shade600,
        'label': 'Moderate Sugar',
        'description': 'Moderate sugar content (${sugars.toStringAsFixed(1)}g per 100g) - Consume with caution'
      });
    } else if (hasArtificialSweeteners || sugars <= 5) {
      diabetes.add({
        'icon': Icons.check_circle,
        'color': Colors.green.shade600,
        'label': 'Diabetic Friendly',
        'description': 'Low sugar content (${sugars.toStringAsFixed(1)}g per 100g) - Generally safe for diabetics'
      });
    }

    return diabetes;
  }

  List<Map<String, dynamic>> _analyzeAllergens(List allergens) {
    List<Map<String, dynamic>> allergenAnalysis = [];

    if (allergens.isNotEmpty) {
      allergenAnalysis.add({
        'icon': Icons.warning_amber,
        'color': Colors.red.shade600,
        'label': 'Contains Allergens',
        'description': 'Contains ${allergens.length} allergen(s) - Check ingredient list'
      });
    } else {
      allergenAnalysis.add({
        'icon': Icons.shield,
        'color': Colors.green.shade600,
        'label': 'No Known Allergens',
        'description': 'No common allergens detected'
      });
    }

    return allergenAnalysis;
  }

  List<Map<String, dynamic>> _analyzeNutritionalHealth(Map<String, dynamic> nutriments, String ingredients) {
    List<Map<String, dynamic>> health = [];

    // Get nutritional values
    final fat = double.tryParse(nutriments['fat_100g']?.toString() ?? '0') ?? 0;
    final saturatedFat = double.tryParse(nutriments['saturated-fat_100g']?.toString() ?? '0') ?? 0;
    final salt = double.tryParse(nutriments['salt_100g']?.toString() ?? '0') ?? 0;
    final fiber = double.tryParse(nutriments['fiber_100g']?.toString() ?? '0') ?? 0;
    final protein = double.tryParse(nutriments['proteins_100g']?.toString() ?? '0') ?? 0;

    // Calculate health score
    int healthScore = 0;

    // Positive factors
    if (fiber > 3) healthScore += 2;
    if (protein > 10) healthScore += 2;
    if (saturatedFat < 5) healthScore += 1;
    if (salt < 1.5) healthScore += 1;

    // Negative factors
    if (saturatedFat > 10) healthScore -= 2;
    if (salt > 2.5) healthScore -= 2;
    if (fat > 30) healthScore -= 1;

    // Check for processed ingredients
    final processedIndicators = [
      'preservative', 'artificial', 'modified', 'hydrogenated', 'msg'
    ];
    bool hasProcessedIngredients = processedIndicators.any((indicator) =>
        ingredients.contains(indicator));

    if (hasProcessedIngredients) healthScore -= 1;

    if (healthScore >= 3) {
      health.add({
        'icon': Icons.favorite,
        'color': Colors.green.shade600,
        'label': 'Healthy Choice',
        'description': 'Good nutritional profile with beneficial nutrients'
      });
    } else if (healthScore >= 0) {
      health.add({
        'icon': Icons.balance,
        'color': Colors.orange.shade600,
        'label': 'Moderate',
        'description': 'Average nutritional profile - consume in moderation'
      });
    } else {
      health.add({
        'icon': Icons.warning,
        'color': Colors.red.shade600,
        'label': 'Less Healthy',
        'description': 'High in saturated fat, salt, or processed ingredients'
      });
    }

    return health;
  }

  Widget _buildInfoSection(List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 18, color: Colors.black),
          children: [
            TextSpan(
              text: "$label: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAllergensSection(List allergens) {
    if (allergens.isEmpty) {
      return const Text(
        "No allergens found",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: allergens.map<Widget>((tag) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            tag.toString().replaceAll('en:', ''),
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNutrientsGrid(Map<String, dynamic> nutriments) {
    final nutrients = [
      {"label": "Energy", "value": "${nutriments['energy-kcal_100g']?.toString() ?? '-'} kcal"},
      {"label": "Fat", "value": "${nutriments['fat_100g']?.toString() ?? '-'} g"},
      {"label": "Sat. Fat", "value": "${nutriments['saturated-fat_100g']?.toString() ?? '-'} g"},
      {"label": "Carbs", "value": "${nutriments['carbohydrates_100g']?.toString() ?? '-'} g"},
      {"label": "Sugars", "value": "${nutriments['sugars_100g']?.toString() ?? '-'} g"},
      {"label": "Fiber", "value": "${nutriments['fiber_100g']?.toString() ?? '-'} g"},
      {"label": "Protein", "value": "${nutriments['proteins_100g']?.toString() ?? '-'} g"},
      {"label": "Salt", "value": "${nutriments['salt_100g']?.toString() ?? '-'} g"},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.8, // Increased to prevent overflow
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: nutrients.length,
      itemBuilder: (context, index) {
        final nutrient = nutrients[index];
        return _buildNutrientCard(
          nutrient["label"] as String,
          nutrient["value"] as String,
        );
      },
    );
  }

  Widget _buildNutrientCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(10), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Added to prevent overflow
        children: [
          Flexible( // Wrapped in Flexible to prevent overflow
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13, // Slightly smaller font
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 2), // Reduced spacing
          Flexible( // Wrapped in Flexible to prevent overflow
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 13, // Slightly smaller font
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}