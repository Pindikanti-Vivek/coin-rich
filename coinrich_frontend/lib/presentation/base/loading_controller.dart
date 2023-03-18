import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LoadingController extends GetxController {
  static LoadingController get instance => Get.find<LoadingController>();

  final loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeHive();
  }

  Future<void> initializeHive() async {
    Hive.init((await getApplicationDocumentsDirectory()).path);
    await Hive.openBox("data");
  }
}