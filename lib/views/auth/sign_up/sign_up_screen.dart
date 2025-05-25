import '../../../utils/basic_screen_imports.dart';
import '/controller/auth/sign_up/sign_up_controller.dart';
import '/utils/responsive_layout.dart';
import '/views/auth/sign_up/sign_up_screen_mobile.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: SignUpMobileScreenLayout(
        controller: controller,
      ),
    );
  }
}
