import '../../utils/basic_screen_imports.dart';
import '/utils/responsive_layout.dart';
import '/views/booking_preview/booking_preview_screen_mobile.dart';

class BookingPreview extends StatelessWidget {
  const BookingPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: BookingPreviewMobile());
  }
}
