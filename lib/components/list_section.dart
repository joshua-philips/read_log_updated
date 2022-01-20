import 'package:flutter/material.dart';

/// Displays List<Widget> in horizontal ListView
class ListSection extends StatelessWidget {
  final String sectionTitle;
  final List<Widget> children;

  const ListSection(
      {Key? key, required this.sectionTitle, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle,
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
