import 'dart:math' as math show sin, pi;

import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

class DelayTween extends Tween<double> {
  DelayTween({double? begin, double? end, this.delay}) : super(begin: begin, end: end);

  final double? delay;

  @override
  double lerp(double t) => super.lerp((math.sin((t - delay!) * 2 * math.pi) + 1) / 2);

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}

class FadingCircleProgress extends StatefulWidget {
  const FadingCircleProgress({
    Key? key,
    this.color,
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  })  : assert(!(itemBuilder is IndexedWidgetBuilder && color is Color) && !(itemBuilder == null && color == null),
  'You should specify either a itemBuilder or a color'),
        assert(size != null),
        super(key: key);

  final Color? color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  FadingCircleProgressState createState() => FadingCircleProgressState();
}

class FadingCircleProgressState extends State<FadingCircleProgress> with SingleTickerProviderStateMixin {
  final List<double> delays = [.0, -1.1, -1.0, -0.9, -0.8, -0.7, -0.6, -0.5, -0.4, -0.3, -0.2, -0.1];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ?? AnimationController(vsync: this, duration: widget.duration))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size.square(widget.size),
        child: Stack(
          children: List.generate(12, (i) {
            final _position = widget.size * .5;
            return Positioned.fill(
              left: _position,
              top: _position,
              child: Transform(
                transform: Matrix4.rotationZ(30.0 * i * 0.0174533),
                child: Align(
                  alignment: Alignment.center,
                  child: FadeTransition(
                    opacity: DelayTween(begin: 0.0, end: 1.0, delay: delays[i]).animate(_controller),
                    child: SizedBox.fromSize(size: Size.square(widget.size * 0.15), child: _itemBuilder(i)),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle));
}