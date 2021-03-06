import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FixTextPage extends StatefulWidget {
  const FixTextPage(this.textblocks, {Key key}) : super(key: key);

  final List<DocumentTextBlock> textblocks;

  @override
  _FixTextPageState createState() => _FixTextPageState();
}

class Block {
  String value;
  bool selected;

  Block(this.value, this.selected);
}

class _FixTextPageState extends State<FixTextPage> {
  List<Block> blocks;

  @override
  void initState() {
    super.initState();

    blocks = widget.textblocks
        .map(
          (e) => Block(
            e.text,
            true,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Code Blocks'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          heroTag: 'camera',
          label: Text('Run Code'),
          backgroundColor: CupertinoColors.systemBlue,
          foregroundColor: Colors.white,
        ),
        body: ListView.separated(
          padding: EdgeInsets.all(18),
          itemCount: blocks.length,
          itemBuilder: (c, i) => OutlinedButton(
            style: OutlinedButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.padded,
                side: BorderSide(
                  color: blocks[i].selected
                      ? CupertinoColors.activeBlue
                      : CupertinoColors.systemGrey3,
                )),
            onPressed: () {
              print('PRESSED');
              setState(() {
                blocks[i].selected = !blocks[i].selected;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(border: InputBorder.none),
                controller: TextEditingController(
                  text: blocks[i].value,
                ),
              ),
            ),
          ),
          separatorBuilder: (c, i) => SizedBox(
            height: 30,
          ),
        ));
  }
}
