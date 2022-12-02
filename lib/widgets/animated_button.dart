import 'package:flutter/material.dart';
import 'dart:math' as math;

class RipplesAnimation extends StatefulWidget {
  final String text;
  final dynamic fun;
  const RipplesAnimation({Key? key, required this.fun, required this.text})
      : super(key: key);

  @override
  _RipplesAnimationState createState() => _RipplesAnimationState();
}

class _RipplesAnimationState extends State<RipplesAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final double size = 40.0;
  final Color color = Colors.white;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _button() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: DecoratedBox(
          decoration: const BoxDecoration(),
          child: ScaleTransition(
            scale: Tween(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: const PulsateCurve(),
              ),
            ),
            child: ElevatedButton(
              onPressed: widget.fun,
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xff4ABB47), Color(0xff97D136)]),
                    borderRadius: BorderRadius.circular(100)),
                child: Container(
                  width: 170,
                  height: 170,
                  alignment: Alignment.center,
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(
        _controller,
        color: color,
      ),
      child: SizedBox(
        width: size * 4.125,
        height: size * 4.125,
        child: _button(),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter(
    this._animation, {
    required this.color,
  }) : super(repaint: _animation);
  final Color color;
  final Animation<double> _animation;
  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color _color = color.withOpacity(opacity);
    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = math.sqrt(area * value / 4);
    final Paint paint = Paint()..color = _color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;
}

class PulsateCurve extends Curve {
  const PulsateCurve();

  @override
  double transform(double t) {
    if (t == 0 || t == 1) {
      return 0.01;
    }
    return math.sin(t * math.pi);
  }
}
