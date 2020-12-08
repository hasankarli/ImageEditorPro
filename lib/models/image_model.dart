import 'dart:io';

import 'package:flutter/material.dart';

class ImageModel {
  UniqueKey uniqueId;
  double height;
  double width;
  File imageFile;
  Offset offset;

  ImageModel(
      {this.offset, this.height, this.width, this.imageFile, this.uniqueId});
}
