import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class FixTextPage extends StatefulWidget {
  const FixTextPage(this.textblocks, {Key key}) : super(key: key);

  final List<dynamic> textblocks;

  @override
  _FixTextPageState createState() => _FixTextPageState();
}

class Block {
  String value;

  Block(this.value);
}

class _FixTextPageState extends State<FixTextPage> {
  String text;
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();

    text = widget.textblocks
        .map(
          (e) => Block(
            e['text'],
          ),
        )
        .toList()
        .map((e) => e.value)
        .toList()
        .join('\n');
    textEditingController = TextEditingController(
      text: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Code Blocks'),
      // ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          post(
            'https://us-west2-icode-131b9.cloudfunctions.net/javascript',
            //headers: {"Content-Type": "application/json"},
            body: {
              "code": textEditingController.text,
            },
          ).then((value) => print(value.body));
        },
        heroTag: 'camera',
        label: Text('Run Code'),
        backgroundColor: CupertinoColors.systemBlue,
        foregroundColor: Colors.white,
      ),
      body: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            'Your Code',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: CupertinoColors.black.withOpacity(0.3),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 60,
            right: 16,
            left: 16,
          ),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(border: InputBorder.none),
            maxLines: null,
            style: TextStyle(height: 1.5),
          ),
        ),
      ),
    );
  }
}
