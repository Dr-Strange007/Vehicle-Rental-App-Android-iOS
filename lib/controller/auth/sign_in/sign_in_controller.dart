import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/model/auth/forgot_password_model.dart';
import '../../../backend/model/auth/sign_in_model.dart';
import '../../../backend/services/auth/auth_api_services.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import 'otp_verification_controller.dart';

class SignInController extends GetxController {
  final emailAddressController = TextEditingController();
  final forgotPasswordEmailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isRemember = false.obs;

  get onSignIn => signInProcess();
  get onForgotPassword => forgotPasswordProcess();
  get onSignUp => Routes.signUpScreen;

  /// >> set loading process & Sign In Model
  final _isLoading = false.obs;
  late SignInModel _signInModel;

  /// >> get loading process & Sign In Model
  bool get isLoading => _isLoading.value;
  SignInModel get signInModel => _signInModel;

  ///* Sign in process
  Future<SignInModel> signInProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'credentials': emailAddressController.text,
      'password': passwordController.text,
    };

    await AuthApiServices.signInProcessApi(body: inputBody).then((value) {
      _signInModel = value!;
      _saveDataLocalStorage();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _signInModel;
  }

  _saveDataLocalStorage() {
    LocalStorage.saveToken(token: signInModel.data.token);
    LocalStorage.saveEmail(email: signInModel.data.userInfo.email);
    LocalStorage.saveId(id: signInModel.data.userInfo.id);
    if (_signInModel.data.userInfo.emailVerified == 1) {
      debugPrint("----------------VERIFIED");
      _goToSavedUser(signInModel);
    } else if (_signInModel.data.userInfo.emailVerified == 0) {
      debugPrint("----------------EMAIL NOT VERIFIED");
      Get.toNamed(Routes.signUpOtpScreen);
      LocalStorage.saveSignUpToken(token: signInModel.data.authorization.token);
      LocalStorage.saveToken(token: signInModel.data.token);
      LocalStorage.saveId(id: signInModel.data.userInfo.id);
      //todo
      // Get.toNamed(Routes.emailVerificationScreen);
    }
  }

  void _goToSavedUser(SignInModel signInModel) {
    LocalStorage.saveToken(token: signInModel.data.token);
    if (isRemember.value) {
      LocalStorage.isLoginSuccess(isLoggedIn: true);
    }
    LocalStorage.saveEmail(email: signInModel.data.userInfo.email);
    LocalStorage.saveId(id: signInModel.data.userInfo.id);
    //todo check the logic
    LocalStorage.isLoginSuccess(isLoggedIn: true);
    update();
    Get.offAllNamed(Routes.bottomNavBar);
  }

  /// >> set loading process & Forgot Password Model
  final _isForgotPasswordLoading = false.obs;
  late ForgotPasswordModel _forgotPasswordModel;

  /// >> get loading process & Forgot Password Model
  bool get isForgotPasswordLoading => _isForgotPasswordLoading.value;
  ForgotPasswordModel get forgotPasswordModel => _forgotPasswordModel;

  ///* Forgot Password Api Process
  Future<ForgotPasswordModel> forgotPasswordProcess() async {
    _isForgotPasswordLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'credentials': forgotPasswordEmailAddressController.text.trim(),
    };
    await AuthApiServices.forgotPasswordProcessApi(body: inputBody)
        .then((value) {
      _forgotPasswordModel = value!;
      goToEmailVerification(_forgotPasswordModel.data.token);
      _isForgotPasswordLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isForgotPasswordLoading.value = false;
    update();
    return _forgotPasswordModel;
  }

  final controller = Get.put(OtpVerificationController());
  void goToEmailVerification(String token) {
    Get.back();
    controller.userToken.value = token;
    debugPrint("\u001b[38;5;208____${controller.userToken.value}\u001b[0m____");
    //todo
    Get.toNamed(Routes.otpScreen);
  }
}
