import 'package:flutter/material.dart';
import 'package:forsan_eltafe/core/appcolors.dart';

class Animatedegyptflagglass extends StatefulWidget {
  final double size;
  const Animatedegyptflagglass({super.key, this.size = 80});

  @override
  State<Animatedegyptflagglass> createState() => _AnimatedEgyptFlag3DState();
}

class _AnimatedEgyptFlag3DState extends State<Animatedegyptflagglass>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateY(_controller.value * 3.14159 * 2),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            
              boxShadow: [
                BoxShadow(
                  color: Appcolors.accentColor.withOpacity(0.3),
                  blurRadius: 25,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Image.asset(
              'assets/image/appIcon.png',
              height: widget.size,
              width: widget.size,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}