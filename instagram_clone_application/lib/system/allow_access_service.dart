abstract class AllowAccessService {
  Future<void> requestAccessToCameraAndMicrophone();
  Future<void> requestAccessToCameraAndMicInSettings();
  Future<bool> isCameraAndMicrophoneAccessGranted();
}
