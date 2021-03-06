import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:tartanhacks2021/pages/camera_page.dart';
import 'package:tartanhacks2021/pages/home_page.dart';
import 'package:tartanhacks2021/pages/settings_page.dart';

class RouterPage extends StatefulWidget {
  @override
  _RouterPageState createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage> with TickerProviderStateMixin {
  final CupertinoTabController controller = CupertinoTabController();
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      lowerBound: 1.1,
      upperBound: 1.3,
      value: 1.0,
      duration: Duration(
        milliseconds: 200,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) =>
            Transform.scale(scale: animationController.value, child: child),
        child: GestureDetector(
          onTapUp: (_) {
            animationController.reverse();
          },
          onTapCancel: () {
            animationController.reverse();
          },
          onTapDown: (_) {
            animationController.forward();
          },
          child: FloatingActionButton(
            heroTag: 'camera',
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
            //shape: DiamondBorder(),
          ),
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
              return SettingsPage();
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
