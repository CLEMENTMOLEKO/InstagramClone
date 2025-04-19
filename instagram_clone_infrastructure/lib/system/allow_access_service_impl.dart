import 'package:injectable/injectable.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:permission_handler/permission_handler.dart';

@LazySingleton(as: AllowAccessService)
final class AllowAccessServiceImpl extends AllowAccessService {
  @override
  Future<void> requestAccessToCameraAndMicInSettings() async {
    await openAppSettings();
  }

  @override
  Future<bool> isCameraAndMicrophoneAccessGranted() async {
    List<bool> permissions = await Future.wait([
      Permission.camera.isGranted,
      Permission.microphone.isGranted,
    ]);
    return permissions.every((permission) => permission);
  }

  @override
  Future<void> requestAccessToCameraAndMicrophone() async {
    await [
      Permission.camera,
      Permission.microphone,
    ].request();
  }
}
