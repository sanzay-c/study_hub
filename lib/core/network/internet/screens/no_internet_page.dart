import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({super.key});

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Center(
        child: SlideTransition(
          position: _slideAnimation,
          child: Container(
            width: 320.w,
            padding: EdgeInsets.all(32.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated Icon Circle
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6366F1).withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        )
                      ]
                    ),
                    child: Icon(
                      Icons.wifi_off_rounded,
                      color: Colors.white,
                      size: 50.w,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                
                // Title
                Text(
                  'No Internet\nConnection',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 16.h),
                
                // Subtitle
                Text(
                  'Whoops! Looks like you\'re offline. Check your connection and give it another shot!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF78829D),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 40.h),
                
                // Button
                PrimaryGradientButton(
                  text: 'Try Again',
                  icon: Icons.refresh_rounded,
                  onTap: () {
                    // Refresh effect
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryGradientButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onTap;

  const PrimaryGradientButton({super.key, required this.text, this.icon, required this.onTap});

  @override
  State<PrimaryGradientButton> createState() => _PrimaryGradientButtonState();
}

class _PrimaryGradientButtonState extends State<PrimaryGradientButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.92), // Press garda sano hune
      onTapUp: (_) => setState(() => _scale = 1.0),   // Chodda normal hune
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1).withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: Colors.white, size: 20.w),
                SizedBox(width: 8.w),
              ],
              Text(
                widget.text,
                style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}