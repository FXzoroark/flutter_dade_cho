import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class ToastWrapper extends StatefulWidget {
  final String msg;
  final IconData? icon;
  final Color? color;

  const ToastWrapper({
    Key? key,
    required this.msg,
    this.icon,
    this.color,
  }) : super(key: key);

  @override
  State<ToastWrapper> createState() => _ToastWrapperState();
}

class _ToastWrapperState extends State<ToastWrapper>
    with TickerProviderStateMixin {
  late AnimationController controller;

  showIt() {
    controller.forward();
  }

  /// Start the hidding animations for the toast
  hideIt() {
    controller.reverse();
    _timer?.cancel();
  }

  /// Controller to start and hide the animation
  late Animation _fadeAnimation;

  Timer? _timer;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    _fadeAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeIn);
    super.initState();

    showIt();
    _timer = Timer(const Duration(milliseconds: 3000), () {
      hideIt();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var color = widget.color;
    return FadeTransition(
      opacity: _fadeAnimation as Animation<double>,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: (28),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.icon,
                      color: color,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(widget.msg, style: TextStyle(color: color)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}