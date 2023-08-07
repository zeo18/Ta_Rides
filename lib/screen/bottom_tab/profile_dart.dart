import 'package:flutter/material.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/data/user_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user});
  final Users user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
        title: Text(
          'You',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: const Color(0x3ff0C0D11),
      ),
      body: Column(
        children: [
          Text(
            user.id,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            user.firstName,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
