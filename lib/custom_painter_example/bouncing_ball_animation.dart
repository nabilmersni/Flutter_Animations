import 'package:flutter/material.dart';

class BouncingBallAnimation extends StatefulWidget {
  const BouncingBallAnimation({super.key});

  @override
  State<BouncingBallAnimation> createState() => _BouncingBallAnimationState();
}

class _BouncingBallAnimationState extends State<BouncingBallAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = Tween<double>(begin: 0.1, end: 1).animate(controller);

    controller.forward();

    animation.addListener(
      () {
        if (animation.isCompleted) {
          controller.reverse();
        }

        if (!animation.isAnimating) {
          controller.forward();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return CustomPaint(
                    size: const Size(200, 200),
                    painter: BouncingBallPainter(animation: animation.value),
                  );
                })
          ],
        ),
      ),
    );
  }
}

class BouncingBallPainter extends CustomPainter {
  final double animation;

  BouncingBallPainter({super.repaint, required this.animation});
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(size.width / 2, size.height - (size.height * animation)),
      20,
      Paint()..color = Colors.blue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
