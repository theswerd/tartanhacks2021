import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mdi/mdi.dart';

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
          if (cameraController != null && cameraController.value.isInitialized)
            CameraPreview(
              cameraController,
            ),
          if ((cameras?.length ?? 0) > 1)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Platform.isIOS
                        ? Icons.flip_camera_ios
                        : Icons.flip_camera_android,
                  ),
                  onPressed: () {
                    setState(() {
                      cameraIndex = cameraIndex == 0 ? 1 : 0;

                      cameraController = CameraController(
                        cameras[cameraIndex],
                        ResolutionPreset.max,
                        enableAudio: false,
                      );
                      cameraController.initialize().then((_) {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          cameraController = cameraController;
                        });
                      });
                    });
                  },
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                heroTag: 'camera',
                onPressed: (cameraController.value?.isInitialized ?? false)
                    ? () {
                        cameraController
                            .takePicture()
                            .then((value) => value.path);
                      }
                    : null,

                mini: false,
                backgroundColor: CupertinoColors.systemBlue,
                foregroundColor: Colors.white,
                child: Icon(Mdi.cameraIris),
                tooltip: 'Take a photo of your code',
                // shape: DiamondBorder(),
              ),
            ),
          )
        ],
      ),
    );
  }

  void loadCameras() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      setState(() {
        cameraIndex = 0;
        cameraController = CameraController(
          cameras[cameraIndex],
          ResolutionPreset.max,
          enableAudio: false,
        );
        cameraController.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      });
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
