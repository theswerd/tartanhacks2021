import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CodingProblem {
  final String name;
  final String problem;
  final answer;

  CodingProblem({
    @required this.name,
    @required this.problem,
    @required this.answer,
  });
}

List<CodingProblem> codingProblems = [
  CodingProblem(
    name: '5th Fibonocci Number',
    problem: 'Calculate the 5th Fibonocci Number',
    answer: 3,
  ),
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ListView.separated(
        padding: EdgeInsets.only(
          top: 100,
          left: 20,
          right: 20,
        ),
        itemCount: codingProblems.length,
        separatorBuilder: (c, i) => SizedBox(
          height: 40,
        ),
        itemBuilder: (c, i) => OutlinedButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  codingProblems[i].name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  codingProblems[i].problem,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'ICode',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black.withOpacity(
          0.3,
        ),
      ),
    );
  }
}
