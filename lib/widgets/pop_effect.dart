import 'dart:async';

import 'package:flutter/material.dart';

class PopChild extends StatefulWidget {
  Widget child;
VoidCallback? onTap;
  PopChild({required this.child,this.onTap});

  @override
  State<PopChild> createState() => _PopChildState();
}

class _PopChildState extends State<PopChild> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0,end: 0.9).animate(_controller);
  }

  void _onTap()  {
    _controller.forward();
Timer(Duration(milliseconds: 100),() => _controller.reverse(),);

    Timer(Duration(milliseconds: 250), () => widget.onTap!()) ;
  }
  void _onTapCancel(){
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedBuilder(
animation: _controller,
        child: widget.child,
        builder: (context,child) {
          return Transform.scale(
              scale: _scaleAnimation.value, child:child);
        }
      ),
    );
  }
}
