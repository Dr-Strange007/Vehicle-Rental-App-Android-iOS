import '../../controller/bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '/utils/responsive_layout.dart';
import 'bottom_nav_bar_mobile.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});
  final controller = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileScaffold: NavigationMobileScreenLayout(
      navigationController: controller,
    ));
  }
}
