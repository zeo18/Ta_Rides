import 'package:flutter/material.dart';
import 'package:ta_rides/models/community_info.dart';

class JoinGroupScreen extends StatefulWidget {
  const JoinGroupScreen({
    super.key,
    required this.community,
  });

  final Community community;

  @override
  State<JoinGroupScreen> createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
        title: Text(
          widget.community.title,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: const Color(0x3ff0C0D11),
      ),
      body: Column(),
    );
  }
}
