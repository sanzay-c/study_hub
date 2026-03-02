
import 'dart:math' as math;

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

class CustomDotsRefreshIndicator extends StatelessWidget {
  const CustomDotsRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
    this.dotColor,
    this.dotCount = 5,
  });

  final Future<void> Function() onRefresh;
  final Widget child;
  final Color? dotColor;
  final int dotCount;

  @override
  Widget build(BuildContext context) {
    final color = dotColor ?? Theme.of(context).colorScheme.primary;
    const double triggerDistance = 100.0;

    return CustomRefreshIndicator(
      onRefresh: onRefresh,
      trigger: IndicatorTrigger.leadingEdge,
      builder: (context, child, controller) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final double dy = controller.value * triggerDistance;
            
            final bool isCurrentlyRefreshing = controller.isLoading;

            return Stack(
              children: [
                if (!controller.isIdle)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: triggerDistance, 
                    child: Opacity(
                      opacity: controller.value.clamp(0.0, 1.0),
                      child: Center(
                        child: _WavyDotsRow(
                          progress: controller.value,
                          color: color,
                          dotCount: dotCount,
                          isRefreshing: isCurrentlyRefreshing,
                        ),
                      ),
                    ),
                  ),
                Transform.translate(
                  offset: Offset(0, dy),
                  child: child,
                ),
              ],
            );
          },
        );
      },
      child: child,
    );
  }
}


class _WavyDotsRow extends StatefulWidget {
  const _WavyDotsRow({
    required this.progress,
    required this.color,
    required this.dotCount,
    required this.isRefreshing,
  });

  final double progress;
  final Color color;
  final int dotCount;
  final bool isRefreshing;

  @override
  State<_WavyDotsRow> createState() => _WavyDotsRowState();
}

class _WavyDotsRowState extends State<_WavyDotsRow> with SingleTickerProviderStateMixin {
  late final AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    if (widget.isRefreshing) _waveController.repeat();
  }

  @override
  void didUpdateWidget(_WavyDotsRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRefreshing && !_waveController.isAnimating) {
      _waveController.repeat();
    } else if (!widget.isRefreshing && _waveController.isAnimating) {
      _waveController.stop();
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double dotSize = 10;
    const double dotSpacing = 14;
    const double waveAmplitude = 12;

    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.dotCount, (i) {
            final double phase = widget.isRefreshing ? _waveController.value : (widget.progress * 0.5);
            final double waveOffset = math.sin((phase * 2 * math.pi) - (i * math.pi * 0.4));
            
            final double dotScale = Curves.easeOutBack.transform(
              (widget.progress * 2 - (i * 0.15)).clamp(0.0, 1.0),
            );

            final double colorT = ((waveOffset + 1) / 2).clamp(0.0, 1.0);
            final Color dotColor = Color.lerp(
              widget.color.withValues(alpha: 0.3), 
              widget.color, 
              colorT
            )!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: dotSpacing / 2),
              child: Transform.translate(
                offset: Offset(0, waveOffset * waveAmplitude * (widget.isRefreshing ? 1 : widget.progress)),
                child: Transform.scale(
                  scale: dotScale,
                  child: _GlowDot(
                    size: dotSize,
                    color: dotColor,
                    glowColor: widget.color,
                    glowIntensity: colorT,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _GlowDot extends StatelessWidget {
  const _GlowDot({
    required this.size,
    required this.color,
    required this.glowColor,
    this.glowIntensity = 0.5,
  });

  final double size;
  final Color color;
  final Color glowColor;
  final double glowIntensity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: glowColor.withOpacity(0.4 * glowIntensity),
            blurRadius: 6 * glowIntensity,
            spreadRadius: 1 * glowIntensity,
          ),
        ],
      ),
    );
  }
}
