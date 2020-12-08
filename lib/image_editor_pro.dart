import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:signature/signature.dart';

import 'data/photo_filters.dart';
import 'models/emoji_model.dart';
import 'models/image_model.dart';
import 'models/text_model.dart';
import 'modules/emoji_editor.dart';
import 'modules/emoji_view.dart';
import 'modules/filter_editor.dart';
import 'modules/image_view.dart';
import 'modules/text_editor.dart';
import 'modules/text_view.dart';

TextEditingController heightcontroler = TextEditingController();
TextEditingController widthcontroler = TextEditingController();

final picker = ImagePicker();

List<double> imageWidth = [];
List<double> imageHeight = [];
var howmuchwidgetis = 0;

List widgets = [];
var opicity = 0.0;
SignatureController _controller =
    SignatureController(penStrokeWidth: 5, penColor: Colors.green);

class ImageEditorPro extends StatefulWidget {
  @override
  _ImageEditorProState createState() => _ImageEditorProState();
}

class _ImageEditorProState extends State<ImageEditorPro> {
  var width = double.infinity;
  var height = 250.0;
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  int currentIndex = 0;
// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
    var points = _controller.points;
    _controller =
        SignatureController(penStrokeWidth: 5, penColor: color, points: points);
  }

  Offset offset1 = Offset.zero;
  Offset offset2 = Offset.zero;

  var openbottomsheet = false;
  List<Offset> _points = <Offset>[];
  List aligment = [];

  final GlobalKey container = GlobalKey();
  final GlobalKey globalKey = new GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  File _image;
  ScreenshotController screenshotController = ScreenshotController();
  var filter = filters[0];
  bool editWidget = true;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    _controller.clear();
    widgets.clear();
    howmuchwidgetis = 0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 35,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        iconTheme: IconThemeData(color: Colors.grey[700], size: 50),
        backgroundColor: Colors.grey[200],
        actions: [
          IconButton(
            icon: Icon(
              Icons.done,
              size: 35,
            ),
            onPressed: () {
              setState(() {
                editWidget = false;
              });
              screenshotController
                  .capture(delay: Duration(milliseconds: 500), pixelRatio: 1.5)
                  .then((File image) async {
                final paths = await getTemporaryDirectory();
                image.copy(paths.path +
                    '/' +
                    DateTime.now().millisecondsSinceEpoch.toString() +
                    '.png');
                Navigator.pop(context, image);
              }).catchError((onError) {
                print(onError);
              });
            },
          )
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Screenshot(
                  controller: screenshotController,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    color: Colors.white,
                    width: width.toDouble(),
                    height: height.toDouble(),
                    child: RepaintBoundary(
                      key: globalKey,
                      child: Stack(
                        children: <Widget>[
                          _image != null
                              ? ColorFiltered(
                                  colorFilter: ColorFilter.matrix(filter),
                                  child: Image.file(
                                    _image,
                                    height: height.toDouble(),
                                    width: width.toDouble(),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(),
                          Container(
                            child: GestureDetector(
                                onPanUpdate: (DragUpdateDetails details) {
                                  setState(() {
                                    RenderBox object =
                                        context.findRenderObject();
                                    Offset _localPosition = object
                                        .globalToLocal(details.globalPosition);
                                    _points = new List.from(_points)
                                      ..add(_localPosition);
                                  });
                                },
                                onPanEnd: (DragEndDetails details) {
                                  _points.add(null);
                                },
                                child: Signat(
                                  height: height,
                                  width: width,
                                )),
                          ),
                          Stack(
                              children: widgets
                                  .asMap()
                                  .map((i, widget) {
                                    if (widget.runtimeType == EmojiModel) {
                                      EmojiModel emojiModel = widget;
                                      return MapEntry(
                                        i,
                                        Stack(
                                          children: [
                                            Positioned(
                                              left: emojiModel.offset.dx,
                                              top: emojiModel.offset.dy,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: editWidget
                                                          ? Colors.black
                                                          : Colors.transparent,
                                                      width: 0.3),
                                                ),
                                                child: EmojiView(
                                                  ontap: () {
                                                    showModalBottomSheet(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          25.0))),
                                                      context: context,
                                                      builder: (context) {
                                                        return StatefulBuilder(
                                                          builder: (context,
                                                              StateSetter
                                                                  setStater) {
                                                            return Container(
                                                              height: 120,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        20.0),
                                                                    child: new Text(
                                                                        "Slider Size"),
                                                                  ),
                                                                  Divider(
                                                                    height: 1,
                                                                  ),
                                                                  new Slider(
                                                                      value: emojiModel
                                                                          .fontSize,
                                                                      min: 0.0,
                                                                      max:
                                                                          200.0,
                                                                      onChangeEnd:
                                                                          (v) {
                                                                        setState(
                                                                            () {
                                                                          emojiModel.fontSize =
                                                                              v;
                                                                        });
                                                                      },
                                                                      onChanged:
                                                                          (v) {
                                                                        setStater(
                                                                            () {
                                                                          emojiModel.fontSize =
                                                                              v;
                                                                        });
                                                                        setState(
                                                                            () {
                                                                          emojiModel.fontSize =
                                                                              v;
                                                                        });
                                                                      }),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                  onpanupdate: (details) {
                                                    setState(() {
                                                      emojiModel.offset =
                                                          Offset(
                                                              emojiModel.offset
                                                                      .dx +
                                                                  details
                                                                      .delta.dx,
                                                              emojiModel.offset
                                                                      .dy +
                                                                  details.delta
                                                                      .dy);
                                                    });
                                                  },
                                                  value: emojiModel.emoji,
                                                  fontsize: emojiModel.fontSize,
                                                  align: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: emojiModel.offset.dx - 8,
                                              top: emojiModel.offset.dy - 8,
                                              child: GestureDetector(
                                                onTap: () {
                                                  print(i);
                                                  setState(() {
                                                    widgets.removeWhere(
                                                        (widget) =>
                                                            widget ==
                                                            widgets[i]);
                                                  });
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: editWidget
                                                            ? Colors.black
                                                            : Colors
                                                                .transparent,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            width: 1,
                                                            color: editWidget
                                                                ? Colors.black
                                                                : Colors
                                                                    .transparent)),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: editWidget
                                                          ? Colors.white
                                                          : Colors.transparent,
                                                      size: 14,
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    } else if (widget.runtimeType ==
                                        TextModel) {
                                      TextModel textModel = widget;
                                      return MapEntry(
                                        i,
                                        Stack(
                                          children: [
                                            Positioned(
                                              left: textModel.offset.dx,
                                              top: textModel.offset.dy,
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: editWidget
                                                          ? Colors.black
                                                          : Colors.transparent,
                                                      width: 0.3),
                                                ),
                                                child: TextView(
                                                  ontap: () {
                                                    showModalBottomSheet(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          25.0))),
                                                      context: context,
                                                      builder: (context) {
                                                        return Container(
                                                          height: 120,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        20.0),
                                                                child: new Text(
                                                                    "Slider Size"),
                                                              ),
                                                              Divider(
                                                                height: 1,
                                                              ),
                                                              StatefulBuilder(
                                                                builder: (context,
                                                                    StateSetter
                                                                        setStater) {
                                                                  return Slider(
                                                                      value: textModel
                                                                          .fontSize,
                                                                      min: 0.0,
                                                                      max:
                                                                          200.0,
                                                                      onChangeEnd:
                                                                          (v) {
                                                                        setState(
                                                                            () {
                                                                          textModel.fontSize =
                                                                              v;
                                                                        });
                                                                      },
                                                                      onChanged:
                                                                          (v) {
                                                                        setStater(
                                                                            () {
                                                                          textModel.fontSize =
                                                                              v;
                                                                        });
                                                                        setState(
                                                                            () {
                                                                          textModel.fontSize =
                                                                              v;
                                                                        });
                                                                      });
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  onpanupdate: (details) {
                                                    setState(() {
                                                      textModel.offset = Offset(
                                                          textModel.offset.dx +
                                                              details.delta.dx,
                                                          textModel.offset.dy +
                                                              details.delta.dy);
                                                    });
                                                  },
                                                  text: textModel.text,
                                                  textColor:
                                                      textModel.textColor,
                                                  fontsize: textModel.fontSize,
                                                  align: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: textModel.offset.dx - 8,
                                              top: textModel.offset.dy - 8,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    widgets.removeWhere(
                                                        (widget) =>
                                                            widget ==
                                                            widgets[i]);
                                                  });
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: editWidget
                                                            ? Colors.black
                                                            : Colors
                                                                .transparent,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            width: 1,
                                                            color: editWidget
                                                                ? Colors.black
                                                                : Colors
                                                                    .transparent)),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: editWidget
                                                          ? Colors.white
                                                          : Colors.transparent,
                                                      size: 14,
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                      ImageModel imageModel = widget;
                                      TextEditingController
                                          imageWidthController =
                                          TextEditingController(
                                              text:
                                                  imageModel.width.toString());
                                      TextEditingController
                                          imageHeightController =
                                          TextEditingController(
                                              text:
                                                  imageModel.height.toString());
                                      return MapEntry(
                                        i,
                                        Stack(
                                          children: [
                                            Positioned(
                                              left: imageModel.offset.dx,
                                              top: imageModel.offset.dy,
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: editWidget
                                                          ? Colors.black
                                                          : Colors.transparent,
                                                      width: 0.3),
                                                ),
                                                child: ImageView(
                                                  ontap: () {
                                                    showModalBottomSheet(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          25.0))),
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (context) {
                                                        return Padding(
                                                          padding:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .viewInsets,
                                                          child:
                                                              StatefulBuilder(
                                                            builder: (context,
                                                                StateSetter
                                                                    setStater) {
                                                              return Container(
                                                                height: 120,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              10.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                              flex: 8,
                                                                              child: Align(alignment: Alignment.center, child: new Text("Image Size"))),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                                                                                  alignment: Alignment.center,
                                                                                  child: Icon(
                                                                                    Icons.done,
                                                                                    color: Colors.white,
                                                                                  )),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Divider(
                                                                      height: 1,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                3,
                                                                            child: TextField(
                                                                                controller: imageHeightController,
                                                                                keyboardType: TextInputType.numberWithOptions(),
                                                                                decoration: InputDecoration(labelText: 'Height', hintText: 'Height', contentPadding: EdgeInsets.only(left: 10), border: OutlineInputBorder())),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                3,
                                                                            child: TextField(
                                                                                controller: imageWidthController,
                                                                                keyboardType: TextInputType.numberWithOptions(),
                                                                                decoration: InputDecoration(labelText: 'Width', hintText: 'Width', contentPadding: EdgeInsets.only(left: 10), border: OutlineInputBorder())),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                RaisedButton(
                                                                              color: Colors.green,
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  imageModel.height = double.tryParse(imageHeightController.text);
                                                                                  imageModel.width = double.tryParse(imageWidthController.text);
                                                                                });
                                                                              },
                                                                              child: Text(
                                                                                "Change",
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  onpanupdate: (details) {
                                                    setState(() {
                                                      imageModel.offset =
                                                          Offset(
                                                              imageModel.offset
                                                                      .dx +
                                                                  details
                                                                      .delta.dx,
                                                              imageModel.offset
                                                                      .dy +
                                                                  details.delta
                                                                      .dy);
                                                    });
                                                  },
                                                  file: imageModel.imageFile,
                                                  width: imageModel.width
                                                      .toDouble(),
                                                  height: imageModel.height
                                                      .toDouble(),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: imageModel.offset.dx - 8,
                                              top: imageModel.offset.dy - 8,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    widgets.removeWhere(
                                                        (widget) =>
                                                            widget ==
                                                            widgets[i]);
                                                  });
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: editWidget
                                                            ? Colors.black
                                                            : Colors
                                                                .transparent,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            width: 1,
                                                            color: editWidget
                                                                ? Colors.black
                                                                : Colors
                                                                    .transparent)),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: editWidget
                                                          ? Colors.white
                                                          : Colors.transparent,
                                                      size: 14,
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  })
                                  .values
                                  .toList()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (_controller.isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Screen cleaned'),
                          duration: Duration(milliseconds: 300),
                        ));
                      } else {
                        _controller.points.clear();
                        setState(() {});
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 3),
                      child: Column(
                        children: [
                          Icon(
                            FontAwesomeIcons.undo,
                            color: Colors.grey[700],
                            size: 30,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Undo',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      bottomsheets();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 26, vertical: 3),
                      child: Column(
                        children: [
                          Icon(
                            Icons.tune_outlined,
                            color: Colors.grey[700],
                            size: 30,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Choose background',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 3),
                      child: Column(
                        children: [
                          Icon(
                            FontAwesomeIcons.redo,
                            color: Colors.grey[700],
                            size: 30,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Redo',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: openbottomsheet
          ? new Container()
          : BottomNavigationBar(
              showUnselectedLabels: true,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.green[800],
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: (index) async {
                switch (index) {
                  case 0:
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: const Text('Pick a color!'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: pickerColor,
                            onColorChanged: changeColor,
                            showLabel: true,
                            pickerAreaHeightPercent: 0.8,
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: const Text('Got it'),
                            onPressed: () {
                              setState(() => currentColor = pickerColor);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                    break;
                  case 1:
                    TextModel textModel =
                        await showDialog(context: context, child: TextEditor());
                    if (textModel == null) {
                      print("true");
                    } else {
                      setState(() {
                        widgets.add(textModel);
                        howmuchwidgetis++;
                      });
                    }
                    break;
                  case 2:
                    EmojiModel emojiModel = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EmojieEditor();
                        });
                    if (emojiModel != null) {
                      setState(() {
                        widgets.add(emojiModel);
                        howmuchwidgetis++;
                      });
                    }
                    break;
                  case 3:
                    bottomsheets(forImageModel: true);
                    break;
                  case 4:
                    _controller.clear();
                    widgets.clear();
                    howmuchwidgetis = 0;
                    if (_image != null) {
                      var newFilter = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return FilterEditor(
                              imageFile: _image,
                            );
                          });
                      setState(() {
                        filter = newFilter;
                      });
                    }
                    break;
                  default:
                }
                setState(() {
                  currentIndex = index;
                });
              },
              items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.brush_outlined),
                    label: "Brush",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.text_fields),
                    label: "Text",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.smile),
                    label: "Emoji",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.photo_outlined),
                    label: "Logo",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.photo_filter_outlined),
                    label: "Filter",
                  )
                ]),
    );
  }

  void bottomsheets({bool forImageModel = false}) {
    openbottomsheet = true;
    setState(() {});
    Future<void> future = showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return new Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 10.9, color: Colors.grey[400])
          ]),
          height: 170,
          child: new Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: new Text("Select Image Options"),
              ),
              Divider(
                height: 1,
              ),
              new Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.photo_library),
                                  onPressed: () async {
                                    var pickedFile = await picker.getImage(
                                        source: ImageSource.gallery);

                                    var decodedImage =
                                        await decodeImageFromList(
                                            File(pickedFile.path)
                                                .readAsBytesSync());
                                    if (forImageModel) {
                                      ImageModel imageModel = ImageModel(
                                        offset: Offset(10, 10),
                                        height: 100,
                                        width: 100,
                                        uniqueId: UniqueKey(),
                                        imageFile: File(pickedFile.path),
                                      );
                                      setState(() {
                                        widgets.add(imageModel);
                                        howmuchwidgetis++;
                                      });
                                    } else {
                                      setState(() {
                                        height = decodedImage.height.toDouble();
                                        width = decodedImage.width.toDouble();
                                        _image = File(pickedFile.path);
                                      });
                                      setState(() => _controller.clear());
                                    }
                                    Navigator.pop(context);
                                  }),
                              SizedBox(width: 10),
                              Text("Open Gallery")
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 24),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.camera_alt),
                                onPressed: () async {
                                  var pickedFile = await picker.getImage(
                                      source: ImageSource.camera);

                                  var decodedImage = await decodeImageFromList(
                                      File(pickedFile.path).readAsBytesSync());

                                  if (forImageModel) {
                                    ImageModel imageModel = ImageModel(
                                      offset: Offset(10, 10),
                                      height: 100,
                                      width: 100,
                                      uniqueId: UniqueKey(),
                                      imageFile: File(pickedFile.path),
                                    );
                                    setState(() {
                                      widgets.add(imageModel);
                                      howmuchwidgetis++;
                                    });
                                  } else {
                                    setState(() {
                                      height = decodedImage.height.toDouble();
                                      width = decodedImage.width.toDouble();
                                      _image = File(pickedFile.path);
                                    });
                                    setState(() => _controller.clear());
                                  }
                                  Navigator.pop(context);
                                }),
                            SizedBox(width: 10),
                            Text("Open Camera")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {
    openbottomsheet = false;
    setState(() {});
  }
}

class Signat extends StatefulWidget {
  final double height;
  final double width;

  const Signat({Key key, this.height, this.width}) : super(key: key);
  @override
  _SignatState createState() => _SignatState();
}

class _SignatState extends State<Signat> {
  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print("Value changed"));
  }

  @override
  Widget build(BuildContext context) {
    return //SIGNATURE CANVAS
        //SIGNATURE CANVAS
        ListView(
      children: <Widget>[
        Signature(
            controller: _controller,
            height: widget.height,
            width: widget.width,
            backgroundColor: Colors.transparent),
      ],
    );
  }
}
