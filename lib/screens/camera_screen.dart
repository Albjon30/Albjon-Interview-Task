import 'package:app_task_demo/routing/routes.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CameraScreen extends StatefulWidget {
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
    _initializeControllerFuture =
        _getAvailableCameras(); // Initialize Future here
  }

  // get available cameras and initialize the first camera
  Future<void> _getAvailableCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    _availableCameras = await availableCameras();
    await _initCamera(_availableCameras.first); // Initialize the first camera
  }

  // init camera
  Future<void> _initCamera(CameraDescription description) async {
    _cameraController =
        CameraController(description, ResolutionPreset.max, enableAudio: true);

    try {
      await _cameraController.initialize();
      // Notify the widgets that the camera has been initialized
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Display the camera preview when initialized
            final scale = 1 /
                (_cameraController.value.aspectRatio *
                    MediaQuery.of(context).size.aspectRatio);
            return Transform.scale(
              scale: scale,
              alignment: Alignment.topCenter,
              child: CameraPreview(_cameraController),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error initializing camera"));
          } else {
            // Otherwise, display a loading indicator
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              try {
                // Ensure the camera is initialized
                await _initializeControllerFuture;

                // Take a picture and get the file path
                final image = await _cameraController.takePicture();

                // Display the picture or save it to a file, etc.
                context.push(Routes.imagePreviewScreen,
                    extra: {'imagePath': image.path});
                print("Picture saved to: ${image.path}");
              } catch (e) {
                print(e);
              }
            },
            child: Icon(Icons.camera),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async {
              // get current lens direction (front / rear)
              final lensDirection = _cameraController.description.lensDirection;
              CameraDescription newDescription;
              if (lensDirection == CameraLensDirection.front) {
                newDescription = _availableCameras.firstWhere((description) =>
                    description.lensDirection == CameraLensDirection.back);
              } else {
                newDescription = _availableCameras.firstWhere((description) =>
                    description.lensDirection == CameraLensDirection.front);
              }

              if (newDescription != null) {
                // Switch to the new camera
                await _initCamera(newDescription);
              }
            },
            child: Icon(Icons.cameraswitch),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
