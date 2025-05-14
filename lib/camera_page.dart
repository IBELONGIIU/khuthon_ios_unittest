import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _photoTaken = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere((c) => c.lensDirection == CameraLensDirection.back);

    _controller = CameraController(backCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controller!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePhoto() async {
    try {
      await (_initializeControllerFuture ?? Future.value());
      final image = await _controller!.takePicture();
      setState(() {
        _photoTaken = true;
      });
      // 여기서 image.path로 넘기거나 저장 가능
      print("사진 촬영됨: ${image.path}");
    } catch (e) {
      print("촬영 에러: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<void>(
  future: _initializeControllerFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done && _controller != null) {
      return CameraPreview(_controller!);
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  },
),
          if (_photoTaken)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: Icon(Icons.check_circle, color: Colors.green, size: 72),
              ),
            ),
          Positioned(
            bottom: 140,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _takePhoto,
                child: Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
                  ),
                  child: const Icon(LucideIcons.camera, size: 32, color: Color(0xFF357A38)),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('📌 촬영 팁',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('- 식물의 질병이 있는 부분을 향해 카메라를 조준하세요'),
                      Text('- 이미지가 선명하고 밝아야 해요'),
                      Text('- 카메라를 흔들지 않도록 주의하세요'),
                      Text('- 가까이서 촬영해 주세요'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}