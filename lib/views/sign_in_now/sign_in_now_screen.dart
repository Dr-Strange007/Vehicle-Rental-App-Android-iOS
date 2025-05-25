import '../../utils/basic_screen_imports.dart';
import '/utils/responsive_layout.dart';
import '/views/sign_in_now/sign_in_now_screen_mobile.dart';

class SignInNowScreen extends StatelessWidget {
  const SignInNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(mobileScaffold: SignInNowScreenMobile());
  }
}
