import 'dart:async';

import 'package:pin_code_fields/pin_code_fields.dart';
import '/backend/model/dashboard/booking_mail_otp_resend_model.dart';
import '/backend/services/dashboard/dashbord_api_services.dart';
import '/controller/booking_car/booking_car_controller.dart';

import '../../../utils/basic_screen_imports.dart';
import '../../backend/model/car_booking/booking_verify_model.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';
import '../../views/congratulation/congratulation_screen.dart';

class BookingVerificationController extends GetxController {
  final pinCodeController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  // RxString userToken = ''.obs;
  final bookingController = Get.put(BookingCarController());
  var currentText = ''.obs;

  changeCurrentText(value) {
    currentText.value = value;
  }

  @override
  void dispose() {
    pinCodeController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    errorController = StreamController<ErrorAnimationType>();
    timerInit();
    super.onInit();
  }

  timerInit() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining.value != 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
      }
    });
  }

  RxInt secondsRemaining = 59.obs;
  RxBool enableResend = false.obs;
  Timer? timer;

  resendCode() {
    secondsRemaining.value = 59;
    enableResend.value = false;
    resendOtpProcess();
  }

  void goToResetPasswordScreen() {
    Get.to(
      () => CongratulationScreen(
        route: Routes.bottomNavBar,
        subTitle: Strings.yourBookingHas,
        title: Strings.congratulations,
      ),
    );
  }

  /// >> set loading process & Otp Verification Model
  final _isLoading = false.obs;
  late BookingVerifyModel _otpVerificationModel;

  /// >> get loading process & Otp Verification Model
  bool get isLoading => _isLoading.value;
  BookingVerifyModel get otpVerificationModel => _otpVerificationModel;

  ///* Otp verify process
  Future<BookingVerifyModel> bookingVerifyProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'code': currentText.value,
      'token': bookingController.carToken.value
    };
    await DashboardApiServices.bookingVerificationProcessApi(body: inputBody)
        .then((value) {
      _otpVerificationModel = value!;

      goToResetPasswordScreen();

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _otpVerificationModel;
  }

  /// >> set loading process & Forgot Password Model
  final _isResendLoading = false.obs;
  late BookingMailOtpResendModel _bookingMailOtpResendModel;

  /// >> get loading process & Forgot Password Model
  bool get isForgotPasswordLoading => _isResendLoading.value;
  BookingMailOtpResendModel get bookingMailOtpResendModel =>
      _bookingMailOtpResendModel;

  ///* Resend otp process
  Future<BookingMailOtpResendModel> resendOtpProcess() async {
    _isResendLoading.value = true;
    update();

    await DashboardApiServices.resentOtpProcess(
            token: bookingController.carToken.value)
        .then((value) {
      _bookingMailOtpResendModel = value!;
      _isResendLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isResendLoading.value = false;
    update();
    return _bookingMailOtpResendModel;
  }
}
