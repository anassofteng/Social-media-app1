import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class MessageScreen extends StatefulWidget {
  final String image, name, email;
  const MessageScreen(
      {super.key,
      required this.email,
      required this.name,
      required this.image});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name.toString())),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Text(index.toString());
                  }),
            ),
            Row(
              children: [
                Expanded(child: TextFormField()),
                CircleAvatar(
                  backgroundColor: AppColors.primaryIconColor,
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
