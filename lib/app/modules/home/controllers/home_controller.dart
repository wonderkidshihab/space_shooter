import 'package:get/get.dart';
import 'package:space_shooter/app/routes/app_pages.dart';

class HomeController extends GetxController {
  play() {
    Get.toNamed(Routes.GAME);
  }
}
