import 'package:flutter/cupertino.dart';

class FaderWidget extends StatefulWidget {
  final Widget child;
  final int milliseconds;
  final double begin;
  final double end;

  const FaderWidget(
      {Key key,
      this.child,
      this.milliseconds = 800,
      this.begin = 0,
      this.end = 1})
      : super(key: key);

  @override
  FaderWidgetState createState() {
    return FaderWidgetState();
  }
}

class FaderWidgetState extends State<FaderWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.milliseconds),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(widget.begin, widget.end, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: child,
        );
      },
    );
  }
}

class FaderAndTransformWidget extends StatefulWidget {
  final Widget child;
  final int milliseconds;
  final double begin;
  final double end;

  const FaderAndTransformWidget(
      {Key key,
      this.child,
      this.milliseconds = 800,
      this.begin = 0,
      this.end = 1})
      : super(key: key);

  @override
  FaderAndTransformWidgetState createState() {
    return FaderAndTransformWidgetState();
  }
}

class FaderAndTransformWidgetState extends State<FaderAndTransformWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.milliseconds),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(widget.begin, widget.end, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: child,
          ),
        );
      },
    );
  }
}
