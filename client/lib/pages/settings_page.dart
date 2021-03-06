import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SupportedLanguages selectedLanguage;

  @override
  void initState() {
    super.initState();
    selectedLanguage = SupportedLanguages.JavaScript;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.only(top: 100),
        children: [
          CupertinoFormSection.insetGrouped(
            backgroundColor: Colors.transparent,
            header: Text('General Settings'),
            children: [
              CupertinoFormRow(
                prefix: Text(
                  'Analytics Enabled',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                helper: Text(
                  'Allow ICode to collect analytics for product improvements with Google Analytics',
                  style: TextStyle(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Switch.adaptive(
                  value: true,
                  onChanged: (v) {},
                ),
              ),
              CupertinoFormRow(
                prefix: Text(
                  'Save History',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                helper: Text(
                  'Save programming history locally. This will allow you to look back at past code you have written.',
                  style: TextStyle(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Switch.adaptive(
                  value: true,
                  onChanged: (v) {},
                ),
              ),
              CupertinoButton(
                alignment: Alignment.centerLeft,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Clear History',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
          CupertinoFormSection.insetGrouped(
            header: Text('Language'),
            children: [
              CupertinoButton(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'JavaScript',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    if (selectedLanguage == SupportedLanguages.JavaScript)
                      Icon(
                        Icons.check,
                        size: 20,
                      ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    selectedLanguage = SupportedLanguages.JavaScript;
                  });
                },
              ),
              CupertinoButton(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Python',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    if (selectedLanguage == SupportedLanguages.Python)
                      Icon(
                        Icons.check,
                        size: 20,
                      ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    selectedLanguage = SupportedLanguages.Python;
                  });
                },
              ),
              CupertinoButton(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ruby',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    if (selectedLanguage == SupportedLanguages.Ruby)
                      Icon(
                        Icons.check,
                        size: 20,
                      ),
                  ],
                ),
                onPressed: null,
                // onPressed: () {
                //   setState(() {
                //     selectedLanguage = SupportedLanguages.Ruby;
                //   });
                // },
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey.withOpacity(
          0.2,
        ),
      ),
    );
  }
}

enum SupportedLanguages {
  JavaScript,
  Python,
  Ruby,
}
