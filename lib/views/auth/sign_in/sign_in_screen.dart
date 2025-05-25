import '../../../controller/auth/sign_in/sign_in_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '/utils/responsive_layout.dart';
import '/views/auth/sign_in/sign_in_mobile.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileScaffold: SignIndMobileScreenLayout(
      controller: controller,
    ));
  }
}
