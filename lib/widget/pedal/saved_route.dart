import 'package:flutter/material.dart';

class SavedRoute extends StatefulWidget {
  const SavedRoute({super.key});

  @override
  State<SavedRoute> createState() => _SavedRouteState();
}

class _SavedRouteState extends State<SavedRoute> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Saved Route',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: const Color(0x3ff454545),
                fontWeight: FontWeight.w900,
                fontSize: 10,
              ),
        ),
      ],
    );
    ;
  }
}
