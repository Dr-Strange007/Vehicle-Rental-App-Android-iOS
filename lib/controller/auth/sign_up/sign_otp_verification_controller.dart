import 'dart:async';

import 'package:pin_code_fields/pin_code_fields.dart';
import '/backend/model/common/common_success_model.dart';

import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/services/auth/auth_api_services.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../views/congratulation/congratulation_screen.dart';

class EmailVerificationController extends GetxController {
  final pinCodeController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  var currentText = ''.obs;
  var token = ''.obs;

  get onSubmit => emailOtpSubmitProcess();

  _onSubmitEmailCode() {
    Get.to(
      () => CongratulationScreen(
        route: Routes.bottomNavBar,
        subTitle: Strings.yourAccountHas,
        title: Strings.congratulations,
      ),
    );
  }

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

    resendOtpProcess();
  }

  /// >> set loading process & Otp Verification Model
  final _isLoading = false.obs;
  late CommonSuccessModel _otpVerificationModel;

  /// >> get loading process & Otp Verification Model
  bool get isLoading => _isLoading.value;
  CommonSuccessModel get otpVerificationModel => _otpVerificationModel;

  Future<CommonSuccessModel> emailOtpSubmitProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'code': currentText.value,
      'token': LocalStorage.getSignUpToken().toString(),
    };
    await AuthApiServices.emailOtpVerifyApi(body: inputBody).then((value) {
      _otpVerificationModel = value!;

      if (LocalStorage.getTwoFaID()) {
        //  Get.toNamed(Routes.twoFactorVerificationScreen);
      } else {
        _onSubmitEmailCode();
      }
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _otpVerificationModel;
  }

  final _resendLoading = false.obs;
  bool get resendLoading => _resendLoading.value;

  Future<CommonSuccessModel> resendOtpProcess() async {
    _resendLoading.value = true;
    pinCodeController.clear();
    update();

    await AuthApiServices.emailResendProcessApi(
            token: LocalStorage.getSignUpToken().toString())
        .then((value) {
      _otpVerificationModel = value!;
      _resendLoading.value = false;

      secondsRemaining.value = 59;
      enableResend.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _resendLoading.value = false;
    update();
    return _otpVerificationModel;
  }
}
