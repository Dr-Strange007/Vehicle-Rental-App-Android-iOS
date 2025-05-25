import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../views/congratulation/congratulation_screen.dart';
import '../../backend/model/common/common_success_model.dart';
import '../../backend/services/auth/auth_api_services.dart';
import '../../backend/utils/api_method.dart';

class ChangePasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _goToSignInScreen() {
    Get.to(
      () => CongratulationScreen(
        route: Routes.bottomNavBar,
        subTitle: Strings.yourPasswordHas,
        title: Strings.congratulations,
      ),
    );
  }




  /// >> set loading process & Reset Password Model
  final _isLoading = false.obs;
  late CommonSuccessModel _resetPasswordModel;

  /// >> set loading process & Reset Password Model
  bool get isLoading => _isLoading.value;
  CommonSuccessModel get resetPasswordModel => _resetPasswordModel;

  ///* Change password process
  Future<CommonSuccessModel> changePasswordProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'current_password': oldPasswordController.text,
      'password': newPasswordController.text,
      'password_confirmation': confirmPasswordController.text
    };

    await AuthApiServices.changePasswordApi(body: inputBody).then((value) {
      _resetPasswordModel = value!;

      _goToSignInScreen();

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _resetPasswordModel;
  }
}
