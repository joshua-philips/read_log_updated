import 'package:books_log_migration/configuration/constants.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH16,
          Text(
            sectionTitle,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
