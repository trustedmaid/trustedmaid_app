import 'package:flutter/material.dart';

/// A premium entrance transition widget that fades and slides up its child
/// only when it enters the scrollable viewport, with a built-in fail-safe timer.
class FadeInSlide extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double slideOffset;

  const FadeInSlide({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 400),
    this.slideOffset = 16.0,
  });

  @override
  State<FadeInSlide> createState() => _FadeInSlideState();
}

class _FadeInSlideState extends State<FadeInSlide> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _yOffset;
  bool _hasAnimated = false;
  ScrollableState? _scrollable;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _yOffset = Tween<double>(begin: widget.slideOffset, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    // Bulletproof Fail-Safe Fallback: Trigger animation automatically after delay + 350ms
    // to guarantee widgets always render even if scroll listeners fail or misbehave.
    Future.delayed(const Duration(milliseconds: 350) + widget.delay, () {
      if (mounted && !_hasAnimated) {
        _startAnimation();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Locate the enclosing Scrollable context
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable != _scrollable) {
      _cleanupScrollListener();
      _scrollable = scrollable;
      _setupScrollListener();
    }
  }

  void _setupScrollListener() {
    if (_scrollable != null) {
      _scrollable!.position.addListener(_checkVisibility);
      // Check visibility once after building to see if it is already visible
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkVisibility();
      });
    } else {
      // If not in a Scrollable context, animate immediately
      _startAnimation();
    }
  }

  void _cleanupScrollListener() {
    if (_scrollable != null) {
      try {
        _scrollable!.position.removeListener(_checkVisibility);
      } catch (_) {}
    }
  }

  void _checkVisibility() {
    if (!mounted || _hasAnimated) return;

    final renderObject = context.findRenderObject() as RenderBox?;
    if (renderObject == null || !renderObject.hasSize || !renderObject.attached) return;

    try {
      final double widgetTop = renderObject.localToGlobal(Offset.zero).dy;
      final double screenHeight = MediaQuery.of(context).size.height;

      // Trigger animation when the widget enters the screen (plus a 50px buffer)
      if (widgetTop < screenHeight + 50) {
        _startAnimation();
      }
    } catch (_) {
      // Fail-Safe: If position calculation throws/fails, trigger animation immediately
      _startAnimation();
    }
  }

  void _startAnimation() {
    if (_hasAnimated) return;
    _hasAnimated = true;
    _cleanupScrollListener();

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _cleanupScrollListener();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double currentOpacity = _hasAnimated ? _opacity.value : 0.0;
        final double currentYOffset = _hasAnimated ? _yOffset.value : widget.slideOffset;

        return Opacity(
          opacity: currentOpacity,
          child: Transform.translate(
            offset: Offset(0.0, currentYOffset),
            child: widget.child,
          ),
        );
      },
    );
  }
}
