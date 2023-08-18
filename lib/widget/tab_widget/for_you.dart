import 'package:flutter/material.dart';
import 'package:ta_rides/models/user_info.dart';

class ForYouTabs extends StatefulWidget {
  const ForYouTabs({
    super.key,
    required this.user,
  });

  final Users user;
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
