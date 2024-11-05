import 'package:app_task_demo/routing/routes.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  Future<void>? _initializeControllerFuture;
  late List<CameraDescription> _availableCameras;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _getAvailableCameras();
  }

  // Get available cameras and initialize the first camera
  Future<void> _getAvailableCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    _availableCameras = await availableCameras();
    // Initialize the first camera
    await _initCamera(_availableCameras.first);
  }

  // Initialize camera
  Future<void> _initCamera(CameraDescription description) async {
    _cameraController = CameraController(
      description,
      ResolutionPreset.max,
      enableAudio: true,
    );

    try {
      await _cameraController.initialize();
      setState(() {});
    } catch (e) {}
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final scale = 1 /
              (_cameraController.value.aspectRatio *
                  MediaQuery.of(context).size.aspectRatio);
          return Stack(
            children: [
              Transform.scale(
                scale: scale,
                alignment: Alignment.topCenter,
                child: CameraPreview(_cameraController),
              ),
              Positioned(
                top: 60,
                right: 25,
                child: GestureDetector(
                  onTap: () async {
                    // get current lens direction of the cameraa (front / rear)
                    final lensDirection =
                        _cameraController.description.lensDirection;
                    CameraDescription newDescription;
                    if (lensDirection == CameraLensDirection.front) {
                      newDescription = _availableCameras.firstWhere(
                          (description) =>
                              description.lensDirection ==
                              CameraLensDirection.back);
                    } else {
                      newDescription = _availableCameras.firstWhere(
                          (description) =>
                              description.lensDirection ==
                              CameraLensDirection.front);
                    }

                    await _initCamera(newDescription);
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.8),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.swap_horiz_outlined,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        // Ensure the camera is initialized
                        await _initializeControllerFuture;

                        // Take a picture and get the file path
                        final image = await _cameraController.takePicture();

                        // Display the picture or save it to a file, etc.
                        if (context.mounted) {
                          context.push(Routes.imagePreviewScreen,
                              extra: {'imagePath': image.path});
                        }
                      } catch (e) {}
                    },
                    child: Container(
                      width: 74,
                      height: 74,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.circle,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error initializing camera"));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
