import 'package:flutter/material.dart';
import 'package:forsan_eltafe/core/appcolors.dart';

class Animatedegyptflag2 extends StatefulWidget {
  final double size;
  const Animatedegyptflag2({super.key, this.size = 80});

  @override
  State<Animatedegyptflag2> createState() => _AnimatedEgyptFlag3DState();
}

class _AnimatedEgyptFlag3DState extends State<Animatedegyptflag2>
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
              border: Border.all(
                color: Appcolors.accentColor,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Appcolors.accentColor.withOpacity(0.5),
                  blurRadius: 25,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/image/logo egypt.webp',
                height: widget.size,
                width: widget.size,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}