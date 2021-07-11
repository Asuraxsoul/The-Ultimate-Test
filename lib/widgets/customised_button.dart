import 'package:flutter/material.dart';

class CustomisedButton extends StatefulWidget {
  final Color colorA;
  final Color colorB;
  final String route;

  const CustomisedButton({
    Key? key,
    required this.colorA,
    required this.colorB,
    required this.route,
  }) : super(key: key);

  @override
  _CustomisedButtonState createState() => _CustomisedButtonState();
}

class _CustomisedButtonState extends State<CustomisedButton> {
  var isGlowing = false;
  var scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (val) {
        setState(() {
          isGlowing = false;
          scale = 1.0;
        });
      },
      onTapDown: (val) {
        setState(() {
          isGlowing = true;
          scale = 1.05;
        });
      },
      onTapCancel: () {
        setState(() {
          isGlowing = false;
          scale = 1.0;
        });
      },
      onTap: () {
        Navigator.of(context).pushNamed(widget.route);
      },
      child: AnimatedContainer(
        transform: Matrix4.identity()..scale(scale),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.white54,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          gradient: LinearGradient(
            colors: [
              widget.colorA,
              widget.colorB,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: widget.colorA.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 8,
            ),
            BoxShadow(
              color: widget.colorB.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 8,
            ),
            BoxShadow(
              color: widget.colorA.withOpacity(0.2),
              spreadRadius: 12,
              blurRadius: 16,
            ),
            BoxShadow(
              color: widget.colorB.withOpacity(0.2),
              spreadRadius: 12,
              blurRadius: 16,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Try it out!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isGlowing ? Colors.white : Colors.grey[100]!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
