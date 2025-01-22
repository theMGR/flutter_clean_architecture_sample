import 'dart:async';

import 'package:flutter/material.dart';

class ZoomableWidget extends StatefulWidget {
  final Widget child;

  const ZoomableWidget({Key? key, required this.child}) : super(key: key);

  @override
  _ZoomableWidgetState createState() => _ZoomableWidgetState();
}

class _ZoomableWidgetState extends State<ZoomableWidget> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  late Timer _resetZoomTimer;

  @override
  void initState() {
    super.initState();
    _resetZoomTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      // Reset zoom after 5 seconds
      _resetZoom();
    });
  }

  @override
  void dispose() {
    _resetZoomTimer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (ScaleStartDetails details) {
        _previousScale = _scale;
        _resetZoomTimer.cancel(); // Cancel the reset timer when scaling starts
      },
      onScaleUpdate: (ScaleUpdateDetails details) {
        setState(() {
          _scale = _previousScale * details.scale;
        });
      },
      onScaleEnd: (ScaleEndDetails details) {
        // Restart the reset timer when scaling ends
        _resetZoomTimer.cancel();
        _resetZoomTimer = Timer.periodic(Duration(seconds: 5), (timer) {
          _resetZoom();
        });
      },
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }

  void _resetZoom() {
    setState(() {
      _scale = 1.0;
    });
  }
}