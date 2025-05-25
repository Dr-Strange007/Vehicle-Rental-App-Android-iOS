import '../../controller/profile/update_profile_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../common/image_picker_widget.dart';
import 'image_picker_sheet.dart';

class UpdateProfileInfoWidget extends StatelessWidget {
  const UpdateProfileInfoWidget({super.key, required this.controller});
  final UpdateProfileController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => ImagePickerWidget(
            isImagePathSet: controller.isImagePathSet.value,
            imagePath: controller.userImagePath.value,
            imageUrl: controller.userImage.value,
            onImagePick: () {
              _showImagePickerBottomSheet(context);
            },
          ),
        ),
      ],
    ).paddingOnly(
      top: Dimensions.paddingSize * 0.4,
    );
  }

  _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: ImagePickerSheet(
            fromCamera: () {
              Get.back();
              controller.chooseImageFromCamera();
            },
            fromGallery: () {
              Get.back();
              controller.chooseImageFromGallery();
            },
          ),
        );
      },
    );
  }
}
