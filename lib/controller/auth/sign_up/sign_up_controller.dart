import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/model/auth/sign_up_model.dart';
import '../../../backend/services/auth/auth_api_services.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';

class SignUpController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final countryController = TextEditingController();

  RxBool agreed = false.obs;
  RxString userToken = ''.obs;
  RxString selectCountryCode = '+1'.obs;

  get onSignUp => signUpProcessApi();
  get onSignIn => Routes.signInScreen;

  /// >> set loading process & Sign Up Model
  final _isLoading = false.obs;
  late SignUpModel _signUpModel;

  /// >> get loading process & Sign Up Model
  bool get isLoading => _isLoading.value;
  SignUpModel get signUpModel => _signUpModel;

  ///* Sign Up Process Api
  Future<SignUpModel> signUpProcessApi() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'email': emailAddressController.text,
      'country': countryController.text,
      'mobile_code': selectCountryCode.value,
      'password': passwordController.text.trim(),
      'agree': 'on',
    };
    await AuthApiServices.signUpProcessApi(body: inputBody).then((value) {
      _signUpModel = value!;
      userToken.value = signUpModel.data.authorization.token;
      debugPrint(userToken.value);
      _goToSavedUser(signUpModel);

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _signUpModel;
  }

  void _goToSavedUser(SignUpModel signUpModel) {
    LocalStorage.saveToken(token: signUpModel.data.token);
    if (signUpModel.data.userInfo.emailVerified == 0) {
      LocalStorage.saveSignUpToken(token: signUpModel.data.authorization.token);
      Get.toNamed(Routes.signUpOtpScreen);
    } else {
      LocalStorage.isLoginSuccess(isLoggedIn: true);
      LocalStorage.saveId(id: signUpModel.data.userInfo.id);
      Get.offNamedUntil(Routes.bottomNavBar, (route) => false);
    }
  }
}
