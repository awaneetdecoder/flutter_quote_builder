import 'package:flutter/material.dart';

/// A simple responsive layout widget.
///
/// It displays the `mobileBody` if the screen width is below the
/// `breakpoint` (default 800), and the `desktopBody` if it's wider.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;
  final double breakpoint;

  const ResponsiveLayout({
    super.key,
    required this.mobileBody,
    required this.desktopBody,
    this.breakpoint = 800,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < breakpoint) {
          return mobileBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}