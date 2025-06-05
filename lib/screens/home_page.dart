// //
// // import 'package:flutter/material.dart';
// // import 'scan_page.dart';
// //
// // class HomeScreen extends StatefulWidget {
// //   const HomeScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //   int _selectedIndex = 0;
// //
// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //
// //     if (index == 1) {
// //       // Navigate to Scan page when QR scanner icon is tapped
// //       Navigator.push(context, MaterialPageRoute(builder: (_) => ScanPage()));
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _selectedIndex,
// //         onTap: _onItemTapped,
// //         items: const [
// //           BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
// //           BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: ''),
// //           BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
// //         ],
// //       ),
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               Center(
// //                 child: Column(
// //                   children: [
// //                     Text(
// //                       "Hello User,",
// //                       style: TextStyle(
// //                         fontSize: 28,
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.green,
// //                       ),
// //                     ),
// //                     SizedBox(height: 5),
// //                     Text(
// //                       "Scan. Check. Choose.",
// //                       style: TextStyle(fontSize: 16, color: Colors.grey[700]),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //
// //               SizedBox(height: 20),
// //
// //               // Article card
// //               Container(
// //                 width: double.infinity, // Makes the card take full width
// //                 decoration: BoxDecoration(
// //                   color: Color(0xFFFFF6EF),
// //                   borderRadius: BorderRadius.circular(20),
// //                 ),
// //                 padding: const EdgeInsets.all(16),
// //                 child: Row(
// //                   children: [
// //                     // Left side content
// //                     Expanded(
// //                       flex: 2,
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text("ARTICLE", style: TextStyle(color: Colors.redAccent, letterSpacing: 1)),
// //                           SizedBox(height: 8),
// //                           Text(
// //                             "The pros and cons\nof packaged food.",
// //                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                           ),
// //                           SizedBox(height: 12),
// //                           ElevatedButton(
// //                             onPressed: () {},
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: Colors.redAccent,
// //                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// //                             ),
// //                             child: Text("Read Now"),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //
// //                     SizedBox(width: 16),
// //
// //                     // Right side image
// //                     Expanded(
// //                       flex: 1,
// //                       child: Container(
// //                         height: 120,
// //                         decoration: BoxDecoration(
// //                           borderRadius: BorderRadius.circular(15),
// //                           image: DecorationImage(
// //                             image: AssetImage('assets/images/packaged_food.png'), // Replace with your image path
// //                             fit: BoxFit.cover,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //              SizedBox(height: 20),
// //
// //               // Scan Now card
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.push(context, MaterialPageRoute(builder: (_) => ScanPage()));
// //                 },
// //                 child: Container(
// //                   decoration: BoxDecoration(
// //                     color: Color(0xFFB9A9E1),
// //                     borderRadius: BorderRadius.circular(20),
// //                   ),
// //                   padding: const EdgeInsets.all(20),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Expanded(
// //                         child: Text(
// //                           "Scan any product\nto get instant insights.",
// //                           style: TextStyle(fontSize: 16, color: Colors.white),
// //                         ),
// //                       ),
// //                       ElevatedButton(
// //                         onPressed: () {
// //                           Navigator.push(context, MaterialPageRoute(builder: (_) => ScanPage()));
// //                         },
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: Colors.white,
// //                           foregroundColor: Colors.purple,
// //                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// //                         ),
// //                         child: Row(
// //                           children: [
// //                             Text("Scan Now"),
// //                             Icon(Icons.arrow_forward_ios, size: 16),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// //
//
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'scan_page.dart';
// import 'article_page.dart';
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
//   void _openChatbot() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => ChatbotPage()),
//     );
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
//
//               SizedBox(height: 20),
//
//               // New Chatbot card
//               GestureDetector(
//                 onTap: _openChatbot,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Color(0xFF4CAF50), Color(0xFF45A049)],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.green.withOpacity(0.3),
//                         spreadRadius: 2,
//                         blurRadius: 8,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   padding: const EdgeInsets.all(20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Icon(Icons.chat_bubble_outline, color: Colors.white, size: 24),
//                                 SizedBox(width: 8),
//                                 Text(
//                                   "AI Assistant",
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               "Ask anything about nutrition\nand food ingredients.",
//                               style: TextStyle(fontSize: 14, color: Colors.white70),
//                             ),
//                           ],
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: _openChatbot,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: Colors.green,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text("Chat Now"),
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
//
// // Chatbot Page
// class ChatbotPage extends StatefulWidget {
//   const ChatbotPage({Key? key}) : super(key: key);
//
//   @override
//   State<ChatbotPage> createState() => _ChatbotPageState();
// }
//
// class _ChatbotPageState extends State<ChatbotPage> {
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   List<ChatMessage> _messages = [];
//   bool _isLoading = false;
//
//   // Replace with your OpenAI API key
//   static const String _openAIApiKey = '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';
//   static const String _openAIUrl = 'https://api.openai.com/v1/chat/completions';
//
//   @override
//   void initState() {
//     super.initState();
//     // Add welcome message
//     _messages.add(ChatMessage(
//       text: "Hi! I'm your nutrition assistant. Ask me anything about food ingredients, nutrition facts, or healthy eating tips!",
//       isUser: false,
//     ));
//   }
//
//   Future<void> _sendMessage(String message) async {
//     if (message.trim().isEmpty) return;
//
//     setState(() {
//       _messages.add(ChatMessage(text: message, isUser: true));
//       _isLoading = true;
//     });
//
//     _messageController.clear();
//     _scrollToBottom();
//
//     try {
//       final response = await _callOpenAI(message);
//       setState(() {
//         _messages.add(ChatMessage(text: response, isUser: false));
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _messages.add(ChatMessage(
//           text: "Sorry, I'm having trouble connecting right now. Please try again later.",
//           isUser: false,
//         ));
//         _isLoading = false;
//       });
//     }
//
//     _scrollToBottom();
//   }
//
//   Future<String> _callOpenAI(String message) async {
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $_openAIApiKey',
//     };
//
//     final body = json.encode({
//       'model': 'gpt-3.5-turbo',
//       'messages': [
//         {
//           'role': 'system',
//           'content': 'You are a helpful nutrition and food expert assistant. Provide accurate, helpful information about food ingredients, nutrition, and healthy eating. Keep responses concise and friendly.'
//         },
//         {'role': 'user', 'content': message}
//       ],
//       'max_tokens': 500,
//       'temperature': 0.7,
//     });
//
//     final response = await http.post(
//       Uri.parse(_openAIUrl),
//       headers: headers,
//       body: body,
//     );
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data['choices'][0]['message']['content'].toString().trim();
//     } else {
//       throw Exception('Failed to get response from OpenAI');
//     }
//   }
//
//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Nutrition Assistant"),
//         backgroundColor: Colors.green,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               padding: EdgeInsets.all(16),
//               itemCount: _messages.length + (_isLoading ? 1 : 0),
//               itemBuilder: (context, index) {
//                 if (index == _messages.length && _isLoading) {
//                   return _buildLoadingMessage();
//                 }
//                 return _buildMessageBubble(_messages[index]);
//               },
//             ),
//           ),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessageBubble(ChatMessage message) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: [
//           if (!message.isUser) ...[
//             CircleAvatar(
//               backgroundColor: Colors.green,
//               child: Icon(Icons.smart_toy, color: Colors.white, size: 20),
//               radius: 16,
//             ),
//             SizedBox(width: 8),
//           ],
//           Flexible(
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 color: message.isUser ? Colors.green : Colors.grey[200],
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 message.text,
//                 style: TextStyle(
//                   color: message.isUser ? Colors.white : Colors.black87,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ),
//           if (message.isUser) ...[
//             SizedBox(width: 8),
//             CircleAvatar(
//               backgroundColor: Colors.grey[300],
//               child: Icon(Icons.person, color: Colors.grey[600], size: 20),
//               radius: 16,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLoadingMessage() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           CircleAvatar(
//             backgroundColor: Colors.green,
//             child: Icon(Icons.smart_toy, color: Colors.white, size: 20),
//             radius: 16,
//           ),
//           SizedBox(width: 8),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Text("Thinking..."),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessageInput() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 3,
//             offset: Offset(0, -1),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _messageController,
//               decoration: InputDecoration(
//                 hintText: "Ask about nutrition, ingredients...",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: Colors.grey[300]!),
//                 ),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               ),
//               onSubmitted: _sendMessage,
//               enabled: !_isLoading,
//             ),
//           ),
//           SizedBox(width: 8),
//           FloatingActionButton(
//             onPressed: _isLoading ? null : () => _sendMessage(_messageController.text),
//             backgroundColor: Colors.green,
//             mini: true,
//             child: Icon(Icons.send, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _messageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
// }
//
// class ChatMessage {
//   final String text;
//   final bool isUser;
//
//   ChatMessage({required this.text, required this.isUser});
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'scan_page.dart';
import 'article_page.dart';

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
      // Navigate to Scan page when QR scanner icon is tapped
      Navigator.push(context, MaterialPageRoute(builder: (_) => ScanPage()));
    }
  }

  void _openChatbot() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChatbotPage()),
    );
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
                              // Navigate to ArticlePage
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

              SizedBox(height: 20),

              // New Chatbot card
              GestureDetector(
                onTap: _openChatbot,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF4CAF50), Color(0xFF45A049)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.chat_bubble_outline, color: Colors.white, size: 24),
                                SizedBox(width: 8),
                                Text(
                                  "AI Assistant",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Ask anything about nutrition\nand food ingredients.",
                              style: TextStyle(fontSize: 14, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _openChatbot,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Chat Now"),
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

// Chatbot Page with Multiple Options
class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> _messages = [];
  bool _isLoading = false;

  // Choose your preferred option:
  // 1 = Simple Rule-based (No internet required)
  // 2 = Cohere API (Free tier - requires API key)
  // 3 = Hugging Face API (Free - no API key needed)
  int _botType = 1;

  // API Keys (only needed if using external APIs)
  static const String _cohereApiKey = 'SthW1BkodkiOUvIzg49LHtxtbsncbc21sq8VecUG'; // Get from cohere.ai
  static const String _cohereUrl = 'https://api.cohere.ai/v1/generate';
  static const String _huggingFaceUrl = 'https://api-inference.huggingface.co/models/microsoft/DialoGPT-medium';

  @override
  void initState() {
    super.initState();
    // Add welcome message
    _messages.add(ChatMessage(
      text: "Hi! I'm your nutrition assistant. Ask me anything about food ingredients, nutrition facts, healthy eating tips, or food safety!",
      isUser: false,
    ));
  }

  Future<void> _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: message, isUser: true));
      _isLoading = true;
    });

    _messageController.clear();
    _scrollToBottom();

    try {
      String response;

      switch (_botType) {
        case 1:
        // Simple rule-based responses (recommended)
          await Future.delayed(Duration(milliseconds: 500)); // Simulate thinking
          response = _getSimpleResponse(message);
          break;
        case 2:
        // Cohere API
          response = await _callCohere(message);
          break;
        case 3:
        // Hugging Face API
          response = await _callHuggingFace(message);
          break;
        default:
          response = _getSimpleResponse(message);
      }

      setState(() {
        _messages.add(ChatMessage(text: response, isUser: false));
        _isLoading = false;
      });
    } catch (e) {
      // Fallback to simple response if API fails
      final fallbackResponse = _getSimpleResponse(message);
      setState(() {
        _messages.add(ChatMessage(text: fallbackResponse, isUser: false));
        _isLoading = false;
      });
    }

    _scrollToBottom();
  }

  // Option 1: Simple Rule-Based Responses (No Internet Required)
  String _getSimpleResponse(String message) {
    String lowerMessage = message.toLowerCase();

    // Greetings
    if (lowerMessage.contains('hello') || lowerMessage.contains('hi') || lowerMessage.contains('hey')) {
      return "Hello! I'm here to help with your nutrition questions. Ask me about vitamins, proteins, healthy eating tips, or any food-related topics!";
    }

    // Protein
    if (lowerMessage.contains('protein')) {
      return "Protein is essential for muscle building and repair! Good sources include:\n• Lean meats (chicken, turkey, fish)\n• Eggs and dairy products\n• Beans, lentils & legumes\n• Nuts and seeds\n• Tofu and tempeh\n\nAdults need about 0.8g per kg of body weight daily.";
    }

    // Vitamins
    if (lowerMessage.contains('vitamin')) {
      return "Vitamins are vital nutrients your body needs! Here's a quick guide:\n• Vitamin C: Citrus fruits, berries, peppers\n• Vitamin D: Sunlight, fatty fish, fortified foods\n• Vitamin A: Carrots, sweet potatoes, leafy greens\n• B Vitamins: Whole grains, meat, eggs\n\nEat a rainbow of fruits and vegetables!";
    }

    // Sugar
    if (lowerMessage.contains('sugar') || lowerMessage.contains('sweet')) {
      return "Watch out for added sugars! Natural sugars from fruits are better as they come with fiber and nutrients. Tips:\n• Read labels carefully\n• Limit sodas and candy\n• Choose whole fruits over juice\n• Sugar has many names: high fructose corn syrup, sucrose, dextrose, etc.";
    }

    // Calories
    if (lowerMessage.contains('calorie') || lowerMessage.contains('calories')) {
      return "Calories are units of energy in food. Focus on nutrient-dense foods rather than just counting calories:\n• Fill half your plate with vegetables\n• Choose whole grains over refined\n• Include lean proteins\n• Balance intake with physical activity\n\nQuality matters more than just quantity!";
    }

    // Fats
    if (lowerMessage.contains('fat') || lowerMessage.contains('oil')) {
      return "Not all fats are bad! Choose healthy fats:\n• Good: Avocados, nuts, seeds, olive oil, fatty fish\n• Limit: Saturated fats from red meat and butter\n• Avoid: Trans fats (partially hydrogenated oils)\n\nHealthy fats support brain function and hormone production!";
    }

    // Fiber
    if (lowerMessage.contains('fiber')) {
      return "Fiber is fantastic for digestion and feeling full! Aim for 25-35g daily:\n• Whole grains (oats, brown rice, quinoa)\n• Fruits with skin (apples, pears)\n• Vegetables (broccoli, artichokes)\n• Legumes (beans, lentils)\n\nIncrease gradually and drink plenty of water!";
    }

    // Water/Hydration
    if (lowerMessage.contains('water') || lowerMessage.contains('hydration')) {
      return "Stay hydrated! Water is essential for:\n• Digestion and nutrient transport\n• Temperature regulation\n• Joint lubrication\n• Waste removal\n\nAim for 8 glasses daily, more if you're active. Signs of good hydration: pale yellow urine!";
    }

    // Organic
    if (lowerMessage.contains('organic')) {
      return "Organic foods are grown without synthetic pesticides and fertilizers. While they may have some benefits, the most important thing is eating plenty of fruits and vegetables, organic or not! If budget is tight, prioritize organic for the 'Dirty Dozen' list of produce.";
    }

    // Processed foods
    if (lowerMessage.contains('processed') || lowerMessage.contains('packaged')) {
      return "Highly processed foods often contain excess sodium, sugar, and unhealthy fats. Tips:\n• Choose minimally processed foods\n• Read ingredient lists - shorter is usually better\n• Cook at home when possible\n• If buying packaged, look for whole food ingredients\n\nFresh is best, but frozen fruits/vegetables are great too!";
    }

    // Weight loss
    if (lowerMessage.contains('weight loss') || lowerMessage.contains('lose weight')) {
      return "Healthy weight loss combines balanced nutrition with regular exercise:\n• Create a moderate calorie deficit\n• Eat plenty of vegetables and lean proteins\n• Stay consistent, not perfect\n• Aim for 1-2 pounds per week\n• Focus on building healthy habits\n\nCrash diets don't work long-term!";
    }

    // Exercise
    if (lowerMessage.contains('exercise') || lowerMessage.contains('workout')) {
      return "Exercise and nutrition work together! Benefits:\n• Improves insulin sensitivity\n• Boosts metabolism\n• Supports mental health\n• Strengthens bones\n\nAim for 150 minutes of moderate activity weekly. Both cardio and strength training are important!";
    }

    // Meal planning
    if (lowerMessage.contains('meal plan') || lowerMessage.contains('planning')) {
      return "Meal planning saves time and improves nutrition!\n• Plan a week ahead\n• Prep ingredients on weekends\n• Include a variety of colors\n• Batch cook grains and proteins\n• Keep healthy snacks ready\n\nStart small - even planning 3 meals helps!";
    }

    // Snacks
    if (lowerMessage.contains('snack') || lowerMessage.contains('snacking')) {
      return "Smart snacking can boost energy and nutrition!\n• Combine protein + fiber (apple with almond butter)\n• Keep portions moderate (handful of nuts)\n• Stay hydrated - sometimes we mistake thirst for hunger\n• Plan ahead to avoid vending machines\n\nGreat options: Greek yogurt, vegetables with hummus, berries with nuts!";
    }

    // Breakfast
    if (lowerMessage.contains('breakfast')) {
      return "Breakfast sets the tone for your day!\n• Include protein to stay satisfied\n• Add fiber from whole grains or fruits\n• Don't skip it - your brain needs fuel\n• Quick options: Greek yogurt with berries, oatmeal with nuts, eggs with vegetables\n\nA balanced breakfast helps control hunger later!";
    }

    // Iron
    if (lowerMessage.contains('iron')) {
      return "Iron is crucial for oxygen transport in blood!\n• Heme iron (better absorbed): Red meat, poultry, fish\n• Non-heme iron: Spinach, beans, fortified cereals\n• Boost absorption: Eat with vitamin C foods\n• Limit: Tea/coffee with iron-rich meals\n\nWomen need more iron than men, especially during menstruation.";
    }

    // Calcium
    if (lowerMessage.contains('calcium')) {
      return "Calcium builds strong bones and teeth!\n• Dairy: Milk, yogurt, cheese\n• Non-dairy: Leafy greens, almonds, sardines, fortified plant milks\n• Adults need 1000-1200mg daily\n• Pair with vitamin D for better absorption\n• Weight-bearing exercise also strengthens bones!";
    }

    // Thanks
    if (lowerMessage.contains('thank') || lowerMessage.contains('thanks')) {
      return "You're very welcome! I'm here to help you make healthier food choices. Remember, small changes add up to big results. Feel free to ask anything else about nutrition!";
    }

    // Goodbye
    if (lowerMessage.contains('bye') || lowerMessage.contains('goodbye')) {
      return "Goodbye! Remember to eat a balanced diet with plenty of fruits, vegetables, whole grains, and lean proteins. Stay hydrated and active. Come back anytime with nutrition questions!";
    }

    // Default response for unmatched queries
    List<String> defaultResponses = [
      "That's an interesting nutrition question! While I'm still learning, I recommend focusing on a balanced diet with plenty of fruits, vegetables, whole grains, and lean proteins. Is there a specific aspect of nutrition you'd like to know more about?",
      "Great question! For the best nutritional advice, I always recommend consulting with a registered dietitian. In the meantime, focus on eating a variety of colorful foods and staying hydrated. What specific topic would you like to explore?",
      "I'd love to help with that! While I have general nutrition knowledge, remember that individual needs vary. A balanced approach with whole foods is usually best. Can you ask me about a specific nutrient or food group?",
    ];

    return defaultResponses[(message.length % defaultResponses.length)];
  }

  // Option 2: Cohere API Integration
  Future<String> _callCohere(String message) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_cohereApiKey',
    };

    final body = json.encode({
      'model': 'command-light',
      'prompt': 'You are a helpful nutrition expert assistant. Provide accurate, helpful information about food ingredients, nutrition, and healthy eating. Keep responses concise and friendly.\n\nUser: $message\n\nNutrition Expert:',
      'max_tokens': 300,
      'temperature': 0.7,
    });

    final response = await http.post(
      Uri.parse(_cohereUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['generations'][0]['text'].toString().trim();
    } else {
      throw Exception('Failed to get response from Cohere');
    }
  }

  // Option 3: Hugging Face API Integration
  Future<String> _callHuggingFace(String message) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = json.encode({
      'inputs': message,
      'parameters': {
        'max_length': 100,
        'temperature': 0.7,
      }
    });

    final response = await http.post(
      Uri.parse(_huggingFaceUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List && data.isNotEmpty) {
        return data[0]['generated_text'].toString().trim();
      }
      return "I'm learning how to help better. Could you try rephrasing your question?";
    } else {
      throw Exception('Failed to get response from Hugging Face');
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nutrition Assistant"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton<int>(
            icon: Icon(Icons.settings),
            onSelected: (value) {
              setState(() {
                _botType = value;
              });
              String botName = value == 1 ? "Simple Bot" : value == 2 ? "Cohere API" : "Hugging Face";
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Switched to $botName")),
              );
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 1, child: Text("Simple Bot (Offline)")),
              PopupMenuItem(value: 2, child: Text("Cohere API")),
              PopupMenuItem(value: 3, child: Text("Hugging Face API")),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Bot type indicator
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.green.withOpacity(0.1),
            child: Text(
              "Current: ${_botType == 1 ? 'Simple Bot (Offline)' : _botType == 2 ? 'Cohere API' : 'Hugging Face API'}",
              style: TextStyle(fontSize: 12, color: Colors.green[700]),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isLoading) {
                  return _buildLoadingMessage();
                }
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.smart_toy, color: Colors.white, size: 20),
              radius: 16,
            ),
            SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser ? Colors.green : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, color: Colors.grey[600], size: 20),
              radius: 16,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLoadingMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.smart_toy, color: Colors.white, size: 20),
            radius: 16,
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
                SizedBox(width: 12),
                Text("Thinking..."),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Ask about nutrition, ingredients...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onSubmitted: _sendMessage,
              enabled: !_isLoading,
            ),
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            onPressed: _isLoading ? null : () => _sendMessage(_messageController.text),
            backgroundColor: Colors.green,
            mini: true,
            child: Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}