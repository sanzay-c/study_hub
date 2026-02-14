import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashCircle extends StatefulWidget {
  final List<Color> color;
  final Widget? child;

  const SplashCircle({super.key, required this.color, required this.child});

  @override
  State<SplashCircle> createState() => _SplashCircleState();
}

class _SplashCircleState extends State<SplashCircle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // 1. Initialize the controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // This makes it pulse back and forth

    // 2. Define the scale range (e.g., from 95% size to 105%)
    _animation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Don't forget to kill the controller!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 3. Wrap your container in ScaleTransition
    return ScaleTransition(
      scale: _animation,
      child: Container(
        height: 129.h,
        width: 129.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: widget.color),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: widget.color.first.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}