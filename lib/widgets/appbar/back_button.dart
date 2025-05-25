import '../../utils/basic_widget_imports.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return IconButton(
      onPressed: onTap,
      icon: Container(
        height: isTablet() ? MediaQuery.sizeOf(context).height * .13 : 26.h,
        width: isTablet() ? MediaQuery.sizeOf(context).width * .23 : 28.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: Dimensions.iconSizeDefault * 0.9,
            ),
          ],
        ),
      ),
    );
  }
}
