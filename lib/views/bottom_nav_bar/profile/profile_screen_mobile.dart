import '/backend/utils/custom_loading_api.dart';

import '../../../controller/profile/update_profile_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/profile/update_profile_fields_widget.dart';
import '../../../widgets/profile/update_profile_info_widget.dart';

class UpdateProfileMobileScreenLayout extends StatelessWidget {
  final controller = Get.put(UpdateProfileController());

  UpdateProfileMobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        UpdateProfileInfoWidget(controller: controller),
        UpdateProfileFieldsWidget(controller: controller),
      ],
    );
  }
}
