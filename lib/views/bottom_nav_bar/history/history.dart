import '/controller/bottom_nav_bar/bottom_nav_bar_controller.dart';
import '/utils/responsive_layout.dart';
import '../../../utils/basic_screen_imports.dart';
import 'history_screen_mobile.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, value) {
          navigationController.selectedIndex.value = 1;
        },
        child: HistoryScreenMobile(),
      ),
    );
  }
}
