import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../data/photo_filters.dart';

class FilterEditor extends StatefulWidget {
  final File imageFile;

  const FilterEditor({Key key, this.imageFile}) : super(key: key);
  @override
  _FilterEditorState createState() => _FilterEditorState();
}

class _FilterEditorState extends State<FilterEditor> {
  void convertWidgetToImage() async {
    // RenderRepaintBoundary repaintBoundary = _globalKey.currentContext.findRenderObject();
    // Image boxImage = (await repaintBoundary.toImage(pixelRatio: 1)) as Image;
    // ByteData byteData = await boxImage.toByteData(format: ui.ImageByteFormat.png);
    // Uint8List uint8list = byteData.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
          child: Column(
            children: <Widget>[
              Divider(
                height: 1,
              ),
              new SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 10.0,
                        maxCrossAxisExtent: 120.0),
                    children: filters
                        .asMap()
                        .map((i, filterName) {
                          return MapEntry(
                            i,
                            GridTile(
                              child: GestureDetector(
                                onTap: () async {
                                  Navigator.pop(context, filters[i]);
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    ColorFiltered(
                                      colorFilter:
                                          ColorFilter.matrix(filters[i]),
                                      child: Container(
                                        child: Image.file(
                                          widget.imageFile,
                                          fit: BoxFit.cover,
                                          height: 200,
                                          width: 200,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      width: double.infinity,
                                      color: Colors.black87.withOpacity(0.7),
                                      child: Text(
                                        FilterNames[i],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                        .values
                        .toList()),
              ),
            ],
          ),
        ));
  }
}
