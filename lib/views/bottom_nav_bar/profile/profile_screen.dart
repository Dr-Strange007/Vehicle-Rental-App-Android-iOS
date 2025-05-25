import '/utils/responsive_layout.dart';
import '/views/bottom_nav_bar/profile/profile_screen_mobile.dart';
import '../../../controller/bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../../../utils/basic_screen_imports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, value) {
          navigationController.selectedIndex.value = 1;
        },
        child: UpdateProfileMobileScreenLayout(),
      ),
    );
  }
}
