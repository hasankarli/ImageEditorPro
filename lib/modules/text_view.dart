import 'package:flutter/material.dart';

class TextView extends StatefulWidget {
  final Function ontap;
  final Function(DragUpdateDetails) onpanupdate;
  final double fontsize;
  final String text;
  final Color textColor;
  final TextAlign align;
  const TextView(
      {Key key,
      this.ontap,
      this.onpanupdate,
      this.fontsize,
      this.text,
      this.align,
      this.textColor})
      : super(key: key);
  @override
  _TextViewState createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      onPanUpdate: widget.onpanupdate,
      child: Text(
        widget.text,
        style: TextStyle(
          color: widget.textColor,
          fontSize: widget.fontsize,
        ),
      ),
    );
  }
}
