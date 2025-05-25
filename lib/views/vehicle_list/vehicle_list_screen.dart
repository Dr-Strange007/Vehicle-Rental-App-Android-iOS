import '../../utils/basic_screen_imports.dart';
import '/utils/responsive_layout.dart';
import '/views/vehicle_list/vehicle_list_screen_mobile.dart';

class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: VehicleListScreenMobile());
  }
}
