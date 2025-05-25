import 'package:material_symbols_icons/symbols.dart';

import '/backend/local_storage/local_storage.dart';
import '/backend/utils/custom_loading_api.dart';
import '/controller/booking_car/booking_car_controller.dart';
import '/controller/profile/update_profile_controller.dart';
import '/widgets/text_labels/title_heading5_widget.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/inputs/primary_input_widget.dart';

class BookingCarScreenMobile extends StatelessWidget {
  BookingCarScreenMobile({super.key});

  final controller = Get.put(BookingCarController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(Strings.bookingACar),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize * 2),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _inputFieldWidget(context),
            verticalSpace(Dimensions.heightSize * 3.33),
            _buttonWidget(context),
            verticalSpace(Dimensions.heightSize),
          ],
        ),
      ),
    );
  }

  _inputFieldWidget(BuildContext context) {
    controller.emailController.text = LocalStorage.isLoggedIn()
        ? Get.find<UpdateProfileController>().userEmailAddress.value
        : '';
    return Form(
      child: Column(
        children: [
          PrimaryInputWidget(
            controller: controller.locationController,
            hintText: Strings.enterPickUpLocation,
            label: Strings.pickUpLocation,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.emailAddress,
          ),
          verticalSpace(Dimensions.heightSize * 1.333),
          PrimaryInputWidget(
            controller: controller.destinationController,
            hintText: Strings.enterDestination,
            label: Strings.destination,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.emailAddress,
          ),
          verticalSpace(Dimensions.heightSize * 1.333),
          PrimaryInputWidget(
            controller: controller.emailController,
            hintText: Strings.enterEmailAddress,
            label: Strings.emailAddress,
            readOnly: LocalStorage.isLoggedIn(),
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.emailAddress,
          ),
          verticalSpace(Dimensions.heightSize * 1.333),
          PrimaryInputWidget(
            controller: controller.mobileController,
            hintText: Strings.enterPhoneNumber,
            label: Strings.phone,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.number,
          ),
          verticalSpace(Dimensions.heightSize * 1.333),
          _datePickerWidgets(context),
          verticalSpace(Dimensions.heightSize * 1.333),
          _noteWidget(context),
        ],
      ),
    );
  }

  _datePickerWidgets(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        Row(
          children: [
            Expanded(
              child: PrimaryInputWidget(
                controller: controller.dateController,
                hintText: Strings.dateHint,
                label: Strings.pickUpDate,
                fillColor: CustomColor.whiteColor,
                readOnly: true,
                isDate: true,
                suffixIcon: const Icon(Symbols.calendar_today),
                textInputType: TextInputType.emailAddress,
              ),
            ),
            horizontalSpace(Dimensions.widthSize),
            Expanded(
              child: PrimaryInputWidget(
                controller: controller.timeController,
                hintText: Strings.dateHint,
                label: Strings.pickUpTime,
                fillColor: CustomColor.whiteColor,
                isDate: true,
                readOnly: true,
                isTime: true,
                suffixIcon: const Icon(Symbols.schedule),
                textInputType: TextInputType.emailAddress,
              ),
            ),
          ],
        ),
        verticalSpace(Dimensions.heightSize * 1.333),
        Obx(
          () => Row(
            mainAxisAlignment: mainStart,
            children: [
              SizedBox(
                height: 24.0.h,
                width: 24.0.w,
                child: Checkbox(
                  value: controller.isCheck.value,
                  onChanged: (value) {
                    controller.isCheck.value = value!;
                  },
                  activeColor: Theme.of(context).primaryColor,
                  checkColor: controller.isCheck.value
                      ? CustomColor.primaryBGLightColor
                      : null,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius * 0.2),
                  ),
                  side: BorderSide(
                    color: Get.isDarkMode
                        ? CustomColor.primaryDarkTextColor.withOpacity(0.50)
                        : CustomColor.primaryLightTextColor.withOpacity(0.50),
                  ),
                ),
              ),
              TitleHeading5Widget(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize),
                text: Strings.roundTrip,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode
                    ? CustomColor.secondaryDarkTextColor
                    : CustomColor.secondaryLightTextColor,
              )
            ],
          ),
        ),
        Obx(
          () => Visibility(
            visible: controller.isCheck.value,
            child: Row(
              children: [
                Expanded(
                  child: PrimaryInputWidget(
                    controller: controller.roundDateController,
                    hintText: Strings.dateHint,
                    label: Strings.pickUpDate,
                    fillColor: CustomColor.whiteColor,
                    readOnly: true,
                    isDate: true,
                    suffixIcon: const Icon(Symbols.calendar_today),
                    textInputType: TextInputType.emailAddress,
                  ),
                ),
                horizontalSpace(Dimensions.widthSize),
                Expanded(
                  child: PrimaryInputWidget(
                    controller: controller.roundTimeController,
                    hintText: Strings.dateHint,
                    label: Strings.pickUpTime,
                    fillColor: CustomColor.whiteColor,
                    isDate: true,
                    isTime: true,
                    readOnly: true,
                    suffixIcon: const Icon(Symbols.schedule),
                    textInputType: TextInputType.emailAddress,
                  ),
                ),
              ],
            ).paddingOnly(top: Dimensions.heightSize * 1.33),
          ),
        )
      ],
    );
  }

  _noteWidget(BuildContext context) {
    return PrimaryInputWidget(
      controller: controller.noteController,
      isValidator: false,
      hintText: Strings.writeHere,
      maxLines: 4,
      label: Strings.note,
      fillColor: CustomColor.whiteColor,
      textInputType: TextInputType.emailAddress,
    );
  }

  _buttonWidget(BuildContext context) {
    return Obx(() => controller.isLoading
        ? const CustomLoadingAPI()
        : PrimaryButton(
            title: Strings.sendBookingRequest,
            onPressed: () {
              controller.carBookingProcess();
            },
            borderColor: Theme.of(context).primaryColor,
            buttonColor: Theme.of(context).primaryColor));
  }
}
