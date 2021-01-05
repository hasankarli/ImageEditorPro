import 'package:flutter/material.dart';
import 'package:image_editor_pro/models/emoji_model.dart';

import '../data/emojis.dart';

class EmojieEditor extends StatefulWidget {
  @override
  _EmojieEditorState createState() => _EmojieEditorState();
}

class _EmojieEditorState extends State<EmojieEditor> {
  List<String> emojis = new List();
  @override
  void initState() {
    super.initState();
    emojis = getSmileys();
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
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisSpacing: 0.0, maxCrossAxisExtent: 60.0),
                children: emojis.map((String emoji) {
                  return GridTile(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.pop(
                          context,
                          EmojiModel(
                              emoji: emoji,
                              offset: Offset(10, 10),
                              fontSize: 20));
                    },
                    child: Container(
                      child: Text(
                        emoji,
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ));
                }).toList()),
          ),
        ],
      )),
    );
  }
}
