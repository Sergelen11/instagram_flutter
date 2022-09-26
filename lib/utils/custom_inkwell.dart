import 'package:flutter/material.dart';

class CustomInkWell extends StatefulWidget {
  final Widget? child;
  final Function()? onTap;

  const CustomInkWell({
    Key? key,
    this.onTap,
    this.child,
  }) : super(key: key);

  @override
  State<CustomInkWell> createState() => _CustomInkWellState();
}

class _CustomInkWellState extends State<CustomInkWell> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child ?? Container(),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
            ),
          ),
        ),
      ],
    );
  }
}
