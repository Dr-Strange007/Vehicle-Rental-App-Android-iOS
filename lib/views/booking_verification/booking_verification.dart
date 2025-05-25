import '/controller/booking_verification/booking_verification_controller.dart';

import '../../utils/basic_screen_imports.dart';
import '../../utils/responsive_layout.dart';
import 'booking_verification_mobile.dart';

class BookingVerification extends StatelessWidget {
  BookingVerification({super.key});
  final controller = Get.put(BookingVerificationController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileScaffold: BookingVerificationMobile(
      controller: controller,
    ));
  }
}
