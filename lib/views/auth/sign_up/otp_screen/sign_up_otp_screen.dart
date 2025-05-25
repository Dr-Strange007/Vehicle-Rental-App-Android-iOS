import '/utils/responsive_layout.dart';
import '/views/auth/sign_up/otp_screen/sign_up_otp_screen_mobile.dart';

import '../../../../controller/auth/sign_up/sign_otp_verification_controller.dart';
import '../../../../utils/basic_screen_imports.dart';

class SignUpOtpScreen extends StatelessWidget {
  SignUpOtpScreen({super.key});
  final controller = Get.put(EmailVerificationController());
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileScaffold: SignUpOtpScreenMobile(
      controller: controller,
    ));
  }
}
