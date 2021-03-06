import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:tartanhacks2021/pages/camera_page.dart';
import 'package:tartanhacks2021/pages/home_page.dart';

class RouterPage extends StatefulWidget {
  @override
  _RouterPageState createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage> {
  final CupertinoTabController controller = CupertinoTabController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.scale(
        scale: 1.3,
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (c) => CameraPage(),
              fullscreenDialog: true,
            ),
          ),
          mini: false,
          backgroundColor: CupertinoColors.systemBlue,
          foregroundColor: Colors.white,
          child: Icon(Mdi.cameraIris),
          tooltip: 'Take a photo of your code',
          // shape: DiamondBorder(),
        ),
      ),
      body: CupertinoTabScaffold(
        controller: controller,
        tabBar: CupertinoTabBar(
          activeColor: CupertinoColors.systemBlue,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Mdi.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.error),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return HomePage();
            case 2:
              return Container();
            default:
              return Container();
          }
        },
      ),
    );
  }
}

class DiamondBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions {
    return const EdgeInsets.only();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..moveTo(rect.left + rect.width / 2.0, rect.top)
      ..lineTo(rect.right, rect.top + rect.height / 2.0)
      ..lineTo(rect.left + rect.width / 2.0, rect.bottom)
      ..lineTo(rect.left, rect.top + rect.height / 2.0)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  // This border doesn't support scaling.
  @override
  ShapeBorder scale(double t) {
    return null;
  }
}
