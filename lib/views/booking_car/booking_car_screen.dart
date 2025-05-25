import '../../utils/basic_screen_imports.dart';
import '/utils/responsive_layout.dart';
import 'booking_car_screen_mobile.dart';

class BookingCarScreen extends StatelessWidget {
  const BookingCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: BookingCarScreenMobile());
  }
}
