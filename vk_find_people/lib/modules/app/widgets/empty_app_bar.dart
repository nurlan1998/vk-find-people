import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final SystemUiOverlayStyle? overlayStyle;

  const EmptyAppBar({
    Key? key,
    this.overlayStyle,
  }) : super(key: key);

  SystemUiOverlayStyle get defaultOverlayStyle => const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  );

  @override
  Widget build(BuildContext context) {
    final _overlayStyle = overlayStyle ??
        Theme.of(context).appBarTheme.systemOverlayStyle ??
        defaultOverlayStyle;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Container(),
    );
  }

  @override
  Size get preferredSize => const Size(0.0, 0.0);
}