import 'package:get_storage/get_storage.dart';

import '/backend/local_storage/local_storage.dart';
import '../../model/car_booking/booking_verify_model.dart';
import '../../model/car_booking/car_booking_model.dart';
import '../../model/dashboard/booking_mail_otp_resend_model.dart';
import '../../model/dashboard/car_area_list_model.dart';
import '../../model/dashboard/car_area_type_model.dart';
import '../../model/dashboard/car_list_model.dart';
import '../../model/dashboard/car_type_list_model.dart';
import '../../model/dashboard/search_car_model.dart';
import '../../model/history/history_model.dart';
import '../../model/notification/notification_model.dart';
import '../../model/profile/profile_info_model.dart';
import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';

class DashboardApiServices {
  ///* dashboard api Process Api
  static Future<ProfileInfoModel?> dashboardApiProcess() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .get(ApiEndpoint.dashboardURL, code: 200, showResult: true);
      if (mapResponse != null) {
        ProfileInfoModel result = ProfileInfoModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from dashboard api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* car list api process api Process Api
  static Future<CarListModel?> carListProcess() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: !LocalStorage.isLoggedIn())
          .get(ApiEndpoint.carListURL, code: 200, showResult: true);
      if (mapResponse != null) {
        CarListModel result = CarListModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from car list service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* car type list api process api Process Api
  static Future<CarTypeListModel?> carTypeListProcess() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: !LocalStorage.isLoggedIn())
          .get(ApiEndpoint.carTypeListURL, code: 200, showResult: true);
      if (mapResponse != null) {
        CarTypeListModel result = CarTypeListModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from car type list service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* car area list api process api Process Api
  static Future<CarAreaListModel?> carAreaListProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: !LocalStorage.isLoggedIn())
          .get(ApiEndpoint.carAreaListURL, code: 200, showResult: true);
      if (mapResponse != null) {
        CarAreaListModel result = CarAreaListModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from car area list service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* car booking list url
  static Future<CarBookingModel?> carBookingProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: !LocalStorage.isLoggedIn()).post(
        ApiEndpoint.carBookingURL,
        code: 200,
        body,
      );
      if (mapResponse != null) {
        CarBookingModel result = CarBookingModel.fromJson(mapResponse);
        CustomSnackBar.success(
          result.message.success.first.toString(),
        );
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from car booking api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* car booking confirm url
  static Future<CarBookingModel?> carBookingConfirmApi(
      {required String token}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: !LocalStorage.isLoggedIn()).get(
          "${ApiEndpoint.carBookingConfirm}$token&lang=${GetStorage().read('selectedLanguage')}",
          code: 200,
          duration: 120);
      if (mapResponse != null) {
        CarBookingModel result = CarBookingModel.fromJson(mapResponse);
        CustomSnackBar.success(
          result.message.success.first.toString(),
        );
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from car booking confirm api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Forgot Password Process Api
  static Future<BookingVerifyModel?> bookingVerificationProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: !LocalStorage.isLoggedIn()).post(
        ApiEndpoint.carBookingVerificationURL,
        code: 200,
        body,
      );
      if (mapResponse != null) {
        BookingVerifyModel result = BookingVerifyModel.fromJson(mapResponse);
        // CustomSnackBar.success(
        //   result.message.success.success.first.toString(),
        // );
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from forgot password api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Forgot Password Process Api
  ///todo check
  static Future<BookingMailOtpResendModel?> resentOtpProcess(
      {required String token}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: !LocalStorage.isLoggedIn()).get(
        "${ApiEndpoint.bookingResendURL}$token&lang=${GetStorage().read('selectedLanguage')}",
        code: 200,
      );
      if (mapResponse != null) {
        BookingMailOtpResendModel result =
            BookingMailOtpResendModel.fromJson(mapResponse);
        CustomSnackBar.success(
          result.message.success.success.first.toString(),
        );
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from forgot password api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* car area type url
  static Future<CarAreaTypeModel?> carAreaTypesApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: !LocalStorage.isLoggedIn()).post(
        ApiEndpoint.carAreaTypesURL,
        code: 200,
        body,
        showResult: true,
      );
      if (mapResponse != null) {
        CarAreaTypeModel result = CarAreaTypeModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from car area type service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* car area type url
  static Future<SearchCarModel?> carSearchApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: !LocalStorage.isLoggedIn()).post(
        ApiEndpoint.carSearchURL,
        code: 200,
        body,
        showResult: true,
      );
      if (mapResponse != null) {
        SearchCarModel result = SearchCarModel.fromJson(mapResponse);
        // CustomSnackBar.success(
        //   result.message.success.first.toString(),
        // );
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from car search service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* car history url
  static Future<HistoryModel?> bookingHistoryProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: !LocalStorage.isLoggedIn()).get(
        ApiEndpoint.historyURL,
        code: 200,
      );
      if (mapResponse != null) {
        HistoryModel result = HistoryModel.fromJson(mapResponse);
        // CustomSnackBar.success(
        //   result.message.success.first.toString(),
        // );
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from car booking history api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* car history url
  static Future<NotificationModel?> notificationProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: !LocalStorage.isLoggedIn()).get(
        ApiEndpoint.notificationURL,
        code: 200,
      );
      if (mapResponse != null) {
        NotificationModel result = NotificationModel.fromJson(mapResponse);
        CustomSnackBar.success(
          result.message.success.first.toString(),
        );
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from car booking history api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
