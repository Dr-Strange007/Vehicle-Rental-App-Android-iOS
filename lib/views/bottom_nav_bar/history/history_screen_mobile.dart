import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import '/backend/local_storage/local_storage.dart';
import '/backend/utils/custom_loading_api.dart';

import '../../../controller/history/history_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/history/history_card_widget.dart';
import '../../../widgets/notification/custom_list_view_animation.dart';

class HistoryScreenMobile extends StatelessWidget {
  HistoryScreenMobile({super.key});
  final controller = Get.put(HistoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    var data = controller.historyModel.data;
    return AnimationLimiter(
      child: data.isEmpty
          ? const Center(
              child: TitleHeading3Widget(text: Strings.noDataFound))
          : ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.widthSize * 1.7,
              ),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomListViewAnimation(
                  index: index,
                  child: HistoryCardWidget(
                    pickUpPoint: data[index].location,
                    destination: data[index].destination,
                    pickupTime:
                        DateFormat('yyyy/MM/dd').format(data[index].pickupDate),
                    destinationTime: data[index].roundPickupDate.toString(),
                    status: data[index].status == 1
                        ? Strings.pending
                        : Strings.accepted,
                    amount:
                        "${double.parse(data[index].cars.fees).toStringAsFixed(2)} ${LocalStorage.getCurrencyCode()}",
                    carName: data[index].cars.carModel,
                  ),
                );
              },
            ).paddingOnly(bottom: Dimensions.heightSize * 6),
    );
  }
}
