// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../backend/model/common/common_success_model.dart';
import '../../backend/model/profile/delete_profile_model.dart';
import '../../backend/model/profile/profile_info_model.dart';
import '../../backend/services/profile/profile_api_services.dart';
import '../../backend/utils/api_method.dart';
import '../../utils/basic_screen_imports.dart';

class UpdateProfileController extends GetxController {
  /// >>> Text Editing Controller for update profile
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final sateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final countryController = TextEditingController();
  // final mobileCode = "".obs;

  /// >>> set value for country
  RxString selectCountry = ''.obs;
  RxString selectCountryCode = ''.obs;


  RxString userImagePath = ''.obs;
  RxString userEmailAddress = ''.obs;
  RxString userFullName = ''.obs;
  RxString userImage = ''.obs;
  RxString defaultImage = ''.obs;
  get onUpdateProfile => isImagePathSet.value
      ? profileUpdateWithImageProcess()
      : profileUpdateWithOutImageProcess();
  //-> Image Picker
  RxBool isImagePathSet = false.obs;
  File? image;
  ImagePicker picker = ImagePicker();
  chooseImageFromGallery() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickImage!.path);
    if (image!.path.isNotEmpty) {
      userImagePath.value = image!.path;
      isImagePathSet.value = true;
    }
  }

  chooseImageFromCamera() async {
    var pickImage = await picker.pickImage(source: ImageSource.camera);
    image = File(pickImage!.path);
    if (image!.path.isNotEmpty) {
      userImagePath.value = image!.path;
      isImagePathSet.value = true;
    }
  }

  // get onUpdateProfile => isImagePathSet.value
  //     ? profileUpdateWithImageProcess()
  //     : profileUpdateWithOutImageProcess();
  @override
  void onInit() {
    getProfileInfoProcess();
    super.onInit();
  }

  /// >> set loading process & Profile Info Model
  final _isLoading = false.obs;
  late ProfileInfoModel _profileInfoModel;

  /// >> get loading process & Profile Info Model
  bool get isLoading => _isLoading.value;
  ProfileInfoModel get profileInfoModel => _profileInfoModel;

  ///* Get profile info api process
  Future<ProfileInfoModel> getProfileInfoProcess() async {
    _isLoading.value = true;
    update();

    await ProfileApiServices.getProfileInfoProcessApi().then((value) {
      _profileInfoModel = value!;
      userImage.value = _profileInfoModel.data.userInfo.userImage;
      _setData(_profileInfoModel);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _profileInfoModel;
  }

  void _setData(ProfileInfoModel profileModel) {
    var data = profileModel.data;
    userFullName.value = '${data.userInfo.firstname} ${data.userInfo.lastname}';
    firstNameController.text = data.userInfo.firstname;
    lastNameController.text = data.userInfo.lastname;
    phoneNumberController.text = data.userInfo.mobile;
    addressController.text = data.userInfo.address.address;
    cityController.text = data.userInfo.address.city;
    sateController.text = data.userInfo.address.state;
    zipCodeController.text = data.userInfo.address.zip;
    userEmailAddress.value = data.userInfo.email;
    countryController.text = data.userInfo.country;
    selectCountry.value = data.userInfo.country;
    selectCountryCode.value = data.userInfo.mobileCode;
    userImage.value = data.userInfo.userImage;
    selectCountryCode.value = data.userInfo.mobileCode;
    debugPrint(data.userInfo.country);
    LocalStorage.saveEmail(email: data.userInfo.email);
    LocalStorage.saveName(name: userFullName.value);
    LocalStorage.saveNumber(num: data.userInfo.fullMobile);
    if (data.userInfo.userImage != '') {
      userImage.value = data.userInfo.userImage;
      debugPrint("💪💪💪 ${userImage.value}");
    } else {
      userImage.value = '';
      debugPrint("💪💪💪 not get ${userImage.value}");
    }

    debugPrint(data.userInfo.emailVerified.toString());
    if (data.userInfo.emailVerified == 1) {
      LocalStorage.saveUserVerified(value: true);
    } else {
      LocalStorage.saveUserVerified(value: false);
    }
    update();
  }

  /// >> set loading process & profile update model
  final _isUpdateLoading = false.obs;
  late CommonSuccessModel _profileUpdateModel;

  /// >> get loading process & profile update model
  bool get isUpdateLoading => _isUpdateLoading.value;
  CommonSuccessModel get profileUpdateModel => _profileUpdateModel;

  Future<CommonSuccessModel> profileUpdateWithOutImageProcess() async {
    _isUpdateLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'mobile': phoneNumberController.text,
      'country': countryController.text,
      'city': cityController.text,
      'state': sateController.text,
      'address': addressController.text,
      'mobile_code': selectCountryCode.value,
      'zip': zipCodeController.text,
    };

    await ProfileApiServices.updateProfileWithoutImageApi(body: inputBody)
        .then((value) {
      _profileUpdateModel = value!;
      // getProfileInfoProcess();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isUpdateLoading.value = false;
    update();
    return _profileUpdateModel;
  }

  /// >> set loading process & profile update model
  final _isDeleteLoading = false.obs;
  late DeleteAccountModel _deleteProfileModel;

  /// >> get loading process & profile update model
  bool get isDeleteLoading => _isDeleteLoading.value;
  DeleteAccountModel get deleteProfileModel => _deleteProfileModel;

  Future<DeleteAccountModel> profileDeleteProcess() async {
    _isDeleteLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {

    };

    await ProfileApiServices.deleteProfileAPi(body: inputBody)
        .then((value) {
      _deleteProfileModel = value!;


      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isDeleteLoading.value = false;
    update();
    return _deleteProfileModel;
  }

  // Profile update process with image
  Future<CommonSuccessModel> profileUpdateWithImageProcess() async {
    _isUpdateLoading.value = true;
    update();

    Map<String, String> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'mobile': phoneNumberController.text,
      'country': countryController.text,
      'city': cityController.text,
      'state': sateController.text,
      'address': addressController.text,
      'mobile_code': selectCountryCode.value,
      'zip': zipCodeController.text,
    };

    await ProfileApiServices.updateProfileWithImageApi(
      body: inputBody,
      filepath: userImagePath.value,
    ).then((value) {
      _profileUpdateModel = value!;
      getProfileInfoProcess();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isUpdateLoading.value = false;
    update();
    return _profileUpdateModel;
  }
}
