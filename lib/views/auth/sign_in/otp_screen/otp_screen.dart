import '/utils/responsive_layout.dart';

import '../../../../controller/auth/sign_in/otp_verification_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import 'otp_verification_mobile_screen_layout.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});
  final controller = Get.put(OtpVerificationController());
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileScaffold: OtpVerificationMobileScreenLayout(
      controller: controller,
    ));
  }
}
