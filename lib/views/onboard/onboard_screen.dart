import '../../utils/basic_screen_imports.dart';
import '/utils/responsive_layout.dart';
import 'onboard_screen_mobile.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: OnboardMobileScreenLayout());
  }
}
