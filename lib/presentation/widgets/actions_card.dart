import 'package:flutter/material.dart';

class MainActionsCard extends Card {
  const MainActionsCard({required this.children, this.color, super.key});

  final List<Widget> children;
  @override
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: color ?? Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          children: [
            ...children,
          ],
        ),
      ),
    );
  }
}
