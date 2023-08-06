import 'package:flutter/material.dart';

class ForYouTabs extends StatefulWidget {
  const ForYouTabs({super.key});

  @override
  State<ForYouTabs> createState() {
    return _ForYouTabsState();
  }
}

class _ForYouTabsState extends State<ForYouTabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: const Center(
        child: Text(
          'You',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
