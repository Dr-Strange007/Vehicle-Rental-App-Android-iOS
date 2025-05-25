import '/backend/utils/custom_loading_api.dart';
import '/controller/basic_settings/basic_settings_controller.dart';

import '../../utils/basic_screen_imports.dart';

class SplashScreenMobile extends StatelessWidget {
  SplashScreenMobile({super.key});
  final controller = Get.put(BasicSettingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return Image.network(
      controller.splashImage.value,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
    );
  }
}
