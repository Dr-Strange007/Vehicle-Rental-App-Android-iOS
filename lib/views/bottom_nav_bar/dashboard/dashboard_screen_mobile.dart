import '/language/language_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/common/search_input_widget.dart';
import '../../../widgets/dashboard/car_details_widget.dart';
import '../../../widgets/dashboard/carousel_slider_widget.dart';
import '../../../widgets/profile/drop_down_widget.dart';
import './/controller/bottom_nav_bar/dashboard/dashboard_controller.dart';
import '/backend/local_storage/local_storage.dart';
import '/backend/services/api_endpoint.dart';
import '/backend/utils/custom_loading_api.dart';
import '/extensions/custom_extensions.dart';

class DashboardScreenMobile extends StatelessWidget {
  DashboardScreenMobile({super.key});

  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isLoading ||
              controller.isCarListLoading ||
              controller.isAreaLoading ||
              controller.isCarSearchLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.carListProcess();
        controller.isFilterSearch.value = false;
      },
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize * 1.5),
        child: controller.carListModel.data.cars.cars.isEmpty
            ? Column(
                children: [
                  verticalSpace(Dimensions.heightSize),
                  const Expanded(
                    child: Center(
                        child: TitleHeading3Widget(text: Strings.noDataFound)),
                  ),
                ],
              )
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    verticalSpace(Dimensions.heightSize),
                    _searchWidget(context),
                    verticalSpace(Dimensions.heightSize),
                    _carFeatureWidget(context),
                    verticalSpace(Dimensions.heightSize * 0.5),
                    _rentTextWidget(context),
                    verticalSpace(Dimensions.heightSize * 0.75),
                    Obx(() => controller.isFilterSearch.isFalse
                        ? _carDetailsWidget(context)
                        : _carSearchWidget(context)),
                  ],
                ),
              ),
      ),
    );
  }

  _searchWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Obx(() => Get.find<LanguageController>().isLoading
              ? SearchInputWidget(
                  controller: controller.searchController,
                  hintText: Strings.searchHere,
                  onFieldSubmitted: (value) {
                    controller.isFilterSearch.value = false;
                    controller.selectTypeId.value = "";
                    controller.selectType.value = Strings.selectType;
                    controller.selectId.value = "";
                    controller.selectArea.value = Strings.selectArea;

                    if (value.isEmpty) {
                      controller.carList.value =
                          controller.carListModel.data.cars.cars;
                    } else {
                      controller.carList.value = controller
                          .carListModel.data.cars.cars
                          .where((element) => element.carModel
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();

                      if (controller.carList.isEmpty) {}
                    }
                  },
                )
              : SearchInputWidget(
                  controller: controller.searchController,
                  hintText: Strings.searchHere,
                  onFieldSubmitted: (value) {
                    controller.isFilterSearch.value = false;
                    controller.selectTypeId.value = "";
                    controller.selectType.value = Strings.selectType;
                    controller.selectId.value = "";
                    controller.selectArea.value = Strings.selectArea;

                    if (value.isEmpty) {
                      controller.carList.value =
                          controller.carListModel.data.cars.cars;
                    } else {
                      controller.carList.value = controller
                          .carListModel.data.cars.cars
                          .where((element) => element.carModel
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();

                      if (controller.carList.isEmpty) {}
                    }
                  },
                )),
        ),
        horizontalSpace(Dimensions.widthSize),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              controller.searchController.clear();
              controller.carList.value = controller.carListModel.data.cars.cars;
              _showFilterWidget(context);
            },
            child: Container(
              width: Dimensions.widthSize * 5.2,
              height: Dimensions.heightSize * 4,
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? CustomColor.primaryDarkColor
                    : CustomColor.primaryLightColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Dimensions.radius,
                  ),
                ),
              ),
              child: Icon(
                Icons.tune,
                color: Get.isDarkMode
                    ? CustomColor.blackColor
                    : CustomColor.whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _carFeatureWidget(BuildContext context) {
    return MyCarouselSlider(
      controller: controller,
    );
  }

  _rentTextWidget(BuildContext context) {
    return Visibility(
      visible: controller.carList.isNotEmpty,
      child: Row(
        mainAxisAlignment: mainSpaceBet,
        children: [
          const TitleHeading3Widget(
            text: Strings.rentVehicle,
            fontWeight: FontWeight.w600,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.vehicleListScreen);
            },
            child: TitleHeading3Widget(
              text: Strings.viewMore,
              fontSize: Dimensions.headingTextSize6,
              fontWeight: FontWeight.w600,
              color: Get.isDarkMode
                  ? CustomColor.primaryDarkColor
                  : CustomColor.primaryLightColor,
            ),
          )
        ],
      ),
    );
  }

  _carDetailsWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Obx(() => controller.carList.isEmpty ||
            Get.find<LanguageController>().isLoading
        ? const Center(child: TitleHeading3Widget(text: Strings.noDataFound))
        : GridView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: isTablet() ? .8 : .7,
            ),
            itemCount: controller.carList.length,
            itemBuilder: (context, index) {
              return CarDetailsWidget(
                onTap: () {
                  Get.toNamed(Routes.bookingCarScreen);
                  LocalStorage.saveCarId(id: controller.carList[index].slug);
                  LocalStorage.saveCarName(
                      id: controller.carList[index].carModel);
                  LocalStorage.saveCarNumber(
                      id: controller.carList[index].carNumber);
                  LocalStorage.saveCarFees(id: controller.carList[index].fees);
                },
                experience: controller.carList[index].experience.toString(),
                carName: controller.carList[index].carModel,
                carNumber: controller.carList[index].carNumber,
                carSeat: controller.carList[index].seat.toString(),
                carFees:
                    "${double.parse(controller.carList[index].fees).toStringAsFixed(2)} ${LocalStorage.getCurrencyCode()}",
                imagePath:
                    "${ApiEndpoint.mainDomain}/${controller.carListModel.data.cars.imagePath}/${controller.carList[index].image}",
              );
            },
          ));
  }

  _carSearchWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    var data = controller.searchCarModel.data.cars.cars;
    return data.isEmpty
        ? Center(
            child: TitleHeading3Widget(
            text: Strings.noDataFound,
            padding: EdgeInsets.only(top: Dimensions.heightSize),
          ))
        : Obx(() => controller.isCarSearchLoading ||
                Get.find<LanguageController>().isLoading
            ? const CustomLoadingAPI()
            : GridView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: isTablet() ? .8 : .7,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return CarDetailsWidget(
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
                        "${ApiEndpoint.mainDomain}/${controller.carListModel.data.cars.imagePath}/${data[index].image}",
                  );
                },
              ));
  }

  void _showFilterWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: isTablet()
              ? MediaQuery.sizeOf(context).height * 0.45
              : MediaQuery.sizeOf(context).height * 0.38,
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.widthSize * 2.5,
              vertical: Dimensions.heightSize * 2),
          decoration: BoxDecoration(
            color: CustomColor.primaryLightScaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius * 2),
              topRight: Radius.circular(Dimensions.radius * 2),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: mainSpaceBet,
                children: [
                  TitleHeading3Widget(text: Strings.filter.tr),
                  Row(
                    children: [
                      Obx(() => Visibility(
                            visible: controller.isFilterSearch.isTrue,
                            child: GestureDetector(
                              onTap: () {
                                controller.isFilterSearch.value = false;
                                controller.selectTypeId.value = "";
                                controller.selectType.value =
                                    Strings.selectType;
                                controller.selectId.value = "";
                                controller.selectArea.value =
                                    Strings.selectArea;
                                Get.close(1);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TitleHeading3Widget(
                                  text: Strings.clearAll,
                                  fontSize: Dimensions.headingTextSize6,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          )),
                      GestureDetector(
                        onTap: () {
                          Get.close(1);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TitleHeading3Widget(
                            text: Strings.close,
                            fontSize: Dimensions.headingTextSize6,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              verticalSpace(Dimensions.heightSize),
              Row(
                children: [
                  Expanded(
                    child: CustomDropDownButton(
                      itemsList: controller.area,
                      selectMethod: controller.selectArea,
                      onChanged: (p0) {
                        controller.selectArea.value = p0!;
                        for (var i = 0; i < controller.area.length; i++) {
                          if (controller.area[i] ==
                              controller.selectArea.value) {
                            controller.selectId.value = controller.areaId[i];
                          }
                        }
                        controller
                            .carAreaTypeProcess(controller.selectId.value);
                      },
                      label: Strings.area,
                    ),
                  ),
                  horizontalSpace(Dimensions.widthSize),
                  Expanded(
                    child: Obx(() => controller.isCarAreaTypeLoading
                        ? CustomDropDownButton(
                            itemsList: controller.type,
                            selectMethod: controller.selectType,
                            onChanged: (p0) {
                              controller.selectType.value = p0!;
                              for (var i = 0; i < controller.type.length; i++) {
                                if (controller.type[i] ==
                                    controller.selectType.value) {
                                  controller.selectTypeId.value =
                                      controller.typeId[i];
                                }
                              }
                            },
                            label: Strings.type,
                          )
                        : CustomDropDownButton(
                            itemsList: controller.type,
                            selectMethod: controller.selectType,
                            onChanged: (p0) {
                              controller.selectType.value = p0!;
                              for (var i = 0; i < controller.type.length; i++) {
                                if (controller.type[i] ==
                                    controller.selectType.value) {
                                  controller.selectTypeId.value =
                                      controller.typeId[i];
                                }
                              }
                            },
                            label: Strings.type,
                          )),
                  ),
                ],
              ),
              verticalSpace(Dimensions.heightSize * 1.333),
              _buttonWidget(context)
            ],
          ),
        ).customGlassWidget();
      },
    );
  }

  _buttonWidget(BuildContext context) {
    return PrimaryButton(
        title: Strings.filter,
        onPressed: () {
          controller.carSearchProcess(
              controller.selectId.value, controller.selectTypeId.value);
          controller.isFilterSearch.value = true;
          Get.close(1);
        },
        borderColor: Theme.of(context).primaryColor,
        buttonColor: Theme.of(context).primaryColor);
  }

//experience text widget
}
