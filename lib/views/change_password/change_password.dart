import '../../utils/basic_screen_imports.dart';
import '/utils/responsive_layout.dart';
import '/views/change_password/change_password_mobile.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: ChangePasswordMobile());
  }
}
