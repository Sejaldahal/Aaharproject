//
// import 'package:flutter/material.dart';
//
// class ProductInfoPage extends StatelessWidget {
//   final Map<String, dynamic> product;
//
//   const ProductInfoPage({Key? key, required this.product}) : super(key: key);
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
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Brand: $brand", style: TextStyle(fontSize: 18)),
//                 SizedBox(height: 10),
//                 Text("Category: $category", style: TextStyle(fontSize: 18)),
//                 SizedBox(height: 20),
//                 Text("Ingredients:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 6),
//                 Text(ingredients),
//                 SizedBox(height: 20),
//                 if (allergens.isNotEmpty)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Allergens:",
//                           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
//                       ...List.generate(
//                         allergens.length,
//                             (index) => Text(
//                           allergens[index].replaceAll('en:', ''),
//                           style: TextStyle(color: Colors.red, fontSize: 16),
//                         ),
//                       ),
//                     ],
//                   )
//                 else
//                   Text("No allergens found", style: TextStyle(fontSize: 16, color: Colors.grey)),
//
//                 SizedBox(height: 30),
//                 Text("Nutrients (per 100g):", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 10),
//                 GridView.count(
//                   crossAxisCount: 2,
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   childAspectRatio: 3,
//                   mainAxisSpacing: 8,
//                   crossAxisSpacing: 8,
//                   children: [
//                     _buildNutrientCard("Energy", "${nutriments['energy-kcal_100g'] ?? '-'} kcal"),
//                     _buildNutrientCard("Fat", "${nutriments['fat_100g'] ?? '-'} g"),
//                     _buildNutrientCard("Sat. Fat", "${nutriments['saturated-fat_100g'] ?? '-'} g"),
//                     _buildNutrientCard("Carbs", "${nutriments['carbohydrates_100g'] ?? '-'} g"),
//                     _buildNutrientCard("Sugars", "${nutriments['sugars_100g'] ?? '-'} g"),
//                     _buildNutrientCard("Fiber", "${nutriments['fiber_100g'] ?? '-'} g"),
//                     _buildNutrientCard("Protein", "${nutriments['proteins_100g'] ?? '-'} g"),
//                     _buildNutrientCard("Salt", "${nutriments['salt_100g'] ?? '-'} g"),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNutrientCard(String label, String value) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.green[50],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.green.shade200),
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
//           SizedBox(height: 4),
//           Text(value, style: TextStyle(color: Colors.black87)),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class ProductInfoPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductInfoPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = product['product'] ?? {};
    final name = productData['product_name'] ?? 'Unknown';
    final brand = productData['brands'] ?? 'N/A';
    final category = productData['categories'] ?? 'N/A';
    final ingredients = productData['ingredients_text'] ?? 'Not available';
    final allergens = productData['allergens_tags'] ?? [];
    final nutriments = productData['nutriments'] ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.green,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Brand: $brand", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text("Category: $category", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 20),
                    Text("Ingredients:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text(ingredients),
                    SizedBox(height: 20),
                    if (allergens.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Allergens:",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
                          ...allergens.map(
                                (tag) => Text(
                              tag.replaceAll('en:', ''),
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                        ],
                      )
                    else
                      Text("No allergens found", style: TextStyle(fontSize: 16, color: Colors.grey)),
                    SizedBox(height: 30),
                    Text("Nutrients (per 100g):", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildNutrientCard("Energy", "${nutriments['energy-kcal_100g'] ?? '-'} kcal"),
                        _buildNutrientCard("Fat", "${nutriments['fat_100g'] ?? '-'} g"),
                        _buildNutrientCard("Sat. Fat", "${nutriments['saturated-fat_100g'] ?? '-'} g"),
                        _buildNutrientCard("Carbs", "${nutriments['carbohydrates_100g'] ?? '-'} g"),
                        _buildNutrientCard("Sugars", "${nutriments['sugars_100g'] ?? '-'} g"),
                        _buildNutrientCard("Fiber", "${nutriments['fiber_100g'] ?? '-'} g"),
                        _buildNutrientCard("Protein", "${nutriments['proteins_100g'] ?? '-'} g"),
                        _buildNutrientCard("Salt", "${nutriments['salt_100g'] ?? '-'} g"),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNutrientCard(String label, String value) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(value, style: TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}
