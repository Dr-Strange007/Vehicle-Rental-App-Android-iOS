import 'package:get/get.dart';
import '/views/auth/sign_in/reset_password/reset_password_screen.dart';
import '/views/auth/sign_up/otp_screen/sign_up_otp_screen.dart';
import '/views/auth/sign_up/sign_up_screen.dart';
import '/views/booking_car/booking_car_screen.dart';
import '/views/booking_verification/booking_verification.dart';
import '/views/bottom_nav_bar/bottom_nav_bar.dart';
import '/views/change_password/change_password.dart';
import '/views/onboard/onboard_screen.dart';
import '/views/vehicle_list/vehicle_list_screen.dart';

import '../bindings/dashboard_screen_binding.dart';
import '../bindings/splash_screen_binding.dart';
import '../views/auth/sign_in/otp_screen/otp_screen.dart';
import '../views/auth/sign_in/sign_in_screen.dart';
import '../views/booking_preview/booking_preview.dart';
import '../views/notification/notification_screen.dart';
import '../views/splash_screen/splash_screen.dart';
import '/routes/routes.dart';

class RoutePageList {
  static var list = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.onboardScreen,
      page: () => const OnboardScreen(),
    ),
    GetPage(
      name: Routes.signInScreen,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: Routes.otpScreen,
      page: () => OtpScreen(),
    ),
    GetPage(
      name: Routes.resetPassword,
      page: () => ResetPasswordScreen(),
    ),
    GetPage(
      name: Routes.signUpScreen,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: Routes.signUpOtpScreen,
      page: () => SignUpOtpScreen(),
    ),
    GetPage(
      name: Routes.bottomNavBar,
      page: () => BottomNavBar(),
      binding: DashboardScreenBinding()
    ),
    GetPage(
      name: Routes.bookingCarScreen,
      page: () => const BookingCarScreen(),
    ),
    GetPage(
      name: Routes.bookingPreviewScreen,
      page: () => const BookingPreview(),
    ),
    GetPage(
      name: Routes.bookingVerificationScreen,
      page: () => BookingVerification(),
    ),
    GetPage(
      name: Routes.changePasswordScreen,
      page: () => const ChangePassword(),
    ),
    GetPage(
      name: Routes.vehicleListScreen,
      page: () => const VehicleListScreen(),
    ),
    GetPage(
      name: Routes.notificationScreen,
      page: () => NotificationScreen(),
    ),
  ];
}
