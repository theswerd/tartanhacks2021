import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  List<CameraDescription> cameras;
  CameraController cameraController;
  int cameraIndex;

  @override
  void initState() {
    super.initState();

    loadCameras();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: CupertinoActivityIndicator(),
          ),
          if (cameraController != null)
            CameraPreview(
              cameraController,
            ),
          if (cameras?.length ?? 0 > 1)
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.flip_camera_ios,
                ),
                onPressed: () {
                  setState(() {
                    cameraIndex = cameraIndex == 0 ? 1 : 0;
                    cameraController = CameraController(
                      cameras[cameraIndex],
                      ResolutionPreset.max,
                    );
                  });
                },
              ),
            )
        ],
      ),
    );
  }

  void loadCameras() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      cameraIndex = 0;
      cameraController = CameraController(
        cameras[cameraIndex],
        ResolutionPreset.max,
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (c) => CupertinoAlertDialog(
          title: Text('Unable to access your Camera'),
          content: Text(
              'Please check that you have given ICode access to your Camera'),
          actions: [
            CupertinoDialogAction(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(c);
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    }
  }
}
