import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/model/dashboard/car_area_list_model.dart';
import '../../../backend/model/dashboard/car_type_list_model.dart';
import '../../../backend/model/dashboard/search_car_model.dart';
import '../../../backend/model/profile/profile_info_model.dart';
import '../../../backend/services/dashboard/dashbord_api_services.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/dashboard/car_booking_widget.dart';
import '/backend/model/dashboard/car_area_type_model.dart';
import '/backend/model/dashboard/car_list_model.dart' as car;
import '/backend/services/api_endpoint.dart';

class DashboardController extends GetxController {
  List<String> area = [];
  List<String> areaId = [];
  List<String> type = [];
  List<String> typeId = [];
  RxString selectArea = Strings.selectArea.obs;
  RxString selectId = "".obs;
  RxString selectType = Strings.selectType.obs;
  RxString selectTypeId = "".obs;
  final List<Widget> widgets = [];
  RxBool isFilterSearch = false.obs;

  @override
  void onInit() {
    super.onInit();
    carListProcess();
    carAreaListProcess();
  }

  /// >> set loading process & dashboard  Model
  final _isLoading = false.obs;
  late ProfileInfoModel _dashboardModel;

  /// >> get loading process & dashboard  Model
  bool get isLoading => _isLoading.value;
  ProfileInfoModel get forgotPasswordModel => _dashboardModel;

  Future<ProfileInfoModel> dashboardProcess() async {
    _isLoading.value = true;
    update();

    await DashboardApiServices.dashboardApiProcess().then((value) {
      _dashboardModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _dashboardModel;
  }

  /// car list process
  final _isCarListLoading = false.obs;
  bool get isCarListLoading => _isCarListLoading.value;
  late car.CarListModel _carListModel;
  car.CarListModel get carListModel => _carListModel;

  RxList<car.Car> carList = <car.Car>[].obs;
  final searchController = TextEditingController();

  Future<car.CarListModel> carListProcess() async {
    _isCarListLoading.value = true;
    update();

    await DashboardApiServices.carListProcess().then((value) {
      _carListModel = value!;
      widgets.clear();
      var data = _carListModel.data.cars.cars;
      carList.value = data;
      for (var index = 0; index < data.length; index++) {
        widgets.add(CarBookingWidget(
          onTap: () {
            Get.toNamed(Routes.bookingCarScreen);
            LocalStorage.saveCarId(id: data[index].slug);
            LocalStorage.saveCarName(id: data[index].carModel);
            LocalStorage.saveCarNumber(id: data[index].carNumber);
            LocalStorage.saveCarFees(id: data[index].fees);
          },
          experience: data[index].experience.toString(),
          carName: data[index].carModel,
          carNumber: data[index].carNumber,
          carSeat: data[index].seat.toString(),
          carFees:
              "${double.parse(data[index].fees).toStringAsFixed(2)} ${LocalStorage.getCurrencyCode()}",
          imagePath:
              "${ApiEndpoint.mainDomain}/${_carListModel.data.cars.imagePath}/${data[index].image}",
        ));
      }
      _isCarListLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isCarListLoading.value = false;
    update();
    return _carListModel;
  }

  /// car list process

  late CarTypeListModel _carTypeListModel;
  CarTypeListModel get carTypeListModel => _carTypeListModel;
  Future<CarTypeListModel> carTypeListProcess() async {
    _isCarListLoading.value = true;
    update();

    await DashboardApiServices.carTypeListProcess().then((value) {
      _carTypeListModel = value!;
      var data = _carTypeListModel.data;

      for (var index = 0; index < data.length; index++) {
        type.add(data[index].name);
        debugPrint(type.first);
      }

      _isCarListLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isCarListLoading.value = false;
    update();
    return _carTypeListModel;
  }

  /// car area list process
  final _isAreaLoading = false.obs;
  bool get isAreaLoading => _isAreaLoading.value;

  late CarAreaListModel _carAreaListModel;
  CarAreaListModel get carAreaListModel => _carAreaListModel;
  Future<CarAreaListModel> carAreaListProcess() async {
    _isAreaLoading.value = true;
    update();

    await DashboardApiServices.carAreaListProcessApi().then((value) {
      _carAreaListModel = value!;
      var data = _carAreaListModel.data;

      for (var index = 0; index < data.length; index++) {
        area.add(data[index].name);
        areaId.add(data[index].id.toString());
      }

      _isAreaLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isAreaLoading.value = false;
    update();
    return _carAreaListModel;
  }

  ///
  final _isCarAreaTypeLoading = false.obs;
  late CarAreaTypeModel _carAreaTypeModel;

  /// >> get loading process & Forgot Password Model
  bool get isCarAreaTypeLoading => _isCarAreaTypeLoading.value;
  CarAreaTypeModel get carAreaTypeModel => _carAreaTypeModel;

  ///* Forgot Password Api Process
  Future<CarAreaTypeModel> carAreaTypeProcess(String id) async {
    _isCarAreaTypeLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {"area": id};
    await DashboardApiServices.carAreaTypesApi(body: inputBody).then((value) {
      _carAreaTypeModel = value!;
      var data = _carAreaTypeModel.data.area.types;
      type.clear();
      typeId.clear();
      for (int index = 0; index < data.length; index++) {
        type.add(data[index].type.name);
        typeId.add(data[index].carTypeId.toString());
      }
      _isCarAreaTypeLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isCarAreaTypeLoading.value = false;
    update();
    return _carAreaTypeModel;
  }

  ///car search api process
  final _isCarSearchLoading = false.obs;
  late SearchCarModel _searchCarModel;

  /// >> get loading process & Forgot Password Model
  bool get isCarSearchLoading => _isCarSearchLoading.value;
  SearchCarModel get searchCarModel => _searchCarModel;

  ///* Forgot Password Api Process
  Future<SearchCarModel> carSearchProcess(String id, typeId) async {
    _isCarSearchLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {"area": id, 'type': typeId};
    await DashboardApiServices.carSearchApi(body: inputBody).then((value) {
      _searchCarModel = value!;

      _isCarSearchLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isCarSearchLoading.value = false;
    update();
    return _searchCarModel;
  }
}
