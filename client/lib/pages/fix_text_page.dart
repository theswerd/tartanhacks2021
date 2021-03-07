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

class Output {
  String message;
  bool error;
  Output({
    @required this.message,
    this.error = false,
  });
}

class _FixTextPageState extends State<FixTextPage> {
  String text;
  TextEditingController textEditingController;
  PageController pageController;

  Output output;

  @override
  void initState() {
    super.initState();

    output = Output(message: '');

    pageController = PageController();

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
    return PageView(
      scrollDirection: Axis.vertical,
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              post(
                'https://us-west2-icode-131b9.cloudfunctions.net/javascript',
                //headers: {"Content-Type": "application/json"},
                body: {
                  "code": textEditingController.text,
                },
              ).then((value) {
                print(value.body);
                print(value.statusCode);
                if (value.statusCode == 500) {
                  setState(() {
                    output.error = true;
                    output.message = "There was an error running your code";
                  });
                } else {
                  setState(() {
                    output.error = false;
                    output.message = value.body;
                  });
                }
                pageController.nextPage(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.linear,
                );
              });
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
                keyboardType: TextInputType.text,
                decoration: InputDecoration(border: InputBorder.none),
                maxLines: null,
                style: TextStyle(height: 1.5),
              ),
            ),
          ),
        ),
        Scaffold(
          body: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(Icons.arrow_upward),
                onPressed: () {
                  pageController.previousPage(
                    duration: Duration(
                      milliseconds: 500,
                    ),
                    curve: Curves.linear,
                  );
                },
              ),
              middle: Text(
                'Output',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: CupertinoColors.black.withOpacity(0.3),
            ),
            child: Center(
              child: Text(
                output.message,
                style: TextStyle(
                  color: output.error ? Colors.red : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
