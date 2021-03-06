import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mdi/mdi.dart';
import 'package:tartanhacks2021/pages/fix_text_page.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with TickerProviderStateMixin {
  List<CameraDescription> cameras;
  CameraController cameraController;
  int cameraIndex;
  bool hasTakenPhoto;
  AnimationController animationController;
  Image image;

  @override
  void initState() {
    super.initState();
    hasTakenPhoto = false;
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
      lowerBound: 1,
      value: 1,
      upperBound: 2,
    );
    loadCameras();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: CupertinoActivityIndicator(),
          ),
          if (cameraController != null &&
              (cameraController?.value?.isInitialized ?? false))
            CameraPreview(
              cameraController,
            ),
          if (image != null) image,
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
              child: AnimatedBuilder(
                animation: animationController,
                builder: (c, w) => Padding(
                  padding: EdgeInsets.only(
                    bottom: (animationController?.value ?? 0) * 16,
                  ),
                  child: Transform.scale(
                    scale: animationController?.value ?? 1,
                    child: w,
                  ),
                ),
                child: FloatingActionButton(
                  heroTag: 'camera',

                  onPressed: ((cameraController?.value?.isInitialized ??
                              false) &&
                          !hasTakenPhoto)
                      ? () {
                          cameraController.takePicture().then((value) async {
                            image = Image.file(
                              File(value.path),
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Analyzing your image'),
                              behavior: SnackBarBehavior.floating,
                            ));

                            setState(() {
                              hasTakenPhoto = true;
                              animationController.forward();
                            });
                            // final textRecognizer = FirebaseVision.instance
                            //     .cloudTextRecognizer(CloudTextRecognizerOptions(
                            //   hintedLanguages: ['en'],
                            //   textModelType: CloudTextModelType.dense,
                            // ));
                            final textRecognizer = FirebaseVision.instance
                                .cloudDocumentTextRecognizer(
                              CloudDocumentRecognizerOptions(
                                hintedLanguages: ['en'],
                              ),
                            );
                            var text = await textRecognizer.processImage(
                              FirebaseVisionImage.fromFile(
                                File(
                                  value.path,
                                ),
                              ),
                            );
                            print('OUTPUT');
                            text.blocks.forEach((element) {
                              print(element.text);
                            });
                            print(text.text);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (c) => FixTextPage(
                                  text.blocks,
                                ),
                              ),
                            );
                          });
                        }
                      : null,

                  mini: false,
                  backgroundColor: CupertinoColors.systemBlue,
                  foregroundColor: Colors.white,
                  child: hasTakenPhoto
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Icon(Mdi.cameraIris),
                  tooltip: 'Take a photo of your code',
                  // shape: DiamondBorder(),
                ),
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
