import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiKey = 'YOUR_GEMINI_API_KEY_HERE'; // 🔁 Replace this with actual key

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';

  Future<void> getGeminiResponse(String prompt) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$apiKey',
    );

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "contents": [
        {
          "parts": [{"text": prompt}]
        }
      ]
    });

    final res = await http.post(url, headers: headers, body: body);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final text = data['candidates'][0]['content']['parts'][0]['text'];
      setState(() => _response = text);
    } else {
      setState(() => _response = "Error: ${res.statusCode}\n${res.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gemini Chatbot')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Ask something...'),
            ),
            ElevatedButton(
              onPressed: () => getGeminiResponse(_controller.text),
              child: Text('Send'),
            ),
            SizedBox(height: 20),
            Text(_response),
          ],
        ),
      ),
    );
  }
}
