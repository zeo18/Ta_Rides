import 'package:flutter/material.dart';
import 'package:ta_rides/models/user_info.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({super.key, required this.user});

  final Users user;

  @override
  State<EventsTab> createState() {
    return _EventsTabState();
  }
}

class _EventsTabState extends State<EventsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: const Center(
        child: Text(
          'People',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
