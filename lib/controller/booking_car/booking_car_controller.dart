import '/backend/local_storage/local_storage.dart';
import '/backend/services/dashboard/dashbord_api_services.dart';

import '../../backend/model/car_booking/car_booking_model.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../date_picker/date_picker_controller.dart';

class BookingCarController extends GetxController {
  final datePickerController = Get.put(DatePickerController());
  final locationController = TextEditingController();
  final destinationController = TextEditingController();
  final emailController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final noteController = TextEditingController();
  final mobileController = TextEditingController();
  final roundDateController = TextEditingController();
  final roundTimeController = TextEditingController();
  RxBool isCheck = false.obs;

  var carToken = ''.obs;

  final _isLoading = false.obs;
  late CarBookingModel _carBookingModel;

  bool get isLoading => _isLoading.value;
  CarBookingModel get carBookingModel => _carBookingModel;

  ///* Sign in process
  Future<CarBookingModel> carBookingProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      "car": LocalStorage.getCarId().toString(),
      "location": locationController.text,
      "destination": destinationController.text,
      "credentials": emailController.text,
      'pickup_time': timeController.text,
      'pickup_date': dateController.text,
      'mobile': mobileController.text,
      'round_pickup_date': roundDateController.text,
      'round_pickup_time': roundTimeController.text,
      'message': noteController.text,
    };

    await DashboardApiServices.carBookingProcessApi(body: inputBody)
        .then((value) {
      _carBookingModel = value!;
      carToken.value = _carBookingModel.data.token;
      goToCarBookingScreen();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _carBookingModel;
  }

  final _isConfirmLoading = false.obs;
  late CarBookingModel _carConfirmModel;

  bool get isConfirmLoading => _isConfirmLoading.value;
  CarBookingModel get carBookingConfirmModel => _carConfirmModel;

  ///* Car booking confirm process
  Future<CarBookingModel> carBookingConfirmProcess() async {
    _isConfirmLoading.value = true;
    update();

    await DashboardApiServices.carBookingConfirmApi(token: carToken.value)
        .then((value) {
      _carConfirmModel = value!;

      gotoVerificationScreen();
      _isConfirmLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isConfirmLoading.value = false;
    update();
    return _carConfirmModel;
  }

  void goToCarBookingScreen() {
    Get.toNamed(Routes.bookingPreviewScreen);
  }

  void gotoVerificationScreen() {
    Get.toNamed(Routes.bookingVerificationScreen);
  }
}
