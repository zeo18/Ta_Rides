import 'package:flutter/material.dart';

class PedalScreen extends StatelessWidget {
  const PedalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
        title: Text(
          'Pedal',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: const Color(0x3ff0C0D11),
      ),
    );
  }
}
