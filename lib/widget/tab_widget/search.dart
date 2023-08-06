import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() {
    return _SearchTabState();
  }
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: const Center(
        child: Text(
          'Fuck',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
