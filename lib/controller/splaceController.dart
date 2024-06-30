import 'package:final_project/services/auth/auth_gate.dart';
import 'package:get/get.dart';

class SplaceController extends GetxController{

  void onInit() async {
    super.onInit();
    await splaceHandler();
  }

  Future<void> splaceHandler() async {
    Future.delayed(const Duration(seconds: 3), (){
      Get.offAllNamed("/AuthGate");
    });

  }
}