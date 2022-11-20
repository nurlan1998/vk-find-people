import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageBackground extends StatelessWidget {
  final Widget? child;

  const PageBackground({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: child,
    );
  }
}