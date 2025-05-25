import '../../backend/local_storage/local_storage.dart';
import '../../backend/services/api_endpoint.dart';
import '../../controller/bottom_nav_bar/dashboard/dashboard_controller.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/dashboard/car_details_widget.dart';

class VehicleListScreenMobile extends StatelessWidget {
  VehicleListScreenMobile({super.key});

  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(Strings.rentVehicle),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    var data = controller.carListModel.data.cars.cars;
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.widthSize * 1.7,
      ),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // mainAxisExtent: isTablet()?  300 : 240,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: isTablet() ? .8 : .7,
        // mainAxisSpacing: 10,
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
    );
  }
}
