import 'dart:io';

import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final Function ontap;
  final Function(DragUpdateDetails) onpanupdate;
  final File file;
  final double width;
  final double height;
  const ImageView({
    Key key,
    this.ontap,
    this.onpanupdate,
    this.file,
    this.width,
    this.height,
  }) : super(key: key);
  @override
  ImageViewState createState() => ImageViewState();
}

class ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      onPanUpdate: widget.onpanupdate,
      child: Image.file(
        widget.file,
        fit: BoxFit.cover,
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}
