import '/extensions/custom_extensions.dart';

class ApiEndpoint {
 
  static const String mainDomain = "https://rentify.appdevs.net";

  static const String baseUrl = "$mainDomain/api/v1";

  //-> Login
  static String loginURL = '/login'.addBaseURl();
  static String forgotPasswordSendOtpURL = '/find/user'.addBaseURl();
  static String forgotPasswordReSendOtpURL =
      '/resend/code?token='.addBaseCustomURl();
  static String forgotOtpVerifyURL = '/verify/code'.addBaseURl();
  static String resetPasswordURL = '/reset'.addBaseURl();
  static String dashboardURL = '/dashboard'.addBaseURl();
  static String carListURL = '/cars'.addBaseURl();
  static String carTypeListURL = '/car/type'.addBaseURl();
  static String carAreaListURL = '/car/area'.addBaseURl();
  static String carAreaTypesURL = '/area/types'.addBaseURl();
  static String carSearchURL = '/search/car'.addBaseURl();
  static String carBookingURL = '/car/booking'.addBaseURl();
  static String carBookingConfirm = '/confirm?token='.addBaseCustomURl();
  static String carBookingVerificationURL = '/booking/verify'.addBaseURl();
  static String historyURL = '/history'.addBaseURl();
  static String bookingResendURL = '/mail/resend?token='.addBaseCustomURl();

  //-> Register
  static String registerURL = '/register'.addBaseURl();
  static String registerOtpVerifyURL = '/mail/verify/code'.addBaseURl();
  static String registerOtpResendURL =
      '/mail/resend/code?token='.addBaseCustomURl();
  static String logOutURL = '/logout'.addBaseURl();

  //-> Profile
  static String profileInfoGetURL = '/index'.addBaseURl();
  static String profileUpdateURL = '/update'.addBaseURl();
  static String profileDeleteURL = '/delete-account'.addBaseURl();
  static String changePasswordURL = '/password/update'.addBaseURl();
  static String basicSettingsURL = '/basic-settings'.addBaseURl();
  static String notificationURL = '/notification'.addBaseURl();

  static String languagesURL = '/languages'.addBaseURl();
}
