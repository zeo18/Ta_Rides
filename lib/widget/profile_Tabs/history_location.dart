import 'package:flutter/material.dart';
import 'package:ta_rides/models/pedal_info.dart';

class HistoryLocation extends StatelessWidget {
  const HistoryLocation({
    super.key,
    required this.pedal,
  });

  final Pedal pedal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
        backgroundColor: const Color(0x3ff0C0D11),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                image: NetworkImage(pedal.location),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
