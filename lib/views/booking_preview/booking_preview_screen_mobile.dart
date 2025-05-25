import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart';
import '/backend/local_storage/local_storage.dart';
import '/backend/utils/custom_loading_api.dart';

import '../../utils/basic_screen_imports.dart';
import '../../widgets/booking_car/booking_preview_card_widget.dart';
import '/controller/booking_car/booking_car_controller.dart';

class BookingPreviewMobile extends StatelessWidget {
  BookingPreviewMobile({super.key});
  final controller = Get.put(BookingCarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const PrimaryAppBar(Strings.bookingPreview),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    var data = controller.carBookingModel.data.data;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize * 1.5),
      child: Column(
        children: [
          BookingPreviewCardWidget(
            isActivate: true.obs,
            date: data.pickupDate.day.toString(),
            month: DateFormat('MMM').format(data.pickupDate),
            fromTime: data.pickupTime,
            toTime: '',
          ),
          verticalSpace(Dimensions.heightSize),
          Visibility(
            visible: controller.isCheck.value,
            child: BookingPreviewCardWidget(
              isActivate: false.obs,
              date: data.roundPickupDate.toString() == ''
                  ? ''
                  : DateTime.parse(controller.roundDateController.text)
                      .day
                      .toString(),
              month: data.roundPickupDate.toString() == ''
                  ? ''
                  : DateFormat('MMM').format(
                      DateTime.parse(controller.roundDateController.text)),
              fromTime: data.roundPickupTime.toString(),
              toTime: '',
            ),
          ),
          verticalSpace(Dimensions.heightSize * 2),
          _previewDetailsWidget(context),
          verticalSpace(Dimensions.heightSize * 3.3),
          _buttonWidget(context)
        ],
      ),
    );
  }

  _previewDetailsWidget(BuildContext context) {
    var data = controller.carBookingModel.data.data;
    return Column(
      children: [
        _rowTextWidget(context, Strings.pickUpLocation, data.location),
        _dottedLineWidget(context),
        _rowTextWidget(context, Strings.destination, data.destination),
        _dottedLineWidget(context),
        _rowTextWidget(
            context, Strings.carModel, LocalStorage.getCarName().toString()),
        _dottedLineWidget(context),
        _rowTextWidget(
            context, Strings.carNumber, LocalStorage.getCarNumber().toString()),
        _dottedLineWidget(context),
        _rowTextWidget(context, Strings.rate,
            "${double.parse(LocalStorage.getCarFees()).toStringAsFixed(2)} ${LocalStorage.getCurrencyCode()}"),
      ],
    );
  }

  _rowTextWidget(BuildContext context, String text1, text2) {
    return Row(
      mainAxisAlignment: mainSpaceBet,
      children: [
        TitleHeading3Widget(
          text: text1,
          fontWeight: FontWeight.w500,
          fontSize: Dimensions.headingTextSize6 * 1.5,
          color: Get.isDarkMode
              ? CustomColor.secondaryDarkTextColor
              : CustomColor.secondaryLightTextColor,
        ),
        TitleHeading3Widget(
          fontSize: Dimensions.headingTextSize6 * 1.5,
          text: text2,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  _dottedLineWidget(BuildContext context) {
    return Column(
      children: [
        verticalSpace(Dimensions.heightSize * 0.67),
        const DottedLine(
          dashColor: CustomColor.deactivateColor,
        ),
        verticalSpace(Dimensions.heightSize * 0.67),
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return Obx(() => controller.isConfirmLoading
        ? const CustomLoadingAPI()
        : PrimaryButton(
            title: Strings.confirm,
            onPressed: () {
              controller.carBookingConfirmProcess();
            },
            borderColor: Theme.of(context).primaryColor,
            buttonColor: Theme.of(context).primaryColor));
  }
}
