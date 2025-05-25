import 'package:get/get.dart';

import '../../backend/model/history/history_model.dart';
import '../../backend/services/dashboard/dashbord_api_services.dart';
import '../../backend/utils/api_method.dart';

class HistoryController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    historyProcess();
  }

  /// >> set loading process & dashboard  Model
  final _isLoading = false.obs;
  late HistoryModel _historyModel;

  /// >> get loading process & dashboard  Model
  bool get isLoading => _isLoading.value;
  HistoryModel get historyModel => _historyModel;

  Future<HistoryModel> historyProcess() async {
    _isLoading.value = true;
    update();

    await DashboardApiServices.bookingHistoryProcessApi().then((value) {
      _historyModel = value!;

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _historyModel;
  }
}
