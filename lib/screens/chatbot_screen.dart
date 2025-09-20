import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> messages = [];
  bool isTyping = false;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "sender": "You", 
        "text": text,
        "timestamp": DateTime.now(),
        "isAnimating": true
      });
      isTyping = true;
    });

    _scrollToBottom();

    final url = Uri.parse("https://mukul23.app.n8n.cloud/webhook/farmer-bot-webhook");
    
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"message": text}),
      );

      setState(() {
        isTyping = false;
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          messages.add({
            "sender": "Bot", 
            "text": data["reply"] ?? "No response",
            "timestamp": DateTime.now(),
            "isAnimating": true
          });
        });
      } else {
        setState(() {
          messages.add({
            "sender": "Bot", 
            "text": "Sorry, I'm having trouble connecting right now. Please try again.",
            "timestamp": DateTime.now(),
            "isAnimating": true
          });
        });
      }
    } catch (e) {
      setState(() {
        isTyping = false;
        messages.add({
          "sender": "Bot", 
          "text": "Network error. Please check your connection and try again.",
          "timestamp": DateTime.now(),
          "isAnimating": true
        });
      });
    }

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  Widget _buildTypingIndicator() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(width: 8),
            Text(
              "HydroBot is typing...",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.smart_toy,
                color: Colors.teal,
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "HydroTrack Chatbot",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "AI Assistant for Farmers",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Icon(
                            Icons.chat_bubble_outline,
                            size: 40,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Start a conversation!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Ask me anything about hydroponic farming",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    itemCount: messages.length + (isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (isTyping && index == messages.length) {
                        return _buildTypingIndicator();
                      }

                      final msg = messages[index];
                      final isUser = msg["sender"] == "You";
                      
                      return TweenAnimationBuilder(
                        duration: Duration(milliseconds: 300),
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        builder: (context, double value, child) {
                          return Transform.scale(
                            scale: value,
                            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                            child: Opacity(
                              opacity: value,
                              child: Container(
                                alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                child: Column(
                                  crossAxisAlignment: isUser 
                                      ? CrossAxisAlignment.end 
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                        gradient: isUser 
                                            ? LinearGradient(
                                                colors: [Colors.teal, Colors.teal.shade300],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              )
                                            : null,
                                        color: isUser ? null : Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(isUser ? 20 : 4),
                                          bottomRight: Radius.circular(isUser ? 4 : 20),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.08),
                                            blurRadius: 8,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        msg["text"],
                                        style: TextStyle(
                                          color: isUser ? Colors.white : Colors.grey[800],
                                          fontSize: 16,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      _formatTime(msg["timestamp"]),
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: TextField(
                        controller: _controller,
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: "Ask about hydroponic farming...",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                        onSubmitted: (text) {
                          if (text.isNotEmpty) {
                            sendMessage(text);
                            _controller.clear();
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal, Colors.teal.shade300],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.send_rounded, color: Colors.white),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          sendMessage(_controller.text);
                          _controller.clear();
                        }
                      },
                    ),
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