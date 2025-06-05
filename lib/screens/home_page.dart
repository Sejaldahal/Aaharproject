// import 'package:flutter/material.dart';
// import 'scan_page.dart';
// import 'article_page.dart'; // Add this import
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//
//     if (index == 1) {
//       // Navigate to Scan page when QR scanner icon is tapped
//       Navigator.push(context, MaterialPageRoute(builder: (_) => ScanPage()));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Center(
//                 child: Column(
//                   children: [
//                     Text(
//                       "Hello User,",
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       "Scan. Check. Choose.",
//                       style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: 20),
//
//               // Article card
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Color(0xFFFFF6EF),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 padding: const EdgeInsets.all(16),
//                 child: Row(
//                   children: [
//                     // Left side content
//                     Expanded(
//                       flex: 2,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("ARTICLE", style: TextStyle(color: Colors.redAccent, letterSpacing: 1)),
//                           SizedBox(height: 8),
//                           Text(
//                             "The pros and cons\nof packaged food.",
//                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(height: 12),
//                           ElevatedButton(
//                             onPressed: () {
//                               // Navigate to ArticlePage
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(builder: (_) => ArticlePage())
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.redAccent,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                             ),
//                             child: Text("Read Now", style: TextStyle(color: Colors.white)),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(width: 16),
//
//                     // Right side image
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         height: 120,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           image: DecorationImage(
//                             image: AssetImage('assets/images/packaged_food.png'),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Scan Now card
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (_) => ScanPage()));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Color(0xFFB9A9E1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   padding: const EdgeInsets.all(20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           "Scan any product\nto get instant insights.",
//                           style: TextStyle(fontSize: 16, color: Colors.white),
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (_) => ScanPage()));
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: Colors.purple,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text("Scan Now"),
//                             Icon(Icons.arrow_forward_ios, size: 16),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//}

import 'package:flutter/material.dart';
import 'scan_page.dart';
import 'article_page.dart';
import 'nutrient_assistant_chat_page.dart'; // Import the assistant chat page

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ScanPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ChatbotPage()),
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.chat),
        tooltip: "Nutrient Assistant",
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      "Hello User,",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Scan. Check. Choose.",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Article card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFFFF6EF),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Left side content
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ARTICLE", style: TextStyle(color: Colors.redAccent, letterSpacing: 1)),
                          SizedBox(height: 8),
                          Text(
                            "The pros and cons\nof packaged food.",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => ArticlePage())
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text("Read Now", style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 16),

                    // Right side image
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage('assets/images/packaged_food.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Scan Now card
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ScanPage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFB9A9E1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Scan any product\nto get instant insights.",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ScanPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Scan Now"),
                            Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                      ),
                    ],
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


