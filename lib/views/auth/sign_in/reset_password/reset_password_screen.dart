import '/views/auth/sign_in/reset_password/reset_password_mobile_layout.dart';

import '../../../../controller/auth/sign_in/reset_password_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final controller = Get.put(ResetPasswordController());
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: ResetPasswordMobileScreenLayout(
        controller: controller,
      ),
    );
  }
}
