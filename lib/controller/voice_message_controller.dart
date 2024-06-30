import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';

class VoiceMessageController extends GetxController {
  final Record _audioRecorder = Record();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  RxBool isRecording = false.obs;

  Future<void> startRecording() async {
    if (await _audioRecorder.hasPermission()) {
      Directory tempDir = await getTemporaryDirectory();
      String path = '${tempDir.path}/${Uuid().v4()}.m4a';
      await _audioRecorder.start(path: path);
      isRecording.value = true;
    }
  }

  Future<String?> stopRecordingAndUpload(String receiverId) async {
    final path = await _audioRecorder.stop();
    isRecording.value = false;
    if (path != null) {
      File audioFile = File(path);
      try {
        String fileName = '${Uuid().v4()}.m4a';
        TaskSnapshot snapshot = await _storage
            .ref()
            .child('audioMessages/$receiverId/$fileName')
            .putFile(audioFile);
        return await snapshot.ref.getDownloadURL();
      } catch (ex) {
        print(ex);
        return null;
      }
    }
    return null;
  }
}
